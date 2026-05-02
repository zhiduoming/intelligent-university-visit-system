package com.github.zhiduoming.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserVO {
    private Long id;
    private String username;
    private String nickname;
    private String avatarUrl;
    private Integer role;
    private Integer identityType;
    private String highSchool;
    private Long targetUniId;
    private Long currentUniId;
    private Integer profileCompleted;
}
