package edu.sm.app.service;

import edu.sm.app.dto.WalkPhotoDto;
import edu.sm.app.repository.WalkPhotoMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
@RequiredArgsConstructor
public class WalkPhotoService {

    private final WalkPhotoMapper walkPhotoMapper;

    // 기본값: 프로젝트 실행 위치 기준 "uploads/walk-photos"
    @Value("${app.upload.walk-photo-dir:uploads/walk-photos}")
    private String baseDir;

    /**
     * 산책 사진 저장
     *  - 실제 파일을 disk에 저장
     *  - DB에는 path + 좌표 + walk_log FK만 저장
     */
    public String savePhoto(long walkingRecodeId,
                            MultipartFile image,
                            double lat,
                            double lng) throws IOException {

        if (image == null || image.isEmpty()) {
            throw new IllegalArgumentException("image 파일이 비어 있습니다.");
        }

        // 확장자
        String originalName = image.getOriginalFilename();
        String ext = "";
        if (originalName != null && originalName.contains(".")) {
            ext = originalName.substring(originalName.lastIndexOf('.'));
        } else {
            ext = ".jpg";
        }

        // /uploads/walk-photos/{walkingRecodeId}/파일명
        Path dir = Paths.get(baseDir, String.valueOf(walkingRecodeId));
        Files.createDirectories(dir);

        String filename = System.currentTimeMillis() + ext;
        Path savePath = dir.resolve(filename);

        image.transferTo(savePath.toFile());

        // DB 저장
        WalkPhotoDto dto = new WalkPhotoDto();
        dto.setWalkingRecodeId(walkingRecodeId);
        dto.setImagePath(savePath.toString());
        dto.setLat(lat);
        dto.setLng(lng);

        walkPhotoMapper.insert(dto);

        return dto.getImagePath();
    }
}
