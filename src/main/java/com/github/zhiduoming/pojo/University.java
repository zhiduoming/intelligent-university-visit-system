package com.github.zhiduoming.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class University {
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
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
