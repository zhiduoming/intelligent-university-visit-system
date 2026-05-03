package com.github.zhiduoming.controller;


import com.github.zhiduoming.vo.PoiVO;
import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.service.CampusService;
import com.github.zhiduoming.service.PoiService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Slf4j
@RestController
@RequestMapping({"/campuses", "/api/v1/campuses"})
public class CampusController {

    @Autowired
    private PoiService poiService;

    @Autowired
    private CampusService campusService;

    /**
     * 根据校区 ID 查询该校区下的 POI 列表。
     */
    @GetMapping("/{campusId}/pois")
    public Result listPoisByCampusId(@PathVariable Long campusId) {
        log.info("根据校区ID列出对应的Poi");
        List<PoiVO> poiList = poiService.listPoisByCampusId(campusId);
        return Result.success(poiList);
    }

    /**
     * 管理员上传校区平面图。
     */
    @PostMapping("/{campusId}/map")
    public Result uploadCampusMap(@PathVariable Long campusId,
                                  @RequestParam("file") MultipartFile file,
                                  HttpServletRequest request) {
        log.info("上传校区平面图, campusId={}", campusId);
        Long userId = (Long) request.getAttribute("userId");
        String mapImageUrl = campusService.uploadCampusMap(userId, campusId, file);
        return Result.success(mapImageUrl);
    }

}
