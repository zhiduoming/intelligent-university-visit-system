package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.common.RedisKeyConstants;
import com.github.zhiduoming.mapper.CampusMapper;
import com.github.zhiduoming.mapper.UserMapper;
import com.github.zhiduoming.pojo.User;
import com.github.zhiduoming.service.CampusService;
import com.github.zhiduoming.service.OssUploadService;
import com.github.zhiduoming.vo.CampusVO;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CampusServiceImpl implements CampusService {

    private final CampusMapper campusMapper;
    private final UserMapper userMapper;
    private final OssUploadService ossUploadService;
    private final StringRedisTemplate stringRedisTemplate;

    public CampusServiceImpl(CampusMapper campusMapper, UserMapper userMapper, OssUploadService ossUploadService, StringRedisTemplate stringRedisTemplate) {
        this.campusMapper = campusMapper;
        this.userMapper = userMapper;
        this.ossUploadService = ossUploadService;
        this.stringRedisTemplate = stringRedisTemplate;
    }

    @Override
    public String uploadCampusMap(Long userId, Long campusId, MultipartFile file) {
        checkAdmin(userId);
        CampusVO campus = campusMapper.selectCampusById(campusId);
        if (campus == null) {
            throw new RuntimeException("校区不存在或已删除");
        }

        String mapImageUrl = ossUploadService.uploadCampusMap(campusId, file);
        int rows = campusMapper.updateCampusMapImageUrl(campusId, mapImageUrl);
        if (rows != 1) {
            throw new RuntimeException("校区平面图保存失败");
        }
        stringRedisTemplate.delete(RedisKeyConstants.universityDetailKey(campus.getUniversityId()));
        return mapImageUrl;
    }

    private void checkAdmin(Long userId) {
        if (userId == null) {
            throw new RuntimeException("用户未登录");
        }
        User user = userMapper.selectById(userId);
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("用户不存在或已被禁用");
        }
        if (user.getRole() == null || user.getRole() != 9) {
            throw new RuntimeException("无权限上传校区平面图");
        }
    }
}
