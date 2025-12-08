package edu.sm.app.customer;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CustomerInquiryService {

    private final CustomerInquiryRepository repository;

    public List<CustomerInquiry> getAllInquiries() {
        return repository.findAll();
    }

    public CustomerInquiry getById(long id) {
        CustomerInquiry inquiry = repository.findById(id);
        if (inquiry == null) {
            throw new IllegalArgumentException("문의가 존재하지 않습니다.");
        }
        return inquiry;
    }

    public CustomerInquiry addAnswer(long id, String responder, String answer) {
        LocalDateTime answeredAt = LocalDateTime.now();
        int updated = repository.updateAnswer(id, responder, answer, answeredAt);
        if (updated == 0) {
            throw new IllegalArgumentException("문의가 존재하지 않습니다.");
        }
        return getById(id);
    }
}
