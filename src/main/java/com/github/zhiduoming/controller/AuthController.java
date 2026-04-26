package com.github.zhiduoming.controller;

import com.github.zhiduoming.dto.LoginDTO;
import com.github.zhiduoming.dto.RegisterDTO;
import com.github.zhiduoming.vo.LoginVO;
import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.service.AuthService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@Slf4j
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    /**
     * 接收注册请求并调用认证服务完成用户注册。
     */
    @PostMapping("/register")
    public Result register(@RequestBody RegisterDTO dto) {
        log.info("用户注册：username={}", dto == null ? null : dto.getUsername());
        authService.register(dto);
        return Result.success();
    }

    /**
     * 校验用户名密码，登录成功后返回 JWT 和基础用户信息。
     */
    @PostMapping("/login")
    public Result login(@RequestBody LoginDTO dto){
        log.info("用户登录，username={}",dto==null?null:dto.getUsername());
        //调用 service 层
       LoginVO loginVO = authService.login(dto);
        return Result.success(loginVO);
    }

}
