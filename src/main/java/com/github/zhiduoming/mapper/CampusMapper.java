package com.github.zhiduoming.mapper;

import com.github.zhiduoming.vo.CampusVO;
import com.github.zhiduoming.pojo.Campus;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface CampusMapper {

    /**
     * 根据校区 ID 查询校区记录。
     */
    @Select("SELECT id, university_id, name, address, province, city, lat, lng, description, " +
            "map_image_url AS mapImageUrl, main_gate, hot_score, data_status, create_time, update_time, " +
            "is_deleted FROM campus WHERE id =#{id}")
    List<Campus> findAll(Long id);

    /**
     * 查询某个高校下的校区简要信息。
     */
    @Select("SELECT id, university_id, name, address, map_image_url AS mapImageUrl, hot_score " +
            " FROM campus WHERE is_deleted=0 AND university_id=#{universityId}")
    List<CampusVO> selectCampusesByUniversityId(Long universityId);

    /**
     * 根据校区 ID 查询未删除校区。
     */
    @Select("SELECT id, university_id, name, address, map_image_url AS mapImageUrl, hot_score " +
            "FROM campus WHERE id = #{campusId} AND is_deleted = 0 LIMIT 1")
    CampusVO selectCampusById(@Param("campusId") Long campusId);

    /**
     * 更新校区平面图链接。
     */
    @Update("UPDATE campus SET map_image_url = #{mapImageUrl} WHERE id = #{campusId} AND is_deleted = 0")
    int updateCampusMapImageUrl(@Param("campusId") Long campusId, @Param("mapImageUrl") String mapImageUrl);
}
