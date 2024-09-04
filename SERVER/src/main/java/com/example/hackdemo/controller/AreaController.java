package com.example.hackdemo.controller;

import com.example.hackdemo.dto.AreaDTO;
import com.example.hackdemo.model.Area;
import com.example.hackdemo.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/area")
public class AreaController {
    @Autowired
    private AreaService areaService;

    @GetMapping
    public List<AreaDTO> getAllAreas() {
        return areaService.getAllAreas().stream()
                .map(areaService::convertToAreaDTO)
                .collect(Collectors.toList());
    }

    @GetMapping("/{id}")
    public AreaDTO getAreaById(@PathVariable Long id) {
        Area area = areaService.getAreaById(id);
        return areaService.convertToAreaDTO(area);
    }

    /*    @PostMapping
    public Area createArea(@RequestBody Area area) {
        return areaService.saveArea(area);
    }

    @PutMapping("/{id}")
    public Area updateArea(@PathVariable Long id, @RequestBody Area area) {
        area.setId(id);
        return areaService.saveArea(area);
    }

    @DeleteMapping("/{id}")
    public void deleteArea(@PathVariable Long id) {
        areaService.deleteArea(id);
    }*/

}
