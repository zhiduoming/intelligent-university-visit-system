package com.github.zhiduoming.controller;

import com.github.zhiduoming.DTO.UniversityPageQuery;
import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import com.github.zhiduoming.common.PageResult;
import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.service.UniversityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("universities")
public class UniversityController {

    @Autowired
    private UniversityService universityService;


    @GetMapping
    public Result listUniversities(@ModelAttribute UniversityPageQuery query){
        log.info("查询所有大学信息,page={},size={},keyword={},province={}",
                query.getPage(),query.getSize(),query.getKeyword(),query.getProvince());
        PageResult<UniversityListVO> pageResult = universityService.listUniversities(query);
        return Result.success(pageResult);
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
