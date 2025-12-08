package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class WalkListItemView {

    private long id;

    // 필터용 key: all / heart / circle / sqere / triangle / normal / job
    private String typeKey;

    // 상단 뱃지용 (예: "하트 모양 코스", "일반 산책", "산책 알바")
    private String badgeLabel;

    // 카드 제목 (예: "하트코스", "동네 마실", "새로운 산책")
    private String title;

    // 시작일 표시 (예: "2025-11-30 · 19:40 시작")
    private String dateLabel;

    // 거리, 시간, 속도 등
    private String distanceLabel;  // "실제 2.3 km" 등
    private String timeLabel;      // "산책 시간 42분" 등
    private String paceLabel;      // "평균 속도 3.2 km/h" 등 (간단 계산 또는 비워둬도 됨)

    // 반려동물 정보 요약
    private String petSummary;     // "반려견 보리 · 6kg" 같은 문구

    // 오른쪽에 표시할 거리 숫자
    private double distanceKm;

    // 상태 (예: "상세 보기", "기록 완료")
    private String statusLabel;
}
