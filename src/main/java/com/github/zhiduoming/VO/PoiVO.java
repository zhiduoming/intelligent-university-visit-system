package com.github.zhiduoming.VO;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PoiVO {
    private Long id;
    private Long campusId;
    private String name;
    private Integer category;
    private Integer suggestedDuration;
    private String intro;
    private String imageUrl;
    private Integer hotScore;
}
