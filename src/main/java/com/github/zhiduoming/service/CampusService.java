package com.github.zhiduoming.service;

import com.github.zhiduoming.pojo.Campus;

import java.util.List;

public interface CampusService {

    List<Campus> findAllCampus(Long id);
}
