package com.github.zhiduoming.dto;

import lombok.Data;

@Data
public class ForgotPasswordDTO {
    private String username;
    private String phone;
    private String newPassword;
}
