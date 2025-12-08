package edu.sm.app.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class WalkPhotoDto {

    private Long photoId;
    private Long walkingRecodeId;
    private String imagePath;
    private Double lat;
    private Double lng;
    private LocalDateTime createdAt;
}
