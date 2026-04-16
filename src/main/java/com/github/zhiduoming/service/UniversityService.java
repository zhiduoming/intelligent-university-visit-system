package com.github.zhiduoming.service;

import com.github.zhiduoming.DTO.UniversityPageQuery;
import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import com.github.zhiduoming.common.PageResult;

public interface UniversityService {


    PageResult<UniversityListVO> listUniversities(UniversityPageQuery query);

    UniversityDetailVO getUniversityDetail(Long universityId);
}
