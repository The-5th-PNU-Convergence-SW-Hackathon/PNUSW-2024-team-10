package com.example.hackdemo.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Photo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String photoUrl; // S3에 저장된 사진 URL

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user; // 업로드한 유저 정보

    @ManyToOne
    @JoinColumn(name = "course_id", nullable = false)
    private Course course; // 관련된 코스 정보

    private LocalDateTime uploadDate; // 업로드 날짜
}
