package com.example.hackdemo.repository;

import com.example.hackdemo.model.Area;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AreaRepository extends JpaRepository<Area, Long> {
    Area findByName(String name);
}