package com.example.demo.service;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

@Service
public class TmdbService {

    private static final String IMAGES = "https://image.tmdb.org/t/p/";

    private final RestClient client = RestClient.create("https://api.themoviedb.org/3");

    @Value("${tmdb.api.key:}")
    private String apiKey;

    public boolean isConfigured() {
        return apiKey != null && !apiKey.isBlank();
    }

    public List<Map<String, Object>> popular() {
        return list("/movie/popular", "");
    }

    public List<Map<String, Object>> search(String query) {
        return list("/search/movie", query);
    }

    public Map<String, Object> details(long id) {
        if (!isConfigured()) return null;
        try {
            JsonNode node = get("/movie/" + id, "");
            return node == null ? null : toMap(node);
        } catch (RuntimeException e) {
            return null;
        }
    }

    private List<Map<String, Object>> list(String path, String query) {
        List<Map<String, Object>> movies = new ArrayList<>();
        if (!isConfigured()) return movies;
        try {
            JsonNode root = get(path, query);
            if (root != null) {
                for (JsonNode node : root.path("results")) {
                    movies.add(toMap(node));
                }
            }
        } catch (RuntimeException e) {
            return movies;
        }
        return movies;
    }

    private JsonNode get(String path, String query) {
        return client.get()
                .uri(b -> b.path(path)
                        .queryParam("api_key", "{k}")
                        .queryParam("query", "{q}")
                        .build(apiKey, query))
                .retrieve()
                .body(JsonNode.class);
    }

    private Map<String, Object> toMap(JsonNode n) {
        Map<String, Object> m = new LinkedHashMap<>();
        String date = n.path("release_date").asText("");
        String poster = n.path("poster_path").asText("");
        StringJoiner genres = new StringJoiner(", ");
        for (JsonNode g : n.path("genres")) {
            genres.add(g.path("name").asText());
        }
        m.put("id", n.path("id").asLong());
        m.put("title", n.path("title").asText(""));
        m.put("year", date.length() >= 4 ? date.substring(0, 4) : "");
        m.put("poster", poster.isEmpty() ? "" : IMAGES + "w342" + poster);
        m.put("overview", n.path("overview").asText(""));
        m.put("tagline", n.path("tagline").asText(""));
        m.put("genres", genres.toString());
        m.put("runtime", n.path("runtime").asInt(0));
        return m;
    }
}
