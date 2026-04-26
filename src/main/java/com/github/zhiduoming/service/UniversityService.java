package com.github.zhiduoming.service;

import com.github.zhiduoming.dto.UniversityPageQuery;
import com.github.zhiduoming.vo.UniversityDetailVO;
import com.github.zhiduoming.vo.UniversityListVO;
import com.github.zhiduoming.common.PageResult;

public interface UniversityService {

    /**
     * 按分页条件返回高校列表。
     */
    PageResult<UniversityListVO> listUniversities(UniversityPageQuery query);

    /**
     * 查询单个高校详情。
     */
    UniversityDetailVO getUniversityDetail(Long universityId);
}
