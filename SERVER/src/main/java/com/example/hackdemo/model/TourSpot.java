package com.example.hackdemo.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Entity
@Data
public class TourSpot {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String googleId;
    private String name;
    private String address;

    private Double xCoordinate;
    private Double yCoordinate;
    private String theme;
    @ManyToOne
    @JoinColumn(name = "area_id")
    @JsonBackReference
    private Area area;
}

