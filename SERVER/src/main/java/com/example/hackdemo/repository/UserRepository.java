package com.example.hackdemo.repository;

import com.example.hackdemo.model.Favorite;
import com.example.hackdemo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User,Long> {
    Optional<User> findByEmail(String email);
}