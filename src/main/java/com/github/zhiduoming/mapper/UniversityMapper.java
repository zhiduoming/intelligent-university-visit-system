package com.github.zhiduoming.mapper;

import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UniversityMapper {

    @Select("SELECT id, name, short_name, description, logo_url, official_website, " +
            "is_985, is_211, is_double_first_class, school_type, province, city " +
            "FROM university WHERE is_deleted=0 AND id =#{universityId}")
    UniversityDetailVO selectUniversityById(Long universityId);

    //查询大学列表，同时按照关键词进行模糊查询，支持省份过滤
    @Select("SELECT id, name, short_name, description, logo_url, " +
            "official_website, is_985, is_211, is_double_first_class, school_type, province, city " +
            "FROM university " +
            "WHERE is_deleted = 0 " +
            "AND (#{keyword} IS NULL OR #{keyword} = '' " +
            "     OR name LIKE CONCAT('%', #{keyword}, '%') " +
            "     OR short_name LIKE CONCAT('%', #{keyword}, '%')) " +
            "AND (#{province} IS NULL OR #{province} = '' OR province = #{province}) " +
            "ORDER BY id ")
    List<UniversityListVO> selectUniversityList(@Param("keyword") String keyword,
                                                @Param("province") String province);

}
