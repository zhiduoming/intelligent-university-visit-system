package com.github.zhiduoming.mapper;

import com.github.zhiduoming.vo.PoiVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;


@Mapper
public interface PoiMapper {

    /**
     * 按热度倒序查询某个校区下的 POI。
     */
    @Select("SELECT id, campus_id, name, category, suggested_duration, " +
            "intro, image_url AS imageUrl, hot_score FROM poi WHERE  campus_id = #{campusId} AND is_deleted=0 " +
            "ORDER BY hot_score DESC")
    List<PoiVO> selectPoisByCampusId(Long campusId);

    /**
     * 根据 POI ID 查询未删除的 POI。
     */
    @Select("SELECT id, campus_id, name, category, suggested_duration, intro, image_url AS imageUrl, hot_score " +
            "FROM poi WHERE id = #{poiId} AND is_deleted = 0 LIMIT 1")
    PoiVO selectPoiById(@Param("poiId") Long poiId);

    /**
     * 更新 POI 图片链接。
     */
    @Update("UPDATE poi SET image_url = #{imageUrl} WHERE id = #{poiId} AND is_deleted = 0")
    int updatePoiImageUrl(@Param("poiId") Long poiId, @Param("imageUrl") String imageUrl);
}
