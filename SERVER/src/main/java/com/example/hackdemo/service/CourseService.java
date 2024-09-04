package com.example.hackdemo.service;

import com.example.hackdemo.dto.CourseDTO;
import com.example.hackdemo.dto.CourseItemDTO;
import com.example.hackdemo.model.Course;
import com.example.hackdemo.model.Area;
import com.example.hackdemo.model.CourseItem;
import com.example.hackdemo.repository.AreaRepository;
import com.example.hackdemo.repository.CourseItemRepository;
import com.example.hackdemo.repository.CourseRepository;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CourseService {
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private CourseItemService courseItemService;

    private CourseDTO convertToDTO(Course course) {
        Set<Long> areaIdSet = course.getAreas().stream()
                .map(Area::getId)
                .collect(Collectors.toSet());
        List<Long> areaIds = new ArrayList<>(areaIdSet);

        List<CourseItemDTO> courseItems = course.getCourseItems().stream()
                .map(this::convertItemToDTO)
                .collect(Collectors.toList());

        return new CourseDTO(course.getId(), course.getName(), course.getTheme(),
                course.getDuration(), course.getThumbnailUrl(), courseItems, areaIds);
    }

    private CourseItemDTO convertItemToDTO(CourseItem item) {
        Long restaurantId = item.getRestaurant() != null ? item.getRestaurant().getId() : null;
        String restaurantGoogleId = item.getRestaurant() != null ? item.getRestaurant().getGoogleId() : null;
        String restaurantName = item.getRestaurant() != null ? item.getRestaurant().getName() : null;

        Long tourSpotId = item.getTourSpot() != null ? item.getTourSpot().getId() : null;
        String tourSpotGoogleId = item.getTourSpot() != null ? item.getTourSpot().getGoogleId() : null;
        String tourSpotName = item.getTourSpot() != null ? item.getTourSpot().getName() : null;

        return new CourseItemDTO(
                item.getId(),
                restaurantId,
                restaurantGoogleId,
                restaurantName,
                tourSpotId,
                tourSpotGoogleId,
                tourSpotName,
                item.getDescription(),
                item.getMission(),
                item.getDuration()
        );
    }

    public List<CourseDTO> getAllCourses() {
        List<Course> courses = courseRepository.findAll();
        return courses.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public CourseDTO getCourseById(Long id) {
        Optional<Course> courseOptional = courseRepository.findById(id);
        return courseOptional.map(this::convertToDTO).orElse(null);
    }

    public Course saveCourse(Course course) {
        return courseRepository.save(course);
    }

    public void deleteCourse(Long id) {
        courseRepository.deleteById(id);
    }
}