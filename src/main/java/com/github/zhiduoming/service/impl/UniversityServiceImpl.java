package com.github.zhiduoming.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.zhiduoming.DTO.UniversityPageQuery;
import com.github.zhiduoming.VO.CampusVO;
import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import com.github.zhiduoming.common.PageResult;
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


    /**
     * 分页查询大学列表
     *
     * @param query 查询条件，包含页码、每页数量、关键词、省份等信息
     * @return 分页结果，包含总记录数、当前页码、每页数量和大学列表数据
     */
    @Override
    public PageResult<UniversityListVO> listUniversities(UniversityPageQuery query) {
        int page = (query == null) ? 1 : query.safePage();
        int size = (query == null) ? 10 : query.safeSize();
        String keyword = (query == null) ? null : query.getKeyword();
        String province = (query == null) ? null : query.getProvince();

        PageHelper.startPage(page, size);
        List<UniversityListVO> universityList = universityMapper.selectUniversityList(keyword, province);
        PageInfo<UniversityListVO> pageInfo = new PageInfo<>(universityList);

        return new PageResult<>(
                pageInfo.getTotal(),
                pageInfo.getPageNum(),
                pageInfo.getPageSize(),
                pageInfo.getList()
        );
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
