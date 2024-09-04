package com.example.hackdemo.repository;

import com.example.hackdemo.jwt.UserToken;
import com.example.hackdemo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserTokenRepository extends JpaRepository<UserToken, Long> {
    Optional<UserToken> findByUser(User user);
    Optional<UserToken> findByToken(String token);
}