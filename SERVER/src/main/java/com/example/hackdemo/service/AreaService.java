package com.example.hackdemo.service;

import com.example.hackdemo.dto.AreaDTO;
import com.example.hackdemo.dto.RestaurantDTO;
import com.example.hackdemo.dto.TourSpotDTO;
import com.example.hackdemo.model.Area;
import com.example.hackdemo.model.Restaurant;
import com.example.hackdemo.model.TourSpot;
import com.example.hackdemo.repository.AreaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AreaService {
    @Autowired
    private AreaRepository areaRepository;

    public AreaDTO convertToAreaDTO(Area area) {
        List<RestaurantDTO> restaurantDTOs = area.getRestaurants().stream().map(this::convertToRestaurantDTO).collect(Collectors.toList());
        List<TourSpotDTO> tourSpotDTOs = area.getTouristSpots().stream().map(this::convertToTourSpotDTO).collect(Collectors.toList());

        return new AreaDTO(
                area.getId(),
                area.getName(),
                area.getXCoordinate(),
                area.getYCoordinate(),
                restaurantDTOs,
                tourSpotDTOs
        );
    }

    public RestaurantDTO convertToRestaurantDTO(Restaurant restaurant) {
        return new RestaurantDTO(
                restaurant.getId(),
                restaurant.getName(),
                restaurant.getXCoordinate(),
                restaurant.getYCoordinate()
        );
    }

    public TourSpotDTO convertToTourSpotDTO(TourSpot tourSpot) {
        return new TourSpotDTO(
                tourSpot.getId(),
                tourSpot.getName(),
                tourSpot.getXCoordinate(),
                tourSpot.getYCoordinate()
        );
    }

    public List<Area> getAllAreas() {
        return areaRepository.findAll();
    }

    public Area getAreaById(Long id) {
        return areaRepository.findById(id).orElse(null);
    }

    public Area saveArea(Area area) {
        return areaRepository.save(area);
    }

    public void deleteArea(Long id) {
        areaRepository.deleteById(id);
    }
    
}