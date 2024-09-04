package com.example.hackdemo.controller;

import com.example.hackdemo.jwt.JwtTokenProvider;
import com.example.hackdemo.model.Favorite;
import com.example.hackdemo.model.User;
import com.example.hackdemo.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/favorites")
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    @PostMapping("/restaurant/{restaurantId}")
    public ResponseEntity<?> toggleFavoriteRestaurant(
            @PathVariable Long restaurantId,
            Authentication authentication) {
        User user = (User) authentication.getPrincipal();
        boolean isFavorite = favoriteService.toggleFavoriteRestaurant(user.getId(), restaurantId);
        return ResponseEntity.ok(new FavoriteResponse(isFavorite));
    }

    @PostMapping("/tourspot/{tourSpotId}")
    public ResponseEntity<?> toggleFavoriteTourSpot(
            @PathVariable Long tourSpotId,
            Authentication authentication) {
        User user = (User) authentication.getPrincipal();
        boolean isFavorite = favoriteService.toggleFavoriteTourSpot(user.getId(), tourSpotId);
        return ResponseEntity.ok(new FavoriteResponse(isFavorite));
    }

    @PostMapping("/course/{courseId}")
    public ResponseEntity<?> toggleFavoriteCourse(
            @PathVariable Long courseId,
            Authentication authentication) {
        User user = (User) authentication.getPrincipal();
        boolean isFavorite = favoriteService.toggleFavoriteCourse(user.getId(), courseId);
        return ResponseEntity.ok(new FavoriteResponse(isFavorite));
    }

}
