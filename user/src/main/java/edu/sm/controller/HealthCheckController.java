package edu.sm.controller;

import edu.sm.app.springai.AiImageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/api/health-check")
@RequiredArgsConstructor
@Slf4j
public class HealthCheckController {

    private final AiImageService aiImageService;

    @PostMapping("/analyze")
    public String analyze(@RequestParam("image") MultipartFile image,
            @RequestParam("category") String category) {
        log.info("Analyzing image for category: {}", category);
        try {
            if (image == null || image.isEmpty()) {
                throw new IllegalArgumentException("Image file is required");
            }
            return aiImageService.analyzeImage(category, image.getContentType(), image.getBytes());
        } catch (IOException e) {
            log.error("Error processing image", e);
            return "{\"error\": \"Failed to process image\"}";
        } catch (Exception e) {
            log.error("Error analyzing image", e);
            return "{\"error\": \"AI analysis failed\"}";
        }
    }

    @PostMapping("/history")
    public Map<String, String> saveHistory(@RequestBody Map<String, Object> historyData) {
        log.info("Saving history: {}", historyData);
        // TODO: Implement actual database saving logic here
        // For now, just log and return success
        return Map.of("status", "success", "message", "History saved successfully");
    }
}
