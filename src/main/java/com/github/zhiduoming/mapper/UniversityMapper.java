package com.github.zhiduoming.mapper;

import com.github.zhiduoming.VO.UniversityDetailVO;
import com.github.zhiduoming.VO.UniversityListVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UniversityMapper {


    @Select("SELECT id , name, short_name, description, logo_url, " +
            "official_website, is_985, is_211, is_double_first_class, school_type, " +
            "province, city FROM university WHERE is_deleted =0 ORDER BY id ")
    List<UniversityListVO> selectUniversityList();

    @Select("SELECT id, name, short_name, description, logo_url, official_website, " +
            "is_985, is_211, is_double_first_class, school_type, province, city " +
            "FROM university WHERE is_deleted=0 AND id =#{universityId}")
    UniversityDetailVO selectUniversityById(Long universityId);
}
