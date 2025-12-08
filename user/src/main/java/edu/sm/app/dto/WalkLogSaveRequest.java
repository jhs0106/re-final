// edu.sm.app.dto.WalkLogSaveRequest
package edu.sm.app.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class WalkLogSaveRequest {

    private String shapeType;   // heart / circle / square / triangle / normal
    private Double targetKm;

    private RouteDto plannedRoute;   // 도형 코스
    private RouteDto walkedRoute;    // 실제 걸은 코스

    private String startTimeIso;
    private String endTimeIso;

    // ★ 반려동물 / 사용자
    private Integer petId;
    private Long userId;

    // (옵션) 직접 넣을 수도 있는 필드들 - 없어도 됨
    private Double plannedDistance;
    private String plannedRouteData;
    private Double walkedDistance;
    private String walkRouteData;

    // 시간 정보
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Long elapsedSec;

    @Data
    public static class RouteDto {
        private Double distanceKm;
        private List<PointDto> points;
    }

    @Data
    public static class PointDto {
        private double lat;
        private double lon;   // ★ 그대로 유지 (다른 기능 영향 X)
    }
}
