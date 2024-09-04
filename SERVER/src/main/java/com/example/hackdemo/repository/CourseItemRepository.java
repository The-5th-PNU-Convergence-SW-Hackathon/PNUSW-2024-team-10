package com.example.hackdemo.repository;

import com.example.hackdemo.model.CourseItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CourseItemRepository extends JpaRepository<CourseItem, Long> {}
