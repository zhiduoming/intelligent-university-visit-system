package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.mapper.CampusMapper;
import com.github.zhiduoming.pojo.Campus;
import com.github.zhiduoming.service.CampusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CampusServiceImpl implements CampusService {

    @Autowired
    private CampusMapper campusMapper;

    @Override
    public List<Campus> findAllCampus(Long id) {
        return campusMapper.findAll(id);
    }
}
