package com.example.hackdemo.controller;

import com.example.hackdemo.model.CourseItem;
import com.example.hackdemo.service.CourseItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/courseItem")
public class CourseItemController {
    @Autowired
    private CourseItemService courseItemService;

    @GetMapping
    public List<CourseItem> getAllCourseItems() {
        return courseItemService.getAllCourseItems();
    }

    @GetMapping("/{id}")
    public CourseItem getCourseItemById(@PathVariable Long id) {
        return courseItemService.getCourseItemById(id);
    }

    /*
    @PostMapping
    public CourseItem createCourseItem(@RequestBody CourseItem courseItem) {
        return courseItemService.saveCourseItem(courseItem);
    }

    @PutMapping("/{id}")
    public CourseItem updateCourseItem(@PathVariable Long id, @RequestBody CourseItem courseItem) {
        courseItem.setId(id);
        return courseItemService.saveCourseItem(courseItem);
    }

    @DeleteMapping("/{id}")
    public void deleteCourseItem(@PathVariable Long id) {
        courseItemService.deleteCourseItem(id);
    }
    */
}
