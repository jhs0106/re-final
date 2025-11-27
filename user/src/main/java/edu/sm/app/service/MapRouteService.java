package edu.sm.app.service;

import com.graphhopper.GHRequest;
import com.graphhopper.GHResponse;
import com.graphhopper.GraphHopper;
import com.graphhopper.ResponsePath;
import com.graphhopper.util.PointList;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MapRouteService {

    private final GraphHopper hopper;

    public MapRouteService(GraphHopper hopper) {
        this.hopper = hopper;
    }
    private List<GeoPoint> alignStartToCenter(List<GeoPoint> points,
                                              double centerLat,
                                              double centerLon) {
        if (points == null || points.isEmpty()) return points;

        int bestIdx = 0;
        double bestDist = Double.MAX_VALUE;

        // center 에 가장 가까운 포인트 찾기
        for (int i = 0; i < points.size(); i++) {
            GeoPoint p = points.get(i);
            double dLat = p.lat - centerLat;
            double dLon = p.lon - centerLon;
            double dist2 = dLat * dLat + dLon * dLon;
            if (dist2 < bestDist) {
                bestDist = dist2;
                bestIdx = i;
            }
        }

        // 그 포인트가 0번이 되도록 시계 방향 회전
        List<GeoPoint> rotated = new ArrayList<>();
        for (int i = 0; i < points.size(); i++) {
            rotated.add(points.get((bestIdx + i) % points.size()));
        }

        // 시작 포인트를 "정확히" center 로 맞추기
        rotated.set(0, new GeoPoint(centerLat, centerLon));
        return rotated;
    }
    /**
     * 기본: 도형 크기(sizeKm)를 직접 넣어서 경로 생성
     */
    public ShapeRouteResponse getShapeRoute(String type,
                                            double centerLat,
                                            double centerLon,
                                            double sizeKm) {

        if (sizeKm <= 0) sizeKm = 1.2;

        List<GeoPoint> basePoints;
        if ("heart".equalsIgnoreCase(type)) {
            basePoints = generateHeartPoints(centerLat, centerLon, sizeKm);
        } else {
            basePoints = generateCirclePoints(centerLat, centerLon, sizeKm);
        }

        return buildRouteFromBasePoints(basePoints);
    }

    /**
     * ✅ 목표 거리(km)를 기준으로 sizeKm를 자동으로 튜닝해서
     *    목표에 최대한 가까운 코스를 찾아줌
     */
    public ShapeRouteResponse getShapeRouteByTargetKm(String type,
                                                      double centerLat,
                                                      double centerLon,
                                                      double targetKm) {
        if (targetKm <= 0) {
            targetKm = 4.0;
        }

        double sizeKm = targetKm;  // 처음엔 목표 거리 정도로 시작
        ShapeRouteResponse best = null;
        double bestDiff = Double.MAX_VALUE;

        // 간단한 반복 튜닝 (5~6번)
        for (int i = 0; i < 6; i++) {
            ShapeRouteResponse res = getShapeRoute(type, centerLat, centerLon, sizeKm);
            if (res.getDistanceKm() <= 0) break;

            double diff = Math.abs(res.getDistanceKm() - targetKm);
            if (diff < bestDiff) {
                bestDiff = diff;
                best = res;
            }

            double ratio = targetKm / res.getDistanceKm();
            sizeKm = sizeKm * ratio;
        }

        return best;
    }

    /**
     * ✅ 사용자 위치 주변에 후보 중심 좌표 여러 개 생성 (동/서/남/북 + 대각선 등)
     */
    private List<LatLon> buildCandidateCenters(double userLat,
                                               double userLon,
                                               double targetKm,
                                               int candidateCount) {

        List<LatLon> list = new ArrayList<>();

        // 반경: 목표거리의 1/3 정도를 중심 이동량으로 사용
        double radiusKm = targetKm / 3.0;
        double kmToLat = 1.0 / 111.0;
        double kmToLon = 1.0 / (111.0 * Math.cos(Math.toRadians(userLat)));

        // 8방향 (N, NE, E, SE, S, SW, W, NW)
        double[][] dirs = {
                { 0,  1},  // N
                { 1,  1},  // NE
                { 1,  0},  // E
                { 1, -1},  // SE
                { 0, -1},  // S
                {-1, -1},  // SW
                {-1,  0},  // W
                {-1,  1}   // NW
        };

        for (int i = 0; i < dirs.length && list.size() < candidateCount; i++) {
            double dxKm = dirs[i][0] * radiusKm;
            double dyKm = dirs[i][1] * radiusKm;

            double lat = userLat + dyKm * kmToLat;
            double lon = userLon + dxKm * kmToLon;

            list.add(new LatLon(lat, lon));
        }

        // 항상 "사용자 위치 바로 근처 중심"도 하나 넣어주기
        if (list.size() < candidateCount) {
            list.add(new LatLon(userLat, userLon));
        }

        return list;
    }

    /**
     * GraphHopper로 실제 도보 경로 생성 + 거리/시간 계산
     */
    private ShapeRouteResponse buildRouteFromBasePoints(List<GeoPoint> basePoints) {
        List<GeoPoint> routePoints = new ArrayList<>();
        double totalDistanceMeters = 0.0;

        for (int i = 0; i < basePoints.size(); i++) {
            GeoPoint a = basePoints.get(i);
            GeoPoint b = basePoints.get((i + 1) % basePoints.size()); // 마지막→처음

            GHRequest req = new GHRequest(a.lat, a.lon, b.lat, b.lon)
                    .setProfile("foot");

            GHResponse res = hopper.route(req);
            if (res.hasErrors()) {
                continue;
            }

            ResponsePath path = res.getBest();
            PointList pts = path.getPoints();

            totalDistanceMeters += path.getDistance();

            for (int idx = (i == 0 ? 0 : 1); idx < pts.size(); idx++) {
                routePoints.add(new GeoPoint(pts.getLat(idx), pts.getLon(idx)));
            }
        }

        double totalKm = totalDistanceMeters / 1000.0;
        double avgSpeedKmh = 4.0; // 도보
        double estimatedMinutes = (totalKm / avgSpeedKmh) * 60.0;

        return new ShapeRouteResponse(routePoints, totalKm, estimatedMinutes);
    }

    /**
     * 하트 모양 뼈대 포인트 생성
     */
    private List<GeoPoint> generateHeartPoints(double centerLat,
                                               double centerLon,
                                               double sizeKm) {

        List<GeoPoint> list = new ArrayList<>();

        double radiusKm = sizeKm * 0.7;
        double kmToLat = 1.0 / 111.0;
        double kmToLon = 1.0 / (111.0 * Math.cos(Math.toRadians(centerLat)));

        double scale = radiusKm * kmToLat * 0.06;

        double angle = Math.toRadians(-15.0);
        double cosA = Math.cos(angle);
        double sinA = Math.sin(angle);

        int N = 40;

        for (int i = 0; i < N; i++) {
            double t = 2.0 * Math.PI * i / N;

            double x = 16 * Math.pow(Math.sin(t), 3);
            double y = 13 * Math.cos(t) - 5 * Math.cos(2 * t)
                    - 2 * Math.cos(3 * t) - Math.cos(4 * t);

            x *= scale;
            y *= scale;

            double rx = x * cosA - y * sinA;
            double ry = x * sinA + y * cosA;

            double lat = centerLat + ry;
            double lon = centerLon + rx / Math.cos(Math.toRadians(centerLat));

            list.add(new GeoPoint(lat, lon));
        }

        return alignStartToCenter(list, centerLat, centerLon);
    }

    /**
     * 예비용 원형 뼈대
     */
    private List<GeoPoint> generateCirclePoints(double centerLat,
                                                double centerLon,
                                                double sizeKm) {

        List<GeoPoint> list = new ArrayList<>();

        double radiusKm = sizeKm * 0.6;
        double kmToLat = 1.0 / 111.0;
        double kmToLon = 1.0 / (111.0 * Math.cos(Math.toRadians(centerLat)));

        int N = 32;

        for (int i = 0; i < N; i++) {
            double t = 2.0 * Math.PI * i / N;
            double dxKm = radiusKm * Math.cos(t);
            double dyKm = radiusKm * Math.sin(t);

            double lat = centerLat + dyKm * kmToLat;
            double lon = centerLon + dxKm * kmToLon;

            list.add(new GeoPoint(lat, lon));
        }

        return alignStartToCenter(list, centerLat, centerLon);
    }

    // ===== DTO =====

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class LatLon {
        private double lat;
        private double lon;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class GeoPoint {
        private double lat;
        private double lon;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class ShapeRouteResponse {
        private List<GeoPoint> points;
        private double distanceKm;
        private double estimatedMinutes;
    }
}
