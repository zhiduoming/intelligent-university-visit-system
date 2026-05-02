package com.github.zhiduoming.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
    private Long id;
    private Long userId;
    private String nickname;
    private Long universityId;
    private Long campusId;
    private String campusName;
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
    private Long likeCount;
    private Long replyCount;
    private Boolean likedByCurrentUser;
    private List<ReviewReplyVO> replies;
}
