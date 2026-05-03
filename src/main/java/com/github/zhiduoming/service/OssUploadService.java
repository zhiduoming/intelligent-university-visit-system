package com.github.zhiduoming.service;

import org.springframework.web.multipart.MultipartFile;

public interface OssUploadService {
    /**
     * 上传当前用户头像，并返回可公开访问的图片 URL。
     */
    String uploadAvatar(Long userId, MultipartFile file);

    /**
     * 上传 POI 图片，并返回可公开访问的图片 URL。
     */
    String uploadPoiImage(Long poiId, MultipartFile file);

    /**
     * 上传校区平面图，并返回可公开访问的图片 URL。
     */
    String uploadCampusMap(Long campusId, MultipartFile file);
}
