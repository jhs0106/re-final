package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class WalkListView {

    private String filterType;          // all / heart / circle / sqere / triangle / normal / job
    private int totalCount;
    private double totalDistanceKm;
    private long totalMinutes;         // 누적 시간(분)

    private List<WalkListItemView> items;
}
