package com.example.hackdemo.repository;

import com.example.hackdemo.dto.CourseDTO;
import com.example.hackdemo.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CourseRepository extends JpaRepository<Course, Long> {
    List<Course> findByName(String name);
}
