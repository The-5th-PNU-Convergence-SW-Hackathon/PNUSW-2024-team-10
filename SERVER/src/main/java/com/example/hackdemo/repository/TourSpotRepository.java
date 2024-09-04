package com.example.hackdemo.repository;

import com.example.hackdemo.model.TourSpot;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TourSpotRepository extends JpaRepository<TourSpot, Long> {
    TourSpot findByName(String name);
}