package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class WalkDetailView {

    private long id;

    // 제목/타입
    private String title;          // "하트코스", "동네 마실", "새로운 산책"
    private String subtitle;       // "저녁 감성 산책 – 하트 코스" 같은 한줄 설명 (하드코딩 섞임)
    private String typeLabel;      // "모양 산책 (하트)", "일반 산책", "산책 알바"

    // 시간/거리
    private String dateLabel;      // "2025-11-30 (일)"
    private String timeLabel;      // "19:40 시작 · 20:22 종료"
    private double distanceKm;
    private long durationMinutes;
    private String durationLabel;  // "42분" 같은 표시용
    private double avgSpeedKmh;
    private double kcal;

    // 반려동물 정보
    private String petSummary;     // "보리 · 소형견 · 6kg" 정도 하드/실데이터 섞어서

    // 사진 파일명 (static/images 밑)
    private String photoFile;      // "ong.jpg", "ong2.jpg", "옹심이.jpg"

    // shape type key (heart/circle/sqere/triangle/normal/job)
    private String typeKey;
}
