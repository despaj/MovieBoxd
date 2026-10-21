package com.example.demo.controller;

import com.example.demo.model.Review;
import com.example.demo.model.User;
import com.example.demo.repository.ReviewRepository;
import com.example.demo.service.TmdbService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Controller
public class MovieController {

    private final TmdbService tmdb;
    private final ReviewRepository reviews;

    public MovieController(TmdbService tmdb, ReviewRepository reviews) {
        this.tmdb = tmdb;
        this.reviews = reviews;
    }

    private User current(HttpSession session) {
        return (User) session.getAttribute("loggedUser");
    }

    private Double round(Double value) {
        return value == null ? null : Math.round(value * 10) / 10.0;
    }

    @GetMapping("/home")
    public String home(@RequestParam(required = false) String q, HttpSession session, Model model) {
        User user = current(session);
        if (user == null) return "redirect:/login";

        boolean searching = q != null && !q.isBlank();
        List<Long> ids = movies.stream().map(m -> (Long) m.get("id")).toList();
        Map<Long, Double> avgs = new HashMap<>();
        if (!ids.isEmpty()) {
            for (Object[] row : reviews.averageRatings(ids)) {
                avgs.put((Long) row[0], round((Double) row[1]));
            }
        }
        for (Map<String, Object> movie : movies) {
            movie.put("avg", avgs.get((Long) movie.get("id")));
        }

        model.addAttribute("user", user);
        model.addAttribute("q", searching ? q.trim() : null);
        model.addAttribute("movies", movies);
        model.addAttribute("configured", tmdb.isConfigured());
        model.addAttribute("recent", reviews.findTop8ByOrderByCreatedAtDesc());
        return "home";
    }

    @GetMapping("/movies/{id}")
    public String movie(@PathVariable long id, HttpSession session, Model model) {
        User user = current(session);
        if (user == null) return "redirect:/login";

        Map<String, Object> movie = tmdb.details(id);
        if (movie == null) return "redirect:/home";

        List<Review> list = reviews.findByTmdbIdOrderByCreatedAtDesc(id);
        model.addAttribute("user", user);
        model.addAttribute("movie", movie);
        model.addAttribute("reviews", list);
        model.addAttribute("count", list.size());
        model.addAttribute("avg", round(reviews.averageRating(id)));
        model.addAttribute("mine", reviews.findByTmdbIdAndUserId(id, user.getID()).orElse(null));
        return "movie";
    }

    @PostMapping("/movies/{id}/review")
    public String review(@PathVariable long id,
                         @RequestParam(defaultValue = "0") int rating,
                         @RequestParam(defaultValue = "") String comment,
                         HttpSession session,
                         RedirectAttributes redirect) {
        User user = current(session);
        if (user == null) return "redirect:/login";

        if (rating < 1 || rating > 5) {
            redirect.addFlashAttribute("error", "Pick a star rating from 1 to 5.");
            return "redirect:/movies/" + id;
        }

        Map<String, Object> movie = tmdb.details(id);
        if (movie == null) return "redirect:/home";

        Review review = reviews.findByTmdbIdAndUserId(id, user.getID()).orElseGet(Review::new);
        String text = comment.trim();
        review.setTmdbId(id);
        review.setMovieTitle((String) movie.get("title"));
        review.setPosterUrl((String) movie.get("poster"));
        review.setUserId(user.getID());
        review.setUserName(user.getFname());
        review.setRating(rating);
        review.setBody(text.length() > 1000 ? text.substring(0, 1000) : text);
        if (review.getCreatedAt() == null) review.setCreatedAt(LocalDateTime.now());
        reviews.save(review);

        redirect.addFlashAttribute("message", "Your review was saved.");
        return "redirect:/movies/" + id;
    }

    @PostMapping("/reviews/{id}/delete")
    public String delete(@PathVariable Long id, HttpSession session, RedirectAttributes redirect) {
        User user = current(session);
        if (user == null) return "redirect:/login";

        Review review = reviews.findById(id).orElse(null);
        if (review == null || !review.getUserId().equals(user.getID())) return "redirect:/home";

        reviews.delete(review);
        redirect.addFlashAttribute("message", "Your review was deleted.");
        return "redirect:/movies/" + review.getTmdbId();
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User user = current(session);
        if (user == null) return "redirect:/login";

        List<Review> mine = reviews.findByUserIdOrderByCreatedAtDesc(user.getID());
        double average = mine.stream().mapToInt(Review::getRating).average().orElse(0);
        model.addAttribute("user", user);
        model.addAttribute("mine", mine);
        model.addAttribute("average", Math.round(average * 10) / 10.0);
        return "profile";
    }
}
