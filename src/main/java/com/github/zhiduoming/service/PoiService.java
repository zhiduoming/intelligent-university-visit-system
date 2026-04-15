package com.github.zhiduoming.service;

import com.github.zhiduoming.VO.PoiVO;

import java.util.List;


public interface PoiService {

    List<PoiVO> listPoisByCampusId(Long campusId);
}
