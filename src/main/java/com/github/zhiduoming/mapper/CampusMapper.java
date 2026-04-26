package com.github.zhiduoming.mapper;

import com.github.zhiduoming.vo.CampusVO;
import com.github.zhiduoming.pojo.Campus;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CampusMapper {

    /**
     * 根据校区 ID 查询校区记录。
     */
    @Select("SELECT id, university_id, name, address, province, city, lat, lng, description, " +
            "main_gate, hot_score, data_status, create_time, update_time, " +
            "is_deleted FROM campus WHERE id =#{id}")
    List<Campus> findAll(Long id);

    /**
     * 查询某个高校下的校区简要信息。
     */
    @Select("SELECT id, university_id, name, address, hot_score " +
            " FROM campus WHERE is_deleted=0 AND university_id=#{universityId}")
    List<CampusVO> selectCampusesByUniversityId(Long universityId);
}
