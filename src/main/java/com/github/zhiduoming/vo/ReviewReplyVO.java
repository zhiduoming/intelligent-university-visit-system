package com.github.zhiduoming.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewReplyVO {
    private Long id;
    private Long reviewId;
    private Long userId;
    private String nickname;
    private String avatarUrl;
    private String content;
    private LocalDateTime createTime;
}
