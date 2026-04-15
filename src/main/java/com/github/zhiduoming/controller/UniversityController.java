package com.github.zhiduoming.controller;

import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.service.UniversityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("universities")
public class UniversityController {

    @Autowired
    private UniversityService universityService;


    @GetMapping
    public Result listUniversities(){
        log.info("查询所有大学信息");
        List<UniversityListVO> universityList= universityService.listUniversities();
        return Result.success(universityList);
    }

    @GetMapping("/{universityId}")
    public Result getUniversityDetail(@PathVariable Long universityId){
        log.info("根据大学ID查询大学详情");
        UniversityDetailVO universityDetail =  universityService.getUniversityDetail(universityId);
        if (universityDetail == null) {
            return Result.error("大学不存在");
        }
        return Result.success(universityDetail);
    }


}
