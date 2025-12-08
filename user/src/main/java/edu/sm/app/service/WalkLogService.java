package edu.sm.app.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import edu.sm.app.dto.*;
import edu.sm.app.repository.PetRepository;
import edu.sm.app.repository.WalkLogMapper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class WalkLogService {

    private final WalkLogMapper walkLogMapper;
    private final ObjectMapper objectMapper;
    private final CurrentUserService currentUserService;

    private final PetRepository petRepository;

    private static final double WALK_SPEED_KMH = 4.0;

    private static final DateTimeFormatter DATE_TIME =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    private static final DateTimeFormatter DATE_ONLY =
            DateTimeFormatter.ofPattern("yyyy-MM-dd (E)");
    private static final DateTimeFormatter TIME_ONLY =
            DateTimeFormatter.ofPattern("HH:mm");

    private LocalDateTime parseIsoToLocal(String iso) {
        Instant inst = Instant.parse(iso);
        return LocalDateTime.ofInstant(inst, ZoneId.systemDefault());
    }

    // ★ JSON 저장용 lat/lng 포인트 (서비스 내부에서만 사용)
    @Data
    @AllArgsConstructor
    private static class LatLngPoint {
        private double lat;
        private double lng;
    }

    /**
     * 공통 저장 로직
     * - distance / route_data : 실제 걸은 거리 / 실제 걸은 경로
     * - planned_* : 계획(모양) 데이터
     * - walked_*  : 실제 데이터
     */
    private WalkLogSaveResponse saveInternal(WalkLogSaveRequest req, int userId) throws Exception {

        LocalDateTime start = parseIsoToLocal(req.getStartTimeIso());
        LocalDateTime end   = parseIsoToLocal(req.getEndTimeIso());

        // ---- 1) planned / walked 분리 (lat/lon → lat/lng 변환 포함) ----
        Double plannedDistanceKm = null;
        String plannedRouteJson  = null;

        Double walkedDistanceKm  = null;
        String walkedRouteJson   = null;

        if (req.getPlannedRoute() != null) {
            plannedDistanceKm = req.getPlannedRoute().getDistanceKm();
            if (req.getPlannedRoute().getPoints() != null) {
                List<LatLngPoint> pts = req.getPlannedRoute().getPoints().stream()
                        .map(p -> new LatLngPoint(p.getLat(), p.getLon()))  // ★ lon → lng 로 변환
                        .collect(Collectors.toList());
                plannedRouteJson = objectMapper.writeValueAsString(pts);
            }
        }

        if (req.getWalkedRoute() != null) {
            walkedDistanceKm = req.getWalkedRoute().getDistanceKm();
            if (req.getWalkedRoute().getPoints() != null) {
                List<LatLngPoint> pts = req.getWalkedRoute().getPoints().stream()
                        .map(p -> new LatLngPoint(p.getLat(), p.getLon()))
                        .collect(Collectors.toList());
                walkedRouteJson = objectMapper.writeValueAsString(pts);
            }
        }

        boolean isShapeWalk = req.getShapeType() != null && !req.getShapeType().isBlank();

        // ---- 2) target_km 설정 (모양 산책일 때 모양 거리) ----
        Double targetKm = req.getTargetKm();
        if (isShapeWalk) {
            if (targetKm == null) {
                targetKm = plannedDistanceKm;
            }
        } else {
            targetKm = null;   // 일반 산책일 땐 의미 없음
        }

        // ---- 3) distance / route_data = "실제 걸은 정보" ----
        Double distanceKm = (walkedDistanceKm != null) ? walkedDistanceKm : 0.0;
        String routeData  = (walkedRouteJson != null) ? walkedRouteJson : "[]";

        // ---- 4) DTO 구성 ----
        WalkLogDto log = new WalkLogDto();
        log.setUserId(userId);
        log.setStartTime(start);
        log.setEndTime(end);

        // legacy 컬럼: 실제 기준
        log.setDistanceKm(distanceKm);
        log.setRouteData(routeData);

        // 신규 컬럼
        log.setPlannedDistanceKm(plannedDistanceKm);
        log.setWalkedDistanceKm(walkedDistanceKm);
        log.setPlannedRouteData(plannedRouteJson);
        log.setWalkedRouteData(walkedRouteJson);

        log.setShapeType(req.getShapeType());
        log.setTargetKm(targetKm);
        log.setPetId(req.getPetId());

        // ---- 5) INSERT ----
        walkLogMapper.insert(log);

        long minutes = calcMinutesByDistance(distanceKm);
        return new WalkLogSaveResponse(
                log.getWalkingRecodeId(),
                distanceKm,
                minutes
        );
    }

    /** 산책 코스 저장 (현재 로그인 사용자 기준) */
    public WalkLogSaveResponse save(WalkLogSaveRequest req) throws Exception {
        int userId = currentUserService.getCurrentUserIdOrThrow();
        return saveInternal(req, userId);
    }

    /** 산책 코스 저장 (특정 userId 기준 – 산책알바 등에 사용) */
    public WalkLogSaveResponse saveForUser(WalkLogSaveRequest req, int userId) throws Exception {
        return saveInternal(req, userId);
    }

    /** 현재 로그인 유저의 코스 목록 (요약용) */
    public List<WalkLogSummaryResponse> getListForCurrentUser() {
        int userId = currentUserService.getCurrentUserIdOrThrow();
        List<WalkLogDto> list = walkLogMapper.findByUserId(userId);

        return list.stream()
                .map(l -> {
                    double dist = (l.getWalkedDistanceKm() != null
                            ? l.getWalkedDistanceKm()
                            : 0.0);
                    long minutes = calcMinutesByDistance(dist);
                    String date = l.getStartTime().toLocalDate().toString();
                    return new WalkLogSummaryResponse(
                            l.getWalkingRecodeId(),
                            dist,
                            date,
                            minutes
                    );
                })
                .collect(Collectors.toList());
    }

    /** 특정 코스 한 개 (로그인 유저 기준) */
    public WalkLogDto getOne(long id) {
        int userId = currentUserService.getCurrentUserIdOrThrow();
        return walkLogMapper.findByIdAndUserId(id, userId);
    }

    private long calcMinutesByDistance(double distanceKm) {
        if (distanceKm <= 0) return 1;
        double minutesD = (distanceKm / WALK_SPEED_KMH) * 60.0;
        long minutes = Math.round(minutesD);
        return (minutes <= 0 ? 1 : minutes);
    }

    // ====================== 목록 뷰 ======================
    public WalkListView buildWalkListView(String filterType) {
        int userId = currentUserService.getCurrentUserIdOrThrow();
        List<WalkLogDto> logs = walkLogMapper.findByUserId(userId);

        Map<Integer, Pet> petMap = petRepository.selectByUserId(userId)
                .stream()
                .collect(Collectors.toMap(Pet::getPetId, p -> p, (a, b) -> a));

        if (filterType == null || filterType.isBlank()) {
            filterType = "all";
        }
        String finalFilter = filterType;

        List<WalkListItemView> items = logs.stream()
                .map(log -> toListItemView(log, petMap.get(log.getPetId())))
                .filter(item -> {
                    if ("all".equalsIgnoreCase(finalFilter)) return true;
                    return finalFilter.equalsIgnoreCase(item.getTypeKey());
                })
                .collect(Collectors.toList());

        int totalCount = items.size();
        double totalDistanceKm = items.stream()
                .mapToDouble(WalkListItemView::getDistanceKm)
                .sum();
        long totalMinutes = logs.stream()
                .mapToLong(log -> {
                    if (log.getStartTime() == null || log.getEndTime() == null) return 0L;
                    return Duration.between(log.getStartTime(), log.getEndTime()).toMinutes();
                })
                .sum();

        return WalkListView.builder()
                .filterType(filterType)
                .totalCount(totalCount)
                .totalDistanceKm(totalDistanceKm)
                .totalMinutes(totalMinutes)
                .items(items)
                .build();
    }

    private WalkListItemView toListItemView(WalkLogDto log, Pet pet) {
        String typeKey = resolveTypeKey(log.getShapeType());
        String badgeLabel;
        String title;

        switch (typeKey) {
            case "heart" -> {
                badgeLabel = "하트 모양 코스";
                title = "하트코스";
            }
            case "circle" -> {
                badgeLabel = "동그라미 모양 코스";
                title = "동그라미코스";
            }
            case "triangle" -> {
                badgeLabel = "세모 모양 코스";
                title = "세모코스";
            }
            case "sqere" -> {
                badgeLabel = "네모 모양 코스";
                title = "네모코스";
            }
            case "job" -> {
                badgeLabel = "산책 알바";
                title = "새로운 산책";
            }
            case "normal" -> {
                badgeLabel = "일반 산책";
                title = "동네 마실";
            }
            default -> {
                badgeLabel = "기타 산책";
                title = "나의 산책";
            }
        }

        String dateLabel = "";
        double distanceKm = (log.getWalkedDistanceKm() != null && log.getWalkedDistanceKm() > 0)
                ? log.getWalkedDistanceKm()
                : 0.0;

        if (log.getStartTime() != null) {
            dateLabel = DATE_TIME.format(log.getStartTime());
        }
        long minutes = 0;
        if (log.getStartTime() != null && log.getEndTime() != null) {
            minutes = Duration.between(log.getStartTime(), log.getEndTime()).toMinutes();
        }

        String distanceLabel = String.format("실제 %.1f km", distanceKm);
        String timeLabelDisplay = (minutes > 0) ? ("산책 시간 " + minutes + "분") : "산책 시간 -";

        double pace = 0.0;
        if (minutes > 0 && distanceKm > 0) {
            pace = (distanceKm / ((double) minutes / 60.0));
        }
        String paceLabel = (pace > 0)
                ? String.format("평균 속도 %.1f km/h", pace)
                : "평균 속도 -";

        String petSummary = "반려동물 정보 없음";
        if (pet != null) {
            String weightStr = (pet.getWeight() != null)
                    ? (pet.getWeight() + "kg")
                    : "체중 정보 없음";
            petSummary = pet.getName() + " · " + weightStr;
        }

        String statusLabel = "상세 보기";

        return WalkListItemView.builder()
                .id(log.getWalkingRecodeId())
                .typeKey(typeKey)
                .badgeLabel(badgeLabel)
                .title(title)
                .dateLabel(dateLabel)
                .distanceLabel(distanceLabel)
                .timeLabel(timeLabelDisplay)
                .paceLabel(paceLabel)
                .petSummary(petSummary)
                .distanceKm(distanceKm)
                .statusLabel(statusLabel)
                .build();
    }

    private String resolveTypeKey(String rawShapeType) {
        if (rawShapeType == null || rawShapeType.isBlank()) {
            return "normal";
        }
        String s = rawShapeType.toLowerCase(Locale.ROOT);

        if (s.contains("heart")) return "heart";
        if (s.contains("circle")) return "circle";
        if (s.contains("sqere") || s.contains("square")) return "sqere";
        if (s.contains("tri")) return "triangle";
        if (s.contains("job") || s.contains("알바")) return "job";
        if (s.contains("일반") || s.contains("normal")) return "normal";

        return "etc";
    }

    // ====================== 상세 뷰 ======================
    public WalkDetailView buildWalkDetailView(long id) throws Exception {
        int userId = currentUserService.getCurrentUserIdOrThrow();
        WalkLogDto log = walkLogMapper.findByIdAndUserId(id, userId);
        if (log == null) {
            throw new IllegalArgumentException("해당 산책 기록이 없거나 권한이 없습니다.");
        }

        Pet pet = null;
        if (log.getPetId() != null) {
            pet = petRepository.select(log.getPetId());
        }

        String typeKey = resolveTypeKey(log.getShapeType());

        String title;
        String typeLabel;
        String subtitle;
        String photoFile;

        switch (typeKey) {
            case "heart" -> {
                title = "하트코스";
                typeLabel = "모양 산책 (하트)";
                subtitle = "저녁 감성 산책 – 하트 코스";
                photoFile = "ong2.jpg";
            }
            case "circle" -> {
                title = "동그라미코스";
                typeLabel = "모양 산책 (동그라미)";
                subtitle = "동그라미 모양으로 동네 한 바퀴";
                photoFile = "ong2.jpg";
            }
            case "triangle" -> {
                title = "세모코스";
                typeLabel = "모양 산책 (세모)";
                subtitle = "세모 모양 코스로 리듬 있게 산책";
                photoFile = "ong2.jpg";
            }
            case "sqere" -> {
                title = "네모코스";
                typeLabel = "모양 산책 (네모)";
                subtitle = "블록처럼 네모난 길을 따라 걷기";
                photoFile = "ong2.jpg";
            }
            case "job" -> {
                title = "새로운 산책";
                typeLabel = "산책 알바";
                subtitle = "산책 알바로 새로운 친구와 함께한 산책";
                photoFile = "옹심이.jpg";
            }
            case "normal" -> {
                title = "동네 마실";
                typeLabel = "일반 산책";
                subtitle = "동네 한 바퀴, 가벼운 마실 산책";
                photoFile = "ong.jpg";
            }
            default -> {
                title = "나의 산책";
                typeLabel = "기타 산책";
                subtitle = "기록된 산책 상세 정보입니다.";
                photoFile = "ong.jpg";
            }
        }

        double distanceKm = (log.getWalkedDistanceKm() != null && log.getWalkedDistanceKm() > 0)
                ? log.getWalkedDistanceKm()
                : 0.0;

        long minutes = 0;
        String dateLabel = "-";
        String timeLabel = "-";

        if (log.getStartTime() != null && log.getEndTime() != null) {
            minutes = Duration.between(log.getStartTime(), log.getEndTime()).toMinutes();
            dateLabel = DATE_ONLY.format(log.getStartTime());
            timeLabel = TIME_ONLY.format(log.getStartTime()) + " 시작 · " +
                    TIME_ONLY.format(log.getEndTime()) + " 종료";
        }

        double avgSpeedKmh = 0.0;
        if (minutes > 0 && distanceKm > 0) {
            avgSpeedKmh = distanceKm / ((double) minutes / 60.0);
        }

        double weight = 5.0;
        String petSummary = "반려동물 정보 없음";
        if (pet != null) {
            if (pet.getWeight() != null) {
                weight = pet.getWeight().doubleValue();
            }
            petSummary = pet.getName() + " · " + weight + "kg";
        }

        double kcal = distanceKm * weight * 1.0;
        String durationLabel = (minutes > 0) ? (minutes + "분") : "-";

        return WalkDetailView.builder()
                .id(log.getWalkingRecodeId())
                .typeKey(typeKey)
                .title(title)
                .subtitle(subtitle)
                .typeLabel(typeLabel)
                .dateLabel(dateLabel)
                .timeLabel(timeLabel)
                .distanceKm(distanceKm)
                .durationMinutes(minutes)
                .durationLabel(durationLabel)
                .avgSpeedKmh(avgSpeedKmh)
                .kcal(kcal)
                .petSummary(petSummary)
                .photoFile(photoFile)
                .build();
    }
}
