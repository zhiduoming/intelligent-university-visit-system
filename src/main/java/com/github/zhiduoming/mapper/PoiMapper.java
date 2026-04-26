package com.github.zhiduoming.mapper;

import com.github.zhiduoming.vo.PoiVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;


@Mapper
public interface PoiMapper {

    /**
     * 按热度倒序查询某个校区下的 POI。
     */
    @Select("SELECT id, campus_id, name, category, suggested_duration, " +
            "intro, image_url, hot_score FROM poi WHERE  campus_id = #{campusId} AND is_deleted=0 " +
            "ORDER BY hot_score DESC")
    List<PoiVO> selectPoisByCampusId(Long campusId);
}
