package com.github.zhiduoming.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CaptchaVO {
    private String captchaId;
    private String code;
    private Long expiresInSeconds;
}
