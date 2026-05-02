package com.github.zhiduoming.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.zhiduoming.common.RedisKeyConstants;
import com.github.zhiduoming.dto.UniversityPageQuery;
import com.github.zhiduoming.vo.CampusVO;
import com.github.zhiduoming.vo.UniversityDetailVO;
import com.github.zhiduoming.vo.UniversityListVO;
import com.github.zhiduoming.vo.UniversityRatingVO;
import com.github.zhiduoming.common.PageResult;
import com.github.zhiduoming.mapper.CampusMapper;
import com.github.zhiduoming.mapper.UniversityMapper;
import com.github.zhiduoming.service.UniversityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import tools.jackson.databind.ObjectMapper;

import java.time.Duration;
import java.util.List;

@Slf4j
@Service
public class UniversityServiceImpl implements UniversityService {

    private final UniversityMapper universityMapper;
    private final CampusMapper campusMapper;
    private final StringRedisTemplate stringRedisTemplate;
    private final ObjectMapper objectMapper;

    public UniversityServiceImpl(UniversityMapper universityMapper, CampusMapper campusMapper, StringRedisTemplate stringRedisTemplate, ObjectMapper objectMapper) {
        this.universityMapper = universityMapper;
        this.campusMapper = campusMapper;
        this.stringRedisTemplate = stringRedisTemplate;
        this.objectMapper = objectMapper;
    }

    /**
     * 分页查询大学列表
     *
     * @param query 查询条件，包含页码、每页数量、关键词、省份等信息
     * @return 分页结果，包含总记录数、当前页码、每页数量和大学列表数据
     */
    @Override
    public PageResult<UniversityListVO> listUniversities(UniversityPageQuery query) {
        int page = (query == null) ? 1 : query.safePage();
        int size = (query == null) ? 10 : query.safeSize();
        String keyword = (query == null) ? null : query.getKeyword();
        String province = (query == null) ? null : query.getProvince();
        String city = (query == null) ? null : query.getCity();

        PageHelper.startPage(page, size);
        List<UniversityListVO> universityList = universityMapper.selectUniversityList(keyword, province, city);
        PageInfo<UniversityListVO> pageInfo = new PageInfo<>(universityList);

        return new PageResult<>(
                pageInfo.getTotal(),
                pageInfo.getPageNum(),
                pageInfo.getPageSize(),
                pageInfo.getList()
        );
    }

    /**
     * 查询高校详情，并补齐校区列表和评分信息。
     */
    @Override
    public UniversityDetailVO getUniversityDetail(Long universityId) {
        //先判断高校 ID 是否为空
        if (universityId == null) {
            throw new RuntimeException("高校 ID 不能为空");
        }

        //根据universityId拼接一个 Redis 的key
        String key = RedisKeyConstants.universityDetailKey(universityId);
        //先查 Redis 缓存
        String cacheJson = stringRedisTemplate.opsForValue().get(key);
        //如果查到了就直接返回
        if (cacheJson != null) {
            log.info("高校详情缓存命中, universityId={}, key={}", universityId, key);
            return objectMapper.readValue(cacheJson, UniversityDetailVO.class);
        }

        //如果没有查到就先从数据库查，然后转 JSON 再写入 Redis
        log.info("高校详情缓存未命中, universityId={}, key={}", universityId, key);

        UniversityDetailVO universityDetail = universityMapper.selectUniversityById(universityId);
        if (universityDetail == null) {
            return null;
        }
        List<CampusVO> campusList = campusMapper.selectCampusesByUniversityId(universityId);
        universityDetail.setCampusList(campusList);
        UniversityRatingVO rating = universityMapper.selectUniversityRating(universityId);
        universityDetail.setRating(rating);
        //写入 Redis
        String detailJson = objectMapper.writeValueAsString(universityDetail);
        stringRedisTemplate.opsForValue().set(
                key,
                detailJson,
                Duration.ofMinutes(30)
        );
        log.info("高校详情写入缓存, universityId={}, key={}, ttl=30min", universityId, key);
        return universityDetail;
    }


}
