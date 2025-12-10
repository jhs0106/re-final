package edu.sm.controller;

import edu.sm.app.dto.User;
import edu.sm.app.dto.Pet;
import edu.sm.app.repository.PetRepository;
import edu.sm.app.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class UserController {

    private final UserService userService;
    private final PetRepository petRepository;

    // 📌 사용자 목록 페이지
    @GetMapping("/cust")
    public String customerList(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        model.addAttribute("center", "page/cust");
        return "index";
    }

    @GetMapping("/pet")
    public String petList(Model model) {

        List<Pet> pets = petRepository.selectAll();   // 🔥 전체 반려동물 목록 조회

        model.addAttribute("pets", pets);

        model.addAttribute("center", "page/pet");
        return "index";
    }
}
