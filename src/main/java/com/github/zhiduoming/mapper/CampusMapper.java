package com.github.zhiduoming.mapper;

import com.github.zhiduoming.VO.CampusVO;
import com.github.zhiduoming.pojo.Campus;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CampusMapper {

    @Select("SELECT name, address, province, city, lat, lng, description, " +
            "main_gate, hot_score, data_status, create_time, update_time, " +
            "is_deleted FROM campus WHERE id =#{id}")
    List<Campus> findAll(Long id);

    @Select("SELECT id, uni_id, name, address , hot_score " +
            " FROM campus WHERE is_deleted=0 AND uni_id=#{universityId}")
    List<CampusVO> selectCampusesByUniversityId(Long universityId);
}
