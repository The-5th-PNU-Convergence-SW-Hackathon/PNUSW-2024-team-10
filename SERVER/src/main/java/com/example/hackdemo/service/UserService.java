package com.example.hackdemo.service;

import com.example.hackdemo.jwt.JwtTokenProvider;
import com.example.hackdemo.jwt.UserToken;
import com.example.hackdemo.model.*;
import com.example.hackdemo.repository.*;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private FavoriteRepository favoriteRepository;
    @Autowired
    private RestaurantRepository restaurantRepository;
    @Autowired
    private TourSpotRepository tourSpotRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private UserTokenRepository userTokenRepository;
    @Autowired
    private JwtTokenProvider jwtTokenProvider;
    @Value("${jwt.expiration}")
    private int jwtExpirationInMs;

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }
    @Transactional
    public User findOrCreateUser(String email, String name, String provider, String providerId) {
        return userRepository.findByEmail(email)
                .map(existingUser -> {
                    existingUser.setName(name);
                    existingUser.setProvider(provider);
                    existingUser.setProviderId(providerId);
                    return userRepository.save(existingUser);
                })
                .orElseGet(() -> {
                    User newUser = new User();
                    newUser.setEmail(email);
                    newUser.setName(name);
                    newUser.setProvider(provider);
                    newUser.setProviderId(providerId);
                    return userRepository.save(newUser);
                });
    }

    @Transactional
    public String createAndSaveUserToken(User user) {
        String token = jwtTokenProvider.createToken(user.getId(), user.getEmail());

        UserToken userToken = userTokenRepository.findByUser(user)
                .orElse(new UserToken());

        userToken.setUser(user);
        userToken.setToken(token);
        userToken.setExpiryDate(LocalDateTime.now().plusSeconds(jwtExpirationInMs / 1000));

        userTokenRepository.save(userToken);

        return token;
    }

    public List<Restaurant> getFavoriteRestaurants(Long userId) {
        List<Favorite> favorites = favoriteRepository.findByUserIdAndRestaurantIsNotNull(userId);
        return favorites.stream()
                .map(Favorite::getRestaurant)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    public List<TourSpot> getFavoriteTourSpots(Long userId) {
        List<Favorite> favorites = favoriteRepository.findByUserIdAndTourSpotIsNotNull(userId);
        return favorites.stream()
                .map(Favorite::getTourSpot)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    public List<Course> getFavoriteCourses(Long userId) {
        List<Favorite> favorites = favoriteRepository.findByUserIdAndCourseIsNotNull(userId);
        return favorites.stream()
                .map(Favorite::getCourse)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    public List<Favorite> getAllFavorites(Long userId) {
        userRepository.findById(userId)
                .orElseThrow(() -> new NoSuchElementException("User not found"));
        return favoriteRepository.findAllByUserId(userId);
    }
}
