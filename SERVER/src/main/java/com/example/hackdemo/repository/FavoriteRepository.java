package com.example.hackdemo.repository;

import com.example.hackdemo.model.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FavoriteRepository extends JpaRepository<Favorite, Long> {
    Optional<Favorite> findByUserIdAndRestaurantId(Long userId, Long restaurantId);
    Optional<Favorite> findByUserIdAndTourSpotId(Long userId, Long tourSpotId);
    Optional<Favorite> findByUserIdAndCourseId(Long userId, Long courseId);

    Optional<Favorite> findByUserAndRestaurant(User user, Restaurant restaurant);
    Optional<Favorite> findByUserAndTourSpot(User user, TourSpot tourSpot);
    Optional<Favorite> findByUserAndCourse(User user, Course course);

    List<Favorite> findByUserIdAndRestaurantIsNotNull(Long userId);
    List<Favorite> findByUserIdAndTourSpotIsNotNull(Long userId);
    List<Favorite> findByUserIdAndCourseIsNotNull(Long userId);

    List<Favorite> findAllByUserId(Long userId);

}
