package com.example.hackdemo.controller;

import com.example.hackdemo.dto.FavoriteCourseDTO;
import com.example.hackdemo.model.CustomUserDetails;
import com.example.hackdemo.dto.CourseDTO;
import com.example.hackdemo.model.*;
import com.example.hackdemo.repository.CourseRepository;
import com.example.hackdemo.service.CourseCompletionService;
import com.example.hackdemo.service.CourseService;
import com.example.hackdemo.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/course")
public class CourseController {
    private static final Logger logger = LoggerFactory.getLogger(CourseController.class);

    @Autowired
    private CourseService courseService;
    @Autowired
    private UserService userService;
    @Autowired
    private CourseCompletionService completionService;
    @Autowired
    private CourseRepository courseRepository;

    @GetMapping
    public List<CourseDTO> getAllCourses() {
        return courseService.getAllCourses();
    }

    @GetMapping("/{id}")
    public CourseDTO getCourseById(@PathVariable Long id) {
        return courseService.getCourseById(id);
    }

    @GetMapping("/favorites")
    public ResponseEntity<List<FavoriteCourseDTO>> getFavoriteCourse(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        Object principal = authentication.getPrincipal();
        logger.info("Principal class: {}", principal.getClass().getName());

        if (!(principal instanceof CustomUserDetails)) {
            logger.error("Principal is not an instance of CustomUserDetails. Actual: {}", principal.getClass());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

        CustomUserDetails userDetails = (CustomUserDetails) principal;
        Long userId = userDetails.getId();
        List<Course> favorites = userService.getFavoriteCourses(userId);

        List<FavoriteCourseDTO> favoriteCourseDTOS = favorites.stream()
                .map(course -> new FavoriteCourseDTO(
                        course.getId(),
                        course.getName(),
                        course.getTheme(),
                        course.getDuration(),
                        course.getThumbnailUrl(),
                        course.getLandmark()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(favoriteCourseDTOS);
    }

    @PostMapping("/{courseId}/complete")
    public ResponseEntity<?> completeCourse(
            @PathVariable Long courseId,
            Authentication authentication) {
        User user = (User) authentication.getPrincipal();
        completionService.completeCourse(user.getId(), courseId);
        return ResponseEntity.ok("Course completed successfully");
    }

    @GetMapping("/completed/count")
    public ResponseEntity<Long> getCompletedCourseCount(Authentication authentication) {
        User user = (User) authentication.getPrincipal();
        long completedCount = completionService.countCompletedCourses(user.getId());
        return ResponseEntity.ok(completedCount);
    }

    /*
    @PostMapping("/{id}/favorites")
    public ResponseEntity<?> toggleFavoriteCourse(@PathVariable Long id, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User must be logged in to favorite a Course");
        }

        Long userId = Long.parseLong(authentication.getName());
        userService.toggleFavorite(userId,null,null ,id);

        return ResponseEntity.ok().build();
    }

    @PostMapping
    public Course createCourse(@RequestBody Course course) {
        return courseService.saveCourse(course);
    }

    @PutMapping("/{id}")
    public Course updateCourse(@PathVariable Long id, @RequestBody Course course) {
        course.setId(id);
        return courseService.saveCourse(course);
    }

    @DeleteMapping("/{id}")
    public void deleteCourse(@PathVariable Long id) {
        courseService.deleteCourse(id);
    }*/
}
