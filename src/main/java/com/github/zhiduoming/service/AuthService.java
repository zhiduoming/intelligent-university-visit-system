package com.github.zhiduoming.service;

import com.github.zhiduoming.dto.LoginDTO;
import com.github.zhiduoming.dto.ForgotPasswordDTO;
import com.github.zhiduoming.dto.RegisterDTO;
import com.github.zhiduoming.vo.CaptchaVO;
import com.github.zhiduoming.vo.LoginVO;

public interface AuthService {
    /**
     * 完成注册参数校验、查重和密码加密入库。
     */
    void register(RegisterDTO dto);

    /**
     * 校验登录信息并返回登录结果。
     */
    LoginVO login(LoginDTO dto);

    /**
     * 通过用户名和绑定手机号校验身份后重置密码。
     */
    void resetPassword(ForgotPasswordDTO dto);

    /**
     * 生成注册时所需验证码并临时保存到 Redis
     */
    CaptchaVO generateRegisterCaptcha();
}
