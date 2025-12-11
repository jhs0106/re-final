package edu.sm.controller;

import edu.sm.app.customer.CustomerInquiry;
import edu.sm.app.customer.CustomerInquiryService;
import jakarta.servlet.http.HttpSession;
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
    // 로그인 페이지 (center로 login.jsp include)
    @GetMapping("/login")
    public String showLogin(HttpSession session, Model model) {

        // 이미 로그인된 상태면 굳이 로그인 페이지 안 보여주고 바로 메인으로
        if (session.getAttribute("adminId") != null) {
            return "redirect:/";
        }

        model.addAttribute("center", "login");  // /WEB-INF/views/login.jsp
        return "index";
    }

    // 로그인 처리
    @PostMapping("/login")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {

        // ★ 데모용: 아이디가 id01일 때만 로그인 성공
        if ("id01".equals(username)) {
            session.setAttribute("adminId", "id01");
            session.setAttribute("adminName", "id01");

            // 중요: 존재하는 URL로 리다이렉트 (여기선 /admin)
            return "redirect:/";
        }

        // 로그인 실패 시 다시 로그인 화면
        model.addAttribute("center", "login");
        model.addAttribute("loginError",
                "아이디 또는 비밀번호가 올바르지 않습니다. (현재는 id01만 로그인 가능)");
        return "index";
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        // 로그아웃 후 로그인 페이지로
        return "redirect:/admin/login";
    }

}
