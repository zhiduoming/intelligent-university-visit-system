package com.github.zhiduoming.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UniversityReview {
    private Long id;
    private Long userId;
    private Long universityId;
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
    private BigDecimal overallScore;
    private Integer isAnonymous;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
