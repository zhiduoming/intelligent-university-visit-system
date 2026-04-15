package com.github.zhiduoming.service.impl;

import com.github.zhiduoming.VO.CampusVO;
import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import com.github.zhiduoming.mapper.CampusMapper;
import com.github.zhiduoming.mapper.UniversityMapper;
import com.github.zhiduoming.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UniversityServiceImpl implements UniversityService {

    @Autowired
    private UniversityMapper universityMapper;
    @Autowired
    private CampusMapper campusMapper;

    @Override
    public List<UniversityListVO> listUniversities() {
        return universityMapper.selectUniversityList();
    }

    @Override
    public UniversityDetailVO getUniversityDetail(Long universityId) {
        UniversityDetailVO universityDetail = universityMapper.selectUniversityById(universityId);
        if (universityDetail == null) {
            return null;
        }
        List<CampusVO> campusList = campusMapper.selectCampusesByUniversityId(universityId);
        universityDetail.setCampusList(campusList);
        return universityDetail;
    }


}
