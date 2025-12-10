package edu.sm.controller;

import edu.sm.app.dto.FakeUser;
import edu.sm.app.dto.User;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
public class MainController {


    private final UserService userService;

    public MainController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String main(Model model) {
        model.addAttribute("center","center");

        return "index";
    }
    @RequestMapping("/cust")
    public String cust(Model model) {
        model.addAttribute("center","cust");
        return "index";
    }
    @RequestMapping("/pet")
    public String pet(Model model) {
        model.addAttribute("center","pet");
        return "index";
    }
    @RequestMapping("/fakeLogin")
    public String fakeLogin(HttpSession session) {
        // 가짜 로그인 유저 정보
        FakeUser user = new FakeUser();
        user.setId("id01");
        user.setName("id01");   // 화면에 보일 이름

        // 세션에 로그인 유저 저장
        session.setAttribute("loginUser", user);

        // 로그인 후 돌아갈 페이지 (관리자 대시보드 경로에 맞게 수정)
        return "redirect:/admin";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();   // 세션 전체 날리기
        return "redirect:/admin";  // 로그아웃 후 이동할 곳
    }
}
