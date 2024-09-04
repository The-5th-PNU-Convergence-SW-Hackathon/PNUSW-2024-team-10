package com.example.hackdemo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AreaDTO {
    private Long id;
    private String name;
    private Double xCoordinate;
    private Double yCoordinate;
    private List<RestaurantDTO> restaurants;
    private List<TourSpotDTO> touristSpots;
}