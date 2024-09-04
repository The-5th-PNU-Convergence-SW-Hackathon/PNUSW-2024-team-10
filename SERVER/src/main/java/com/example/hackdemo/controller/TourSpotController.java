package com.example.hackdemo.controller;

import com.example.hackdemo.model.Favorite;
import com.example.hackdemo.model.Restaurant;
import com.example.hackdemo.model.TourSpot;
import com.example.hackdemo.service.TourSpotService;
import com.example.hackdemo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tourSpot")
public class TourSpotController {
    @Autowired
    private TourSpotService tourSpotService;
    @Autowired
    private UserService userService;

    @GetMapping
    public List<TourSpot> getAllTourSpots() {
        return tourSpotService.getAllTourSpots();
    }

    @GetMapping("/{id}")
    public TourSpot getTourSpotById(@PathVariable Long id) {
        return tourSpotService.getTourSpotById(id);
    }

    @GetMapping("/favorites")
    public ResponseEntity<List<TourSpot>> getFavoriteTourSpots(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        Long userId = Long.parseLong(authentication.getName());
        List<TourSpot> favorites = userService.getFavoriteTourSpots(userId);

        return ResponseEntity.ok(favorites);
    }

    /*
    @PostMapping("/{id}/favorites")
    public ResponseEntity<?> toggleFavoriteTourSpot(@PathVariable Long id, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User must be logged in to favorite a TourSpot");
        }

        Long userId = Long.parseLong(authentication.getName());
        userService.toggleFavorite(userId, null,id,null);

        return ResponseEntity.ok().build();
    }



   @PostMapping
    public TourSpot createTourSpot(@RequestBody TourSpot tourSpot) {
        return tourSpotService.saveTourSpot(tourSpot);
    }

    @PutMapping("/{id}")
    public TourSpot updateTourSpot(@PathVariable Long id, @RequestBody TourSpot tourSpot) {
        tourSpot.setId(id);
        return tourSpotService.saveTourSpot(tourSpot);
    }

    @DeleteMapping("/{id}")
    public void deleteTourSpot(@PathVariable Long id) {
        tourSpotService.deleteTourSpot(id);
    }
    */
}