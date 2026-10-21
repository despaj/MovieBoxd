package com.example.demo.dto;

import java.time.LocalDateTime;

public class OrderDTO {
    private Long id;
    private String movieTitle;
    private double total;
    private String status;
    private LocalDateTime purchaseDate;

    public OrderDTO(Long id, String movieTitle, double total, String status, LocalDateTime purchaseDate) {
        this.id = id;
        this.movieTitle = movieTitle;
        this.total = total;
        this.status = status;
        this.purchaseDate = purchaseDate;
    }

    // Getters
    public Long getId() { return id; }
    public String getMovieTitle() { return movieTitle; }
    public double getTotal() { return total; }
    public String getStatus() { return status; }
    public LocalDateTime getPurchaseDate() { return purchaseDate; }

    // Setters
    public void setId(Long id) { this.id = id; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }
    public void setTotal(double total) { this.total = total; }
    public void setStatus(String status) { this.status = status; }
    public void setPurchaseDate(LocalDateTime purchaseDate) { this.purchaseDate = purchaseDate; }
}
