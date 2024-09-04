package com.example.hackdemo.service;

import com.example.hackdemo.model.Course;
import com.example.hackdemo.model.CourseCompletion;
import com.example.hackdemo.model.User;
import com.example.hackdemo.repository.CourseCompletionRepository;
import com.example.hackdemo.repository.CourseRepository;
import com.example.hackdemo.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CourseCompletionService {

    @Autowired
    private CourseCompletionRepository completionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CourseRepository courseRepository;

    public void completeCourse(Long userId, Long courseId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new EntityNotFoundException("Course not found"));

        CourseCompletion completion = new CourseCompletion();
        completion.setUser(user);
        completion.setCourse(course);

        completionRepository.save(completion);
    }

    public long countCompletedCourses(Long userId) {
        return completionRepository.countByUserId(userId);
    }
}