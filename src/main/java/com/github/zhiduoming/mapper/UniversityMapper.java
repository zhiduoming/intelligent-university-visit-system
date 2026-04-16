package com.github.zhiduoming.mapper;

import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UniversityMapper {

    UniversityDetailVO selectUniversityById(@Param("universityId") Long universityId);

    // 查询大学列表，支持关键词模糊查询 + 省份/城市过滤
    List<UniversityListVO> selectUniversityList(@Param("keyword") String keyword,
                                                @Param("province") String province,
                                                @Param("city") String city);

}
