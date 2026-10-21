package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.demo.model.Order;
import com.example.demo.service.OrderService;
import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrderApiController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public List<Order> getAllOrders() {
        return orderService.getAllOrders();
    }
}
