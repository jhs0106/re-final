package edu.sm.controller;

import edu.sm.app.customer.CustomerInquiryService;
import edu.sm.app.dto.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class CustomerController {

    private final CustomerInquiryService inquiryService;
    private final HttpSession session;

    @RequestMapping("/customer-service")
    public String customerService(Model model) {
        model.addAttribute("inquiries", inquiryService.getAllInquiries());
        model.addAttribute("center", "customer-service");
        return "index";
    }

    @PostMapping("/customer/inquiry")
    public String submitInquiry(@RequestParam String category,
                                @RequestParam String title,
                                @RequestParam String content,
                                RedirectAttributes redirectAttributes) {
        Object userObj = session.getAttribute("user");
        String username = (userObj instanceof User user) ? user.getUsername() : "손님";
        inquiryService.submitInquiry(username, category, title, content);
        redirectAttributes.addFlashAttribute("inquiryMessage", "문의가 등록되었습니다. 빠르게 답변드리겠습니다.");
        return "redirect:/customer-service";
    }
}
