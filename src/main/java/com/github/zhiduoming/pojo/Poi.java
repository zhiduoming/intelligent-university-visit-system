package com.github.zhiduoming.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Poi {
    private Long id;
    private Long campus_id;
    private String name;
    private Integer category;
    private Integer suggestedDuration;
    private String intro;
    private String imageUrl;
    private String hotScore;
    private Integer dataStatus;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
