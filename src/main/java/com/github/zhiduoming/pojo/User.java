package com.github.zhiduoming.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Long id;
    private String username;
    private String password;
    private String nickname;
    private String avatarUrl;
    private Integer role;
    private Integer identityType;
    private String highSchool;
    private Long targetUniId;
    private Long currentUniId;
    private Integer profileCompleted;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
