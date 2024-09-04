package com.example.hackdemo.excel;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ExcelRepository extends JpaRepository<Excel, Long> {
    Excel findByDataName(String dataName); // 데이터를 이름으로 찾기 위한 메소드
    boolean existsByDataNameAndIsLoadedTrue(String dataName); // 로드 여부 확인 메소드
}