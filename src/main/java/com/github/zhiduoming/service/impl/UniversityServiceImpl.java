package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.mapper.UniversityMapper;
import com.github.zhiduoming.pojo.University;
import com.github.zhiduoming.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UniversityServiceImpl implements UniversityService {

    @Autowired
    private UniversityMapper universityMapper;

    @Override
    public List<University> findAll() {
        return universityMapper.findAll();
    }
}
