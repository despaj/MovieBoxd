package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.example.demo.model.Order;
import com.example.demo.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.ui.Model;
import com.example.demo.model.User;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/buyMovie")
    public String buyMovie(@RequestParam String movieTitle,
                           @RequestParam double price,
                           HttpSession session,
                           Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        
 
        Order order = new Order();
        order.setMovieTitle(movieTitle);
        order.setCustomerEmail(loggedUser.getEmail());
        order.setCustomerName(loggedUser.getFname() + " " + loggedUser.getLname());
        order.setPrice(price);
        order.setStatus("Pending");
        
        order.setTotal(price);

        orderService.saveOrder(order);

        model.addAttribute("message", "Movie bought successfully!");
        return "home"; 
    }



}
