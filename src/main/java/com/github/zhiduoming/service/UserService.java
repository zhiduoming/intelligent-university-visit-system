package com.github.zhiduoming.service;

import com.github.zhiduoming.dto.UpdateProfileDTO;
import com.github.zhiduoming.vo.UserVO;

public interface UserService {
    /**
     * 查询当前登录用户信息。
     */
    UserVO getCurrentUser(Long userId);

    /**
     * 更新当前登录用户的资料完善信息。
     */
    UserVO updateProfile(Long userId, UpdateProfileDTO dto);
}
