package com.github.zhiduoming.controller;

import com.github.zhiduoming.dto.UniversityPageQuery;
import com.github.zhiduoming.vo.UniversityDetailVO;
import com.github.zhiduoming.vo.UniversityListVO;
import com.github.zhiduoming.common.PageResult;
import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.service.UniversityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping({"/universities", "/api/v1/universities"})
public class UniversityController {

    @Autowired
    private UniversityService universityService;

    /**
     * 分页查询高校列表，支持关键词和地区筛选。
     */
    @GetMapping
    public Result listUniversities(@ModelAttribute UniversityPageQuery query){
        log.info("查询所有大学信息,page={},size={},keyword={},province={},city={}",
                query.getPage(),query.getSize(),query.getKeyword(),query.getProvince(),query.getCity());
        PageResult<UniversityListVO> pageResult = universityService.listUniversities(query);
        return Result.success(pageResult);
    }

    /**
     * 根据高校 ID 查询详情，同时返回校区列表和评分汇总。
     */
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
