package com.github.zhiduoming.service;

import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import java.util.List;

public interface UniversityService {


    List<UniversityListVO> listUniversities();

    UniversityDetailVO getUniversityDetail(Long universityId);
}
