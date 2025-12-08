package edu.sm.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import edu.sm.app.dto.*;
import edu.sm.app.service.MapRouteService;
import edu.sm.app.service.WalkLogService;
import edu.sm.app.service.WalkPhotoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/api/walk")
@RequiredArgsConstructor
public class WalkLogRestController {

    private final WalkLogService walkLogService;
    private final ObjectMapper objectMapper;
    private final WalkPhotoService walkPhotoService;

    @PostMapping("/logs")
    public WalkLogSaveResponse saveLog(@RequestBody WalkLogSaveRequest req) throws Exception {
        return walkLogService.save(req);
    }

    @GetMapping("/logs")
    public List<WalkLogSummaryResponse> listLogs() {
        return walkLogService.getListForCurrentUser();
    }

    /** 특정 코스의 실제 경로 다시 가져오기 */
    @GetMapping("/logs/{id}")
    public RouteResponse getLogRoute(@PathVariable long id) throws Exception {

        WalkLogDto log = walkLogService.getOne(id);

        // 1순위: walk_route_data, 2순위: legacy route_data
        String routeJson = log.getWalkedRouteData();
        if (routeJson == null || routeJson.isBlank()) {
            routeJson = log.getRouteData();
        }
        if (routeJson == null || routeJson.isBlank()) {
            routeJson = "[]";
        }

        MapRouteService.GeoPoint[] arr =
                objectMapper.readValue(routeJson, MapRouteService.GeoPoint[].class);

        List<MapRouteService.GeoPoint> points = Arrays.asList(arr);

        double distanceKm = (log.getWalkedDistanceKm() != null)
                ? log.getWalkedDistanceKm()
                : (log.getDistanceKm() != null ? log.getDistanceKm() : 0.0);

        double estimatedMinutes = (distanceKm <= 0)
                ? 1
                : (distanceKm / 4.0) * 60.0;

        String type = (log.getShapeType() != null && !log.getShapeType().isBlank())
                ? log.getShapeType()
                : "saved";

        return new RouteResponse(
                type,
                points,
                distanceKm,
                estimatedMinutes
        );
    }

    @PostMapping("/photos")
    public WalkPhotoResponse uploadPhoto(
            @RequestParam("walkingRecodeId") long walkingRecodeId,
            @RequestParam("image") MultipartFile image,
            @RequestParam("lat") double lat,
            @RequestParam("lng") double lng
    ) throws Exception {

        walkLogService.getOne(walkingRecodeId);

        String path = walkPhotoService.savePhoto(walkingRecodeId, image, lat, lng);
        return new WalkPhotoResponse(path);
    }
}
