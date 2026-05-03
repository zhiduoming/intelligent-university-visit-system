package com.github.zhiduoming.service;

import com.github.zhiduoming.vo.PoiVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


public interface PoiService {

    /**
     * 查询指定校区下的 POI 列表。
     */
    List<PoiVO> listPoisByCampusId(Long campusId);

    /**
     * 管理员上传 POI 图片，并返回最新图片 URL。
     */
    String uploadPoiImage(Long userId, Long poiId, MultipartFile file);
}
