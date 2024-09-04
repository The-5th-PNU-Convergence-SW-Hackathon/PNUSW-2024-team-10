package com.example.hackdemo.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Restaurant {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String googleId;

    private String name;
    private String address;
    private String mainMenu;
    private String foodType;
    private String eatingAlone;
    private String halalOrVegan;
    private String michelinGuide;
    private Double xCoordinate;
    private Double yCoordinate;

    @ManyToOne
    @JoinColumn(name = "area_id")
    @JsonBackReference
    private Area area;

}