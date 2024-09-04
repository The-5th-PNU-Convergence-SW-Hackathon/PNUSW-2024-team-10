package com.example.hackdemo.controller;

import com.example.hackdemo.model.Favorite;
import com.example.hackdemo.model.Restaurant;
import com.example.hackdemo.service.RestaurantService;
import com.example.hackdemo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/restaurant")
public class RestaurantController {
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private UserService userService;
    @GetMapping
    public List<Restaurant> getAllRestaurants() {
        return restaurantService.getAllRestaurants();
    }

    @GetMapping("/{id}")
    public Restaurant getRestaurantById(@PathVariable Long id) {
        return restaurantService.getRestaurantById(id);
    }

    @GetMapping("/favorites")
    public ResponseEntity<List<Restaurant>> getFavoriteRestaurants(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        Long userId = Long.parseLong(authentication.getName());
        List<Restaurant> favorites = userService.getFavoriteRestaurants(userId);

        return ResponseEntity.ok(favorites);
    }

    /*
    @PostMapping("/{id}/favorites")
    public ResponseEntity<?> toggleFavoriteRestaurant(@PathVariable Long id, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User must be logged in to favorite a restaurant");
        }

        Long userId = Long.parseLong(authentication.getName());
        userService.toggleFavorite(userId, id,null,null );

        return ResponseEntity.ok().build();
    }

   @PostMapping
    public Restaurant createRestaurant(@RequestBody Restaurant restaurant) {
        return restaurantService.saveRestaurant(restaurant);
    }

    @PutMapping("/{id}")
    public Restaurant updateRestaurant(@PathVariable Long id, @RequestBody Restaurant restaurant) {
        restaurant.setId(id);
        return restaurantService.saveRestaurant(restaurant);
    }

    @DeleteMapping("/{id}")
    public void deleteRestaurant(@PathVariable Long id) {
        restaurantService.deleteRestaurant(id);
    }*/

}
