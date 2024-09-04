package com.example.hackdemo.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
public class Area {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String googleId;
    private String name;
    private Double xCoordinate;
    private Double yCoordinate;

    @OneToMany(mappedBy = "area")
    @JsonManagedReference
    private List<Restaurant> restaurants;

    @OneToMany(mappedBy = "area")
    @JsonManagedReference
    private List<TourSpot> touristSpots;
}