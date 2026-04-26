package com.github.zhiduoming.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CampusVO {
    private Long id;
    private Long universityId;
    private String name;
    private String address;
    private Integer hotScore;
}
