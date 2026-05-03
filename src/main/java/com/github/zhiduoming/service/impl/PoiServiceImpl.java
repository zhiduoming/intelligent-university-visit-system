package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.vo.PoiVO;
import com.github.zhiduoming.mapper.PoiMapper;
import com.github.zhiduoming.mapper.UserMapper;
import com.github.zhiduoming.pojo.User;
import com.github.zhiduoming.service.OssUploadService;
import com.github.zhiduoming.service.PoiService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Service
public class PoiServiceImpl implements PoiService {

    private final PoiMapper poiMapper;
    private final UserMapper userMapper;
    private final OssUploadService ossUploadService;

    public PoiServiceImpl(PoiMapper poiMapper, UserMapper userMapper, OssUploadService ossUploadService) {
        this.poiMapper = poiMapper;
        this.userMapper = userMapper;
        this.ossUploadService = ossUploadService;
    }

    /**
     * 返回指定校区下的 POI 列表。
     */
    @Override
    public List<PoiVO> listPoisByCampusId(Long campusId) {
       return poiMapper.selectPoisByCampusId(campusId);
    }

    @Override
    public String uploadPoiImage(Long userId, Long poiId, MultipartFile file) {
        User user = checkAdmin(userId);
        PoiVO poi = poiMapper.selectPoiById(poiId);
        if (poi == null) {
            throw new RuntimeException("POI 不存在或已删除");
        }

        String imageUrl = ossUploadService.uploadPoiImage(poiId, file);
        int rows = poiMapper.updatePoiImageUrl(poiId, imageUrl);
        if (rows != 1) {
            throw new RuntimeException("POI 图片保存失败");
        }
        return imageUrl;
    }

    private User checkAdmin(Long userId) {
        if (userId == null) {
            throw new RuntimeException("用户未登录");
        }
        User user = userMapper.selectById(userId);
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("用户不存在或已被禁用");
        }
        if (user.getRole() == null || user.getRole() != 9) {
            throw new RuntimeException("无权限上传 POI 图片");
        }
        return user;
    }
}
