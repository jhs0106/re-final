package edu.sm.app.customer;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerInquiry {
    private Long id;
    private String category;
    private String title;
    private String content;
    private String username;
    private String status;
    private String answer;
    private String responder;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime createdAt;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime answeredAt;

    public String getStatusLabel() {
        return "ANSWERED".equalsIgnoreCase(status) ? "답변완료" : "답변대기";
    }

    public String getStatusBadge() {
        return "ANSWERED".equalsIgnoreCase(status) ? "badge-success" : "badge-warning";
    }

    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        return createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    public String getFormattedAnsweredAt() {
        if (answeredAt == null) return "";
        return answeredAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
}
