package com.github.zhiduoming.dto;

import lombok.Data;

@Data
public class ReviewCreateDTO {
    private Long campusId;
    private String content;
    private Integer dormitoryScore;
    private Integer canteenScore;
    private Integer locationScore;
    private Integer studyScore;
    private Integer cultureScore;
    private Integer clubScore;
    private Integer employmentScore;
    private Integer campusScore;
    private Integer isAnonymous;
}
