package com.example.demo.controller;

import com.example.demo.model.Order;

import com.example.demo.model.User;
import com.example.demo.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;


import java.util.List;

@Controller
public class DashboardController {

	 @Autowired
	 private OrderService orderService;

	 @Autowired
	 private UserService userService;
    

    public DashboardController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            return "redirect:/login";
        }

        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        model.addAttribute("totalMovies", orders.size());
        model.addAttribute("totalRevenue", orders.stream().mapToDouble(Order::getPrice).sum());
        model.addAttribute("totalCustomers", userService.countUsers());
        return "dashboard";

    }
    
    
}
