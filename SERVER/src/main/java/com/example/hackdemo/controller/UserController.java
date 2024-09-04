package com.example.hackdemo.controller;

import com.example.hackdemo.model.Favorite;
import com.example.hackdemo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/{userId}/favorites")
    public ResponseEntity<List<Favorite>> getAllFavorites(@PathVariable Long userId) {
        List<Favorite> favorites = userService.getAllFavorites(userId);
        return ResponseEntity.ok(favorites);
    }
}
