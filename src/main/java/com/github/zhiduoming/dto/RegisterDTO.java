package com.github.zhiduoming.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegisterDTO {
    private String username;
    private String phone;
    private String password;
    private String nickname;
    private String captchaId;
    private String captchaCode;
}
