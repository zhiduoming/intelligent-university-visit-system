package com.github.zhiduoming.service;

import com.github.zhiduoming.dto.UpdateProfileDTO;
import com.github.zhiduoming.vo.UserVO;
import org.springframework.web.multipart.MultipartFile;

public interface UserService {
    /**
     * 查询当前登录用户信息。
     */
    UserVO getCurrentUser(Long userId);

    /**
     * 更新当前登录用户的资料完善信息。
     */
    UserVO updateProfile(Long userId, UpdateProfileDTO dto);

    /**
     * 上传并更新当前用户头像。
     */
    UserVO updateAvatar(Long userId, MultipartFile file);
}
