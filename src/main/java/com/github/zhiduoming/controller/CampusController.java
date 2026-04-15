package com.github.zhiduoming.controller;


import com.github.zhiduoming.VO.PoiVO;
import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.service.PoiService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/campuses")
public class CampusController {

    @Autowired
    private PoiService poiService;

    @GetMapping("/{campusId}/pois")
    public Result listPoisByCampusId(@PathVariable Long campusId) {
        log.info("根据校区ID列出对应的Poi");
        List<PoiVO> poiList = poiService.listPoisByCampusId(campusId);
        return Result.success(poiList);
    }

}
