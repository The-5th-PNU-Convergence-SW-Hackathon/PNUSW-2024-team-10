package com.example.hackdemo.repository;

import com.example.hackdemo.model.CourseCompletion;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CourseCompletionRepository extends JpaRepository<CourseCompletion, Long> {
    long countByUserId(Long userId);
}
