package edu.sm.controller;

import edu.sm.app.customer.CustomerInquiry;
import edu.sm.app.customer.CustomerInquiryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminCustomerController {

    private final CustomerInquiryService inquiryService;

    @GetMapping("/customer")
    public String adminCustomer(Model model) {
        model.addAttribute("inquiries", inquiryService.getAllInquiries());
        model.addAttribute("center", "page/customer-center");
        return "index";
    }

    @GetMapping("/customer/detail")
    public String detail(@RequestParam long id, Model model) {
        CustomerInquiry inquiry = inquiryService.getById(id);
        model.addAttribute("inquiry", inquiry);
        model.addAttribute("center", "page/customer-center-detail");
        return "index";
    }

    @PostMapping("/customer/answer")
    public String answer(@RequestParam long id,
                         @RequestParam String answer,
                         @RequestParam(required = false, defaultValue = "관리자") String responder,
                         RedirectAttributes redirectAttributes) {
        try {
            CustomerInquiry updated = inquiryService.addAnswer(id, responder, answer);
            redirectAttributes.addFlashAttribute("message", "답변을 저장했습니다.");
            redirectAttributes.addFlashAttribute("inquiry", updated);
            return "redirect:/admin/customer/detail?id=" + id;
        } catch (IllegalArgumentException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        }
    }
}
