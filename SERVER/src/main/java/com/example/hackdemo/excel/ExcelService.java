package com.example.hackdemo.excel;


import com.example.hackdemo.model.*;
import com.example.hackdemo.repository.AreaRepository;
import com.example.hackdemo.repository.CourseRepository;
import com.example.hackdemo.repository.RestaurantRepository;
import com.example.hackdemo.repository.TourSpotRepository;
import com.fasterxml.jackson.databind.exc.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class ExcelService {

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private TourSpotRepository tourSpotRepository;

    @Autowired
    private AreaRepository areaRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private ExcelRepository excelRepository;

    public void readAndSaveAreas(String filePath) throws IOException, InvalidFormatException {
        FileInputStream file = new FileInputStream(new File(filePath));
        Workbook workbook = WorkbookFactory.create(file);
        Sheet sheet = workbook.getSheetAt(0);

        for (Row row : sheet) {
            Area area = new Area();
            area.setName(row.getCell(0).getStringCellValue());
            area.setXCoordinate(row.getCell(1).getNumericCellValue());
            area.setYCoordinate(row.getCell(2).getNumericCellValue());
            area.setGoogleId(row.getCell(3).getStringCellValue());
            areaRepository.save(area);
            workbook.close();
            file.close();
        }
    }

    public void readAndSaveRestaurants(String filePath) throws IOException, InvalidFormatException {
        FileInputStream file = new FileInputStream(new File(filePath));
        Workbook workbook = WorkbookFactory.create(file);
        Sheet sheet = workbook.getSheetAt(0);

        for (Row row : sheet) {
            if (row.getRowNum() == 0) {
                continue; // 헤더 행 건너뛰기
            }

            Restaurant restaurant = new Restaurant();
            restaurant.setName(row.getCell(0).getStringCellValue());
            restaurant.setFoodType(row.getCell(1).getStringCellValue());
            restaurant.setEatingAlone(row.getCell(2).getStringCellValue());
            restaurant.setHalalOrVegan(row.getCell(3).getStringCellValue());
            restaurant.setMichelinGuide(row.getCell(4).getStringCellValue());
            restaurant.setAddress(row.getCell(5).getStringCellValue());
            restaurant.setMainMenu(row.getCell(6).getStringCellValue());

            String areaName = row.getCell(7).getStringCellValue();
            Area area = areaRepository.findByName(areaName);
            if (area == null) {
                area = new Area();
                area.setName(areaName);
                areaRepository.save(area);
            }
            restaurant.setArea(area);
            restaurant.setGoogleId(row.getCell(8).getStringCellValue());
            restaurant.setXCoordinate(row.getCell(9).getNumericCellValue());
            restaurant.setYCoordinate(row.getCell(10).getNumericCellValue());


            restaurantRepository.save(restaurant);
            workbook.close();
            file.close();
        }


    }

    public void readAndSaveTourSpots(String filePath) throws IOException, InvalidFormatException {
        FileInputStream file = new FileInputStream(new File(filePath));
        Workbook workbook = WorkbookFactory.create(file);
        Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트에 데이터가 있다고 가정

        for (Row row : sheet) {
            if (row.getRowNum() == 0) {
                continue; // 헤더 행 건너뛰기
            }

            TourSpot tourSpot = new TourSpot();

            tourSpot.setTheme(row.getCell(0).getStringCellValue());
            tourSpot.setName(row.getCell(1).getStringCellValue());
            tourSpot.setAddress(row.getCell(2).getStringCellValue());

            String areaName = row.getCell(3).getStringCellValue();
            Area area = areaRepository.findByName(areaName);
            if (area == null) {
                area = new Area();
                area.setName(areaName);
                areaRepository.save(area);
            }
            tourSpot.setArea(area);

            tourSpot.setGoogleId(row.getCell(4).getStringCellValue());
            tourSpot.setXCoordinate(row.getCell(5).getNumericCellValue());
            tourSpot.setYCoordinate(row.getCell(6).getNumericCellValue());

            tourSpotRepository.save(tourSpot);
        }

        workbook.close();
        file.close();
    }

    public void readAndSaveCourses(String filePath) throws IOException, InvalidFormatException {
        FileInputStream file = new FileInputStream(new File(filePath));
        Workbook workbook = WorkbookFactory.create(file);
        Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트

        for (Row row : sheet) {
            if (row.getRowNum() == 0) {
                continue; // 헤더 행 건너뛰기
            }

            Course course = new Course();
            List<CourseItem> courseItems = new ArrayList<>();
            Set<Area> courseAreas = new HashSet<>(); // Area 중복 방지

            course.setThumbnailUrl(getCellValue(row.getCell(0)));
            course.setLandmark(getCellValue(row.getCell(1)));
            course.setName(getCellValue(row.getCell(2)));
            course.setTheme(getCellValue(row.getCell(3)));
            course.setDuration(getCellValue(row.getCell(4)));

            for (int i = 5; i < row.getLastCellNum(); i += 4) {
                CourseItem courseItem = new CourseItem();

                String placeName = getCellValue(row.getCell(i));
                String description = getCellValue(row.getCell(i + 1));
                String mission = getCellValue(row.getCell(i + 2));
                String time = getCellValue(row.getCell(i + 3));

                Restaurant restaurant = restaurantRepository.findByName(placeName);
                TourSpot tourSpot = tourSpotRepository.findByName(placeName);

                if (restaurant != null) {
                    courseItem.setRestaurant(restaurant);
                    if (restaurant.getArea() != null) { // Null 체크
                        courseAreas.add(restaurant.getArea());
                    }
                }
                if (tourSpot != null) {
                    courseItem.setTourSpot(tourSpot);
                    if (tourSpot.getArea() != null) { // Null 체크
                        courseAreas.add(tourSpot.getArea());
                    }
                }

                courseItem.setDescription(description);
                courseItem.setMission(mission);
                courseItem.setDuration(time);
                courseItem.setCourse(course);

                courseItems.add(courseItem);
            }

            course.setCourseItems(courseItems);
            course.setAreas(new ArrayList<>(courseAreas)); // Set을 List로 변환하여 저장
            courseRepository.save(course);
        }

        workbook.close();
        file.close();
    }

    private String getCellValue(Cell cell) {
        if (cell == null) {
            return ""; // 기본 값 반환 또는 다른 처리
        }
        return cell.getStringCellValue().trim();
    }

    public boolean isDataLoaded(String dataName) {
        return excelRepository.existsByDataNameAndIsLoadedTrue(dataName);
    }

    public void markDataAsLoaded(String dataName) {
        Excel excel = excelRepository.findByDataName(dataName);
        if (excel == null) {
            excel = new Excel(dataName, true);
        } else {
            excel.setLoaded(true);
        }
        excelRepository.save(excel);
    }
}

