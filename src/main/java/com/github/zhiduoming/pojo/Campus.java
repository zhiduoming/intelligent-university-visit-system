package com.github.zhiduoming.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Campus {
    private Long id;
    private Long uniId;
    private String name;
    private String address;
    private String province;
    private String city;
    private Double lat;
    private Double lng;
    private String description;
    private String mainGate;
    private Integer hotScore;
    private Integer dataStatus;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
