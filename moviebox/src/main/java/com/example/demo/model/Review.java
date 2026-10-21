package com.example.demo.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "reviews")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long tmdbId;
    private String movieTitle;
    private String posterUrl;
    private Long userId;
    private String userName;
    private int rating;
    @Column(length = 1000)
    private String body;
    private LocalDateTime createdAt;

    public Long getId() { return id; }
    public Long getTmdbId() { return tmdbId; }
    public void setTmdbId(Long tmdbId) { this.tmdbId = tmdbId; }
    public String getMovieTitle() { return movieTitle; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }
    public String getPosterUrl() { return posterUrl; }
    public void setPosterUrl(String posterUrl) { this.posterUrl = posterUrl; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getBody() { return body; }
    public void setBody(String body) { this.body = body; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getStars() { return "★".repeat(rating) + "☆".repeat(5 - rating); }

    public String getDateLabel() {
        return createdAt == null ? "" : createdAt.format(DateTimeFormatter.ofPattern("MMM d, yyyy"));
    }
}
