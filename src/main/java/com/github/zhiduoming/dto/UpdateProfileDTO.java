package com.github.zhiduoming.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateProfileDTO {
    private String nickname;
    private Integer identityType;
    private String highSchool;
    private Long targetUniId;
    private Long currentUniId;
}
