package edu.sm.app.springai;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.content.Media;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Service;
import org.springframework.util.MimeType;

@Service
@Slf4j
public class AiImageService {
    private final ChatClient chatClient;

    public AiImageService(ChatClient.Builder chatClientBuilder) {
        this.chatClient = chatClientBuilder.build();
    }

    public String analyzeImage(String text, String contentType, byte[] bytes) {
        String systemPrompt = """
                당신은 수의학 AI 보조입니다. 사용자가 제공한 반려동물의 이미지와 증상 설명을 분석하여 예비 진단 결과를 JSON 형식으로 제공해야 합니다.

                다음 JSON 형식을 엄격히 준수하여 응답하세요 (Markdown 코드 블록 없이 순수 JSON만 반환):
                {
                    "level": "caution" | "observation" | "hospital-recommended",
                    "findings": "진단 소견 (HTML 태그 사용 가능, <ul><li> 등)",
                    "recommendations": "권장 조치사항 (HTML 태그 사용 가능)",
                    "confidence": 0~100 사이의 정수,
                    "costs": {
                        "initial": "예상 초진 진료비 (예: 30,000원)",
                        "followUp": "예상 재진 진료비 (예: 15,000원)",
                        "estimated": "총 예상 치료비 (예: 50,000원)"
                    }
                }

                진단 기준:
                - observation: 경미한 증상, 집에서 관찰 가능
                - caution: 주의가 필요함, 증상 악화 시 병원 방문 필요
                - hospital-recommended: 즉시 병원 방문이 필요한 심각한 증상

                비용은 한국 동물병원 평균 진료비를 기준으로 추정하세요.
                제공된 정보만으로 판단이 불가능한 경우, level을 'observation'으로 하고 findings에 '정보가 부족하여 명확한 진단을 내릴 수 없습니다.'라고 적으세요.
                """;

        SystemMessage systemMessage = SystemMessage.builder()
                .text(systemPrompt)
                .build();

        UserMessage.Builder userMessageBuilder = UserMessage.builder();

        StringBuilder userText = new StringBuilder("반려동물 건강 상태 분석 요청:\n");
        if (text != null && !text.isBlank()) {
            userText.append("증상 설명: ").append(text).append("\n");
        }
        userMessageBuilder.text(userText.toString());

        if (bytes != null && bytes.length > 0) {
            Media media = Media.builder()
                    .mimeType(MimeType.valueOf(contentType))
                    .data(new ByteArrayResource(bytes))
                    .build();
            userMessageBuilder.media(media);
        }

        Prompt prompt = Prompt.builder()
                .messages(systemMessage, userMessageBuilder.build())
                .build();

        return chatClient.prompt(prompt).call().content();
    }
}
