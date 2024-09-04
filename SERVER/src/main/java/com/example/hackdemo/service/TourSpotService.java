package com.example.hackdemo.service;

import com.example.hackdemo.model.TourSpot;
import com.example.hackdemo.repository.TourSpotRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TourSpotService {
    @Autowired
    private TourSpotRepository tourSpotRepository;

    public List<TourSpot> getAllTourSpots() {
        return tourSpotRepository.findAll();
    }

    public TourSpot getTourSpotById(Long id) {
        return tourSpotRepository.findById(id).orElse(null);
    }

    public TourSpot saveTourSpot(TourSpot tourSpot) {
        return tourSpotRepository.save(tourSpot);
    }

    public void deleteTourSpot(Long id) {
        tourSpotRepository.deleteById(id);
    }
}