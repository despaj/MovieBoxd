package com.example.demo.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String movieTitle;
    private String customerEmail;
    private double price;
    private double total;
    private String status;

    // ✅ Add this
    private String customerName;
    
    private LocalDateTime purchaseDate;

    public Order() {}

    public Order(String movieTitle, String customerEmail, double price, String status, String customerName) {
        this.movieTitle = movieTitle;
        this.customerEmail = customerEmail;
        this.price = price;
        this.status = status;
        this.customerName = customerName;
        this.purchaseDate = LocalDateTime.now();
    }

    // Getters and setters
    public Long getId() { return id; }
    public String getMovieTitle() { return movieTitle; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
    
    public LocalDateTime getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(LocalDateTime purchaseDate) { this.purchaseDate = purchaseDate; }
}
