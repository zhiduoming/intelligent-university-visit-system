package com.github.zhiduoming.controller;

import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.service.PoiService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RestController
@RequestMapping("/api/v1/pois")
public class PoiController {

    private final PoiService poiService;

    public PoiController(PoiService poiService) {
        this.poiService = poiService;
    }

    /**
     * 管理员上传 POI 图片。
     */
    @PostMapping("/{poiId}/image")
    public Result uploadPoiImage(@PathVariable Long poiId,
                                 @RequestParam("file") MultipartFile file,
                                 HttpServletRequest request) {
        log.info("上传 POI 图片, poiId={}", poiId);
        Long userId = (Long) request.getAttribute("userId");
        String imageUrl = poiService.uploadPoiImage(userId, poiId, file);
        return Result.success(imageUrl);
    }
}
