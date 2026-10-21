package com.example.demo.repository;

import com.example.demo.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByTmdbIdOrderByCreatedAtDesc(Long tmdbId);
    List<Review> findByUserIdOrderByCreatedAtDesc(Long userId);
    List<Review> findTop8ByOrderByCreatedAtDesc();
    Optional<Review> findByTmdbIdAndUserId(Long tmdbId, Long userId);

    @Query("select avg(r.rating) from Review r where r.tmdbId = :id")
    Double averageRating(@Param("id") Long id);
}
