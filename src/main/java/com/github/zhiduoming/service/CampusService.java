package com.github.zhiduoming.service;

import com.github.zhiduoming.pojo.Campus;

import java.util.List;

public interface CampusService {

    /**
     * 查询指定高校下的全部校区信息。
     */
    List<Campus> findAllCampus(Long id);
}
