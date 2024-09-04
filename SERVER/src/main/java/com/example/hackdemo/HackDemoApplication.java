package com.example.hackdemo;

import com.example.hackdemo.excel.ExcelService;
import com.fasterxml.jackson.databind.exc.InvalidFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

import java.io.IOException;

@SpringBootApplication
@EnableConfigurationProperties
public class HackDemoApplication implements CommandLineRunner{
	@Autowired
	private ExcelService excelService;
	public static void main(String[] args) {
		SpringApplication.run(HackDemoApplication.class, args);
	}

	//엑셀 데이터 추가
	@Override
	public void run(String... args) {
		try {
			if (!excelService.isDataLoaded("areas")) {
				String areaFilePath = "document/area.xlsx";
				excelService.readAndSaveAreas(areaFilePath);
				excelService.markDataAsLoaded("areas");
			}

			if (!excelService.isDataLoaded("restaurants")) {
				String restaurantFilePath = "document/restaurant.xlsx";
				excelService.readAndSaveRestaurants(restaurantFilePath);
				excelService.markDataAsLoaded("restaurants");
			}

			if (!excelService.isDataLoaded("tourSpots")) {
				String tourSpotFilePath = "document/tourSpot.xlsx";
				excelService.readAndSaveTourSpots(tourSpotFilePath);
				excelService.markDataAsLoaded("tourSpots");
			}

			if (!excelService.isDataLoaded("courses")) {
				String courseFilePath = "document/course.xlsx";
				excelService.readAndSaveCourses(courseFilePath);
				excelService.markDataAsLoaded("courses");
			}

		} catch (InvalidFormatException e) {
			System.err.println("Invalid format in one of the Excel files: " + e.getMessage());
		} catch (IOException e) {
			System.err.println("Error reading one of the Excel files: " + e.getMessage());
		}
	}

}
