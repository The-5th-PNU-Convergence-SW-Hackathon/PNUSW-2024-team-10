package com.example.hackdemo.dto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FavoriteCourseDTO {
    private Long id;
    private String name;
    private String theme;
    private String duration;
    private String thumbnailUrl;  // 썸네일 URL 추가
    private String landmark; // 필요한 경우 추가
}
