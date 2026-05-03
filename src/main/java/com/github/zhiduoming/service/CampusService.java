package com.github.zhiduoming.service;

import org.springframework.web.multipart.MultipartFile;

public interface CampusService {

    /**
     * 管理员上传校区平面图，并返回最新图片 URL。
     */
    String uploadCampusMap(Long userId, Long campusId, MultipartFile file);
}
