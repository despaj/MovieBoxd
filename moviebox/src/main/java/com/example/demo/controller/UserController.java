package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.service.UserService;
import com.example.demo.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Controller
public class UserController {

    private final UserRepository userRepository;

    @Autowired
    private UserService service;

    @GetMapping("/login")
    public String showLoginForm(Model model, @ModelAttribute("message") String message, @ModelAttribute("error") String error) {
        model.addAttribute("user", new User());
        model.addAttribute("message", message);
        model.addAttribute("error", error);
        return "login";
    }
   
    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }


    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String pass,
                        HttpSession session,
                        Model model) {

        User user = userRepository.findByEmail(email);

        if (user != null) {
            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            if (encoder.matches(pass, user.getPass())) {
                session.setAttribute("loggedUser", user);

                if (user.getRole() == 0) {
                    return "redirect:/admin";
                } else {
                    return "redirect:/home";
                }
            } else {
                model.addAttribute("error", "Invalid email or password!");
            }
        } else {
            model.addAttribute("error", "Invalid email or password!");
        }
        return "login";
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model, @ModelAttribute("message") String message) {
        model.addAttribute("user", new User());
        model.addAttribute("message", message);
        return "register";
    }

    @PostMapping("/register")
    public String processRegister(
            @Valid @ModelAttribute("user") User user,
            BindingResult bindingResult,
            Model model) {

        if (!user.getPass().equals(user.getConfirmPass())) {
            model.addAttribute("error", "Passwords do not match!");
            return "register";
        }
        
        if (bindingResult.hasErrors()) {
            return "register";
        }

        if (user.getTerms() == null || !user.getTerms()) {
            model.addAttribute("error", "You must accept the terms and conditions!");
            return "register";
        }

        String result = service.saveUser(user);
        if ("email_exists".equals(result)) {
            model.addAttribute("error", "Email already exists!");
            return "register";
        }

        // Registration successful
        model.addAttribute("message", "Registration successful! Please login.");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("message", "Logged out successfully!");
        return "redirect:/login";
    }
   
    }
