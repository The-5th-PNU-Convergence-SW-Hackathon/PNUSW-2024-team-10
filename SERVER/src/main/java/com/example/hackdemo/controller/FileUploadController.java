package com.example.hackdemo.controller;

import com.example.hackdemo.model.Course;
import com.example.hackdemo.model.User;
import com.example.hackdemo.repository.CourseRepository;
import com.example.hackdemo.service.S3Service;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.io.IOException;

@RestController
@RequestMapping("/api/upload")
public class FileUploadController {

    @Autowired
    private S3Service s3Service;

    @Autowired
    private CourseRepository courseRepository; // CourseRepository 추가

    @PostMapping("/photo/{courseId}")
    public ResponseEntity<?> uploadPhoto(@PathVariable Long courseId, @RequestParam("file") MultipartFile file) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal(); // JWT로부터 인증된 사용자 정보

        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new EntityNotFoundException("Course not found"));

        try {
            String fileUrl = s3Service.uploadFile(file, user, course); // 유저와 코스 정보 함께 업로드
            return ResponseEntity.ok(fileUrl);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Upload failed: " + e.getMessage());
        }
    }
}
