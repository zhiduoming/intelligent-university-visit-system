package com.github.zhiduoming.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginVO {
    private Long id;
    private String username;
    private String phone;
    private String nickname;
    private String token;
}
