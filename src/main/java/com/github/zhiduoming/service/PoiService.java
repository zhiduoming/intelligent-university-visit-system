package com.github.zhiduoming.service;

import com.github.zhiduoming.vo.PoiVO;

import java.util.List;


public interface PoiService {

    /**
     * 查询指定校区下的 POI 列表。
     */
    List<PoiVO> listPoisByCampusId(Long campusId);
}
