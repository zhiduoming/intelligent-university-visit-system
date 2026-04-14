package com.github.zhiduoming.mapper;

import com.github.zhiduoming.pojo.University;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UniversityMapper {


    @Select("SELECT id, name, short_name, description, logo_url, " +
            "official_website, is_985, is_211, is_double_first_class, school_type, " +
            "province, city, create_time, update_time, is_deleted FROM university")
    List<University> findAll();
}
