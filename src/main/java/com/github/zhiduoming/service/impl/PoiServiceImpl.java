package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.vo.PoiVO;
import com.github.zhiduoming.mapper.PoiMapper;
import com.github.zhiduoming.service.PoiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class PoiServiceImpl implements PoiService {

    @Autowired
    private PoiMapper poiMapper;
    /**
     * 返回指定校区下的 POI 列表。
     */
    @Override
    public List<PoiVO> listPoisByCampusId(Long campusId) {
       return poiMapper.selectPoisByCampusId(campusId);
    }
}
