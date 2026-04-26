package com.github.zhiduoming.controller;


import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.dto.UpdateProfileDTO;
import com.github.zhiduoming.service.UserService;
import com.github.zhiduoming.vo.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
@Slf4j
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    /**
     * 返回当前登录用户的基础信息和资料完善状态。
     */
    @GetMapping("/me")
    public Result me(HttpServletRequest request) {
        log.info("查看个人信息");
        Long userId = (Long) request.getAttribute("userId");
        UserVO currentUser = userService.getCurrentUser(userId);
        return Result.success(currentUser);

    }

    /**
     * 允许当前登录用户补充身份、目标高校等资料。
     */
    @PutMapping("/me/profile")
    public Result updateProfile(@RequestBody UpdateProfileDTO dto, HttpServletRequest request) {
        log.info("完善个人资料");
        Long userId = (Long) request.getAttribute("userId");
        UserVO currentUser = userService.updateProfile(userId, dto);
        return Result.success(currentUser);
    }
}
