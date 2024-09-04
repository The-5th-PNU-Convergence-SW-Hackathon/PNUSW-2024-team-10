package com.example.hackdemo.service;

import com.example.hackdemo.model.*;
import com.example.hackdemo.repository.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class FavoriteService {

    @Autowired
    private FavoriteRepository favoriteRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private TourSpotRepository tourSpotRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Transactional
    public boolean toggleFavoriteRestaurant(Long userId, Long restaurantId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        Restaurant restaurant = restaurantRepository.findById(restaurantId)
                .orElseThrow(() -> new RuntimeException("Restaurant not found"));

        Optional<Favorite> existingFavorite = favoriteRepository.findByUserAndRestaurant(user, restaurant);

        if (existingFavorite.isPresent()) {
            favoriteRepository.delete(existingFavorite.get());
            return false;
        } else {
            Favorite favorite = new Favorite();
            favorite.setUser(user);
            favorite.setRestaurant(restaurant);
            favorite.setCreatedAt(LocalDateTime.now());
            favoriteRepository.save(favorite);
            return true;
        }
    }

    @Transactional
    public boolean toggleFavoriteTourSpot(Long userId, Long tourSpotId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        TourSpot tourSpot = tourSpotRepository.findById(tourSpotId)
                .orElseThrow(() -> new RuntimeException("TourSpot not found"));

        Optional<Favorite> existingFavorite = favoriteRepository.findByUserAndTourSpot(user, tourSpot);

        if (existingFavorite.isPresent()) {
            favoriteRepository.delete(existingFavorite.get());
            return false;
        } else {
            Favorite favorite = new Favorite();
            favorite.setUser(user);
            favorite.setTourSpot(tourSpot);
            favorite.setCreatedAt(LocalDateTime.now());
            favoriteRepository.save(favorite);
            return true;
        }
    }

    @Transactional
    public boolean toggleFavoriteCourse(Long userId, Long courseId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));

        Optional<Favorite> existingFavorite = favoriteRepository.findByUserAndCourse(user, course);

        if (existingFavorite.isPresent()) {
            favoriteRepository.delete(existingFavorite.get());
            return false;
        } else {
            Favorite favorite = new Favorite();
            favorite.setUser(user);
            favorite.setCourse(course);
            favorite.setCreatedAt(LocalDateTime.now());
            favoriteRepository.save(favorite);
            return true;
        }
    }
}