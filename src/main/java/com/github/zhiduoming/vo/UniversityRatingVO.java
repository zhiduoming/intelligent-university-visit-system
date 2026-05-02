package com.github.zhiduoming.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UniversityRatingVO {
    private BigDecimal dormitoryScore;
    private BigDecimal canteenScore;
    private BigDecimal locationScore;
    private BigDecimal studyScore;
    private BigDecimal cultureScore;
    private BigDecimal clubScore;
    private BigDecimal employmentScore;
    private BigDecimal campusScore;
    private BigDecimal overallScore;
    private Long reviewCount;
}
