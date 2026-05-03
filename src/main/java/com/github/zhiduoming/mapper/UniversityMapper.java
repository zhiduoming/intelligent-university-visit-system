package com.github.zhiduoming.mapper;

import com.github.zhiduoming.vo.UniversityDetailVO;
import com.github.zhiduoming.vo.UniversityListVO;
import com.github.zhiduoming.vo.UniversityRatingVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UniversityMapper {

    /**
     * 查询高校基础信息和详情字段。
     */
    UniversityDetailVO selectUniversityById(@Param("universityId") Long universityId);

    /**
     * 聚合高校评价数据并返回评分结果。
     */
    UniversityRatingVO selectUniversityRating(@Param("universityId") Long universityId);

    /**
     * 查询高校列表，支持关键词、省份和城市筛选。
     */
    List<UniversityListVO> selectUniversityList(@Param("keyword") String keyword,
                                                @Param("province") String province,
                                                @Param("city") String city);

    /**
     * 按高校全称或简称精确匹配，用于用户资料中把学校名称解析成高校 ID。
     */
    List<UniversityListVO> selectUniversitiesByExactName(@Param("name") String name);

}
