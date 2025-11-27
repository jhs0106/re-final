package edu.sm.app.service;

import edu.sm.app.dto.VoiceRouteResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.audio.transcription.AudioTranscriptionPrompt;
import org.springframework.ai.audio.transcription.AudioTranscriptionResponse;
import org.springframework.ai.openai.OpenAiAudioSpeechModel;
import org.springframework.ai.openai.OpenAiAudioSpeechOptions;
import org.springframework.ai.openai.OpenAiAudioTranscriptionModel;
import org.springframework.ai.openai.OpenAiAudioTranscriptionOptions;
import org.springframework.ai.openai.api.OpenAiAudioApi.SpeechRequest;
import org.springframework.ai.openai.api.OpenAiAudioApi.SpeechRequest.AudioResponseFormat;
import org.springframework.ai.openai.audio.speech.SpeechPrompt;
import org.springframework.ai.openai.audio.speech.SpeechResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Base64;

@Service
@Slf4j
public class VoiceRouteService {

    private final OpenAiAudioTranscriptionModel transcriptionModel;
    private final OpenAiAudioSpeechModel speechModel;
    private final MapRouteService mapRouteService;

    @Value("${map.center-lat}")
    private double centerLat;

    @Value("${map.center-lon}")
    private double centerLon;

    public VoiceRouteService(OpenAiAudioTranscriptionModel transcriptionModel,
                             OpenAiAudioSpeechModel speechModel,
                             MapRouteService mapRouteService) {
        this.transcriptionModel = transcriptionModel;
        this.speechModel = speechModel;
        this.mapRouteService = mapRouteService;
    }

    /**
     * 음성 파일 하나 받아서 → STT → 문장 파싱 → GraphHopper → TTS 까지 한 번에 처리
     */
    public VoiceRouteResponse handleVoiceRoute(MultipartFile speechFile,
                                               Double reqCenterLat,
                                               Double reqCenterLon) throws IOException {

        // 1) STT
        String text = stt(speechFile);
        log.info("VoiceRoute STT: {}", text);

        String lower = text.toLowerCase();

        // 2) 모양 파싱: 기본은 하트
        String shape = "heart";
        if (lower.contains("원") || lower.contains("동그라미")) {
            shape = "circle";
        }

        // 3) 거리 파싱 (km)
        double targetKm = extractTargetKm(lower);
        if (targetKm <= 0) {
            targetKm = 4.0;
        }

        // ★ 3-1) centerLat/centerLon 선택: 요청값 우선, 없으면 기본값(@Value)
        double usedCenterLat = (reqCenterLat != null ? reqCenterLat : this.centerLat);
        double usedCenterLon = (reqCenterLon != null ? reqCenterLon : this.centerLon);

        // 4) GraphHopper 로 코스 생성 (이제 내 위치 기준)
        MapRouteService.ShapeRouteResponse route =
                mapRouteService.getShapeRouteByTargetKm(shape, usedCenterLat, usedCenterLon, targetKm);

        // 5) TTS 안내 멘트
        String shapeKo = "heart".equals(shape) ? "하트" : "원형";
        String reply = String.format(
                "요청하신 %s 모양 약 %.1f 킬로미터 산책 코스를 만들어 드렸습니다. " +
                        "실제 거리는 약 %.2f 킬로미터이고, 예상 소요 시간은 약 %.0f분입니다.",
                shapeKo,
                targetKm,
                route.getDistanceKm(),
                route.getEstimatedMinutes()
        );

        byte[] audioBytes = tts(reply);
        String base64Audio = Base64.getEncoder().encodeToString(audioBytes);

        return new VoiceRouteResponse(
                text,
                shape,
                targetKm,
                route.getPoints(),
                route.getDistanceKm(),
                route.getEstimatedMinutes(),
                base64Audio
        );
    }

    // ===== STT =====
    private String stt(MultipartFile multipartFile) throws IOException {
        Path tempFile = Files.createTempFile("voice-", multipartFile.getOriginalFilename());
        multipartFile.transferTo(tempFile);
        Resource audioResource = new FileSystemResource(tempFile);

        OpenAiAudioTranscriptionOptions options = OpenAiAudioTranscriptionOptions.builder()
                .model("whisper-1")
                .language("ko")
                .build();

        AudioTranscriptionPrompt prompt = new AudioTranscriptionPrompt(audioResource, options);
        AudioTranscriptionResponse response = transcriptionModel.call(prompt);
        String text = response.getResult().getOutput();
        log.info("STT result: {}", text);

        return text;
    }

    // ===== TTS =====
    private byte[] tts(String text) {
        OpenAiAudioSpeechOptions options = OpenAiAudioSpeechOptions.builder()
                .model("gpt-4o-mini-tts")
                .voice(SpeechRequest.Voice.ASH)
                .responseFormat(AudioResponseFormat.MP3)
                .speed(1.0f)
                .build();

        SpeechPrompt prompt = new SpeechPrompt(text, options);
        SpeechResponse response = speechModel.call(prompt);
        return response.getResult().getOutput();
    }

    /**
     * "3km", "3 킬로", "3.5킬로미터" 같은 표현에서 숫자 부분만 골라서 km로 리턴
     */
    private double extractTargetKm(String text) {
        String normalized = text.replace(',', '.');

        java.util.regex.Matcher m = java.util.regex.Pattern
                .compile("(\\d+(?:\\.\\d+)?)\\s*(km|킬로|키로|킬로미터|키로미터)?")
                .matcher(normalized);

        if (m.find()) {
            try {
                return Double.parseDouble(m.group(1));
            } catch (NumberFormatException ignore) {
            }
        }

        return 0;
    }
}
