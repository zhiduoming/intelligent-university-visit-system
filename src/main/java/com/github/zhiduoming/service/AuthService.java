package com.github.zhiduoming.service;

import com.github.zhiduoming.dto.LoginDTO;
import com.github.zhiduoming.dto.RegisterDTO;
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
}
