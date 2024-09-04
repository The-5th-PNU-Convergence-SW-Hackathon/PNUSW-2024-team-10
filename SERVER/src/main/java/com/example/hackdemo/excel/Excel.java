package com.example.hackdemo.excel;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Data
@Entity
public class Excel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String dataName; // 데이터를 식별할 이름
    private boolean isLoaded; // 데이터가 로드되었는지 여부

    // Constructors, getters, and setters
    public Excel() {
    }

    public Excel(String dataName, boolean isLoaded) {
        this.dataName = dataName;
        this.isLoaded = isLoaded;
    }
}
