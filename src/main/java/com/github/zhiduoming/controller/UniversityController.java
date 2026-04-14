package com.github.zhiduoming.controller;

import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.pojo.University;
import com.github.zhiduoming.service.UniversityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/universities")
public class UniversityController {

    @Autowired
    private UniversityService universityService;

    @GetMapping
    public Result list(){
        log.info("查询所有大学信息");
        List<University> universityList= universityService.findAll();
        return Result.success(universityList);
    }

}
