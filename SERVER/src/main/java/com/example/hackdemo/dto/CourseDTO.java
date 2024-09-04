package com.example.hackdemo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseDTO {
    private Long id;
    private String name;
    private String theme;
    private String duration;
    private String thumbnailUrl;  // 썸네일 URL 추가
    private List<CourseItemDTO> courseItems;
    private List<Long> areaIds;
}