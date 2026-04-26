package com.github.zhiduoming.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UniversityListVO {
    private Long id;
    private String name;
    private String shortName;
    private String description;
    private String logoUrl;
    private String officialWebsite;
    private Integer is985;
    private Integer is211;
    private Integer isDoubleFirstClass;
    private String schoolType;
    private String educationLevel;
    private String tags;
    private String province;
    private String city;
    private BigDecimal overallScore;
    private Long reviewCount;
}
