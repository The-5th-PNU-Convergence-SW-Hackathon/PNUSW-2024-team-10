package com.example.hackdemo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseItemDTO {
    private Long id;
    private Long restaurantId;
    private String restaurantGoogleId;
    private String restaurantName;
    private Long tourSpotId;
    private String tourSpotGoogleId;
    private String tourSpotName;
    private String description;
    private String mission;
    private String duration;
}