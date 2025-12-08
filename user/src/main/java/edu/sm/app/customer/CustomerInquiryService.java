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

    public CustomerInquiry submitInquiry(String username, String category, String title, String content) {
        CustomerInquiry inquiry = CustomerInquiry.builder()
                .username(username)
                .category(category)
                .title(title)
                .content(content)
                .status("WAITING")
                .createdAt(LocalDateTime.now())
                .build();
        repository.insert(inquiry);
        return inquiry;
    }
}
