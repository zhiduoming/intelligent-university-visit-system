package com.github.zhiduoming.VO;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CampusVO {
    private Long id;
    private Long uniId;
    private String name;
    private String address;
    private Integer hotScore;
}
