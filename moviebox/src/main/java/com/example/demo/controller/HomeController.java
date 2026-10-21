package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {

    private final UserService service;

    public HomeController(UserService service) {
        this.service = service;
    }

    @GetMapping("/") 
    public String home(Model model, HttpSession session, @ModelAttribute("message") String message) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("loggedUser", loggedUser);
        model.addAttribute("message", message);
        return "index"; 
    }

   
    @GetMapping("/admin")
    public String adminHome(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null || loggedUser.getRole() != 0) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized access! Please log in as Admin.");
            return "redirect:/login";
        }
        model.addAttribute("users", service.getAllUsers());
        return "dashboard";
    }
}
