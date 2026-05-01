package com.github.zhiduoming.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.zhiduoming.common.PageResult;
import com.github.zhiduoming.dto.ReviewCreateDTO;
import com.github.zhiduoming.dto.ReviewPageQuery;
import com.github.zhiduoming.dto.ReviewReplyCreateDTO;
import com.github.zhiduoming.mapper.ReviewMapper;
import com.github.zhiduoming.mapper.UniversityMapper;
import com.github.zhiduoming.mapper.UserMapper;
import com.github.zhiduoming.pojo.UniversityReview;
import com.github.zhiduoming.pojo.User;
import com.github.zhiduoming.service.ReviewService;
import com.github.zhiduoming.vo.ReviewReplyVO;
import com.github.zhiduoming.vo.ReviewVO;
import com.github.zhiduoming.vo.UniversityDetailVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class ReviewServiceImpl implements ReviewService {
    private final ReviewMapper reviewMapper;
    private final UserMapper userMapper;
    private final UniversityMapper universityMapper;

    public ReviewServiceImpl(ReviewMapper reviewMapper, UserMapper userMapper, UniversityMapper universityMapper) {
        this.reviewMapper = reviewMapper;
        this.userMapper = userMapper;
        this.universityMapper = universityMapper;
    }


    @Override
    @Transactional
    public void createReview(Long userId, Long universityId, ReviewCreateDTO dto) {
        //1.检查用户的 id 是否为 null
        if (userId == null) {
            throw new RuntimeException("用户未登录");
        }
        //2.根据用户的 id 查询用户是否存在
        User user = userMapper.selectById(userId);
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("用户不存在或已被禁用");
        }
        //3.查询用户资料是否完整
        if (user.getProfileCompleted() == null || user.getProfileCompleted() != 1) {
            throw new RuntimeException("用户资料不完整，请完善用户资料");
        }
        //4.检查 universityId 是否为空，并确认高校存在
        if (universityId == null) {
            throw new RuntimeException("高校ID不能为空");
        }
        UniversityDetailVO university = universityMapper.selectUniversityById(universityId);
        if (university == null) {
            throw new RuntimeException("该高校不存在");
        }
        //5.判断 dto 是否为空
        if (dto == null) {
            throw new RuntimeException("请求体不能为空");
        }
        //6.如果 dto 中 campusId 不为空，检查该校区是否属于当前 universityId
        if (dto.getCampusId() != null) {
            int campusCount = reviewMapper.countCampusByUniversityId(dto.getCampusId(), universityId);
            if (campusCount != 1) {
                throw new RuntimeException("该校区不属于该高校");
            }
        }

        //7.判断 content 是否为空，trim 后要限制长度在 1000以内
        if (dto.getContent() == null) {
            throw new RuntimeException("评价内容不能为空");
        }
        String content = dto.getContent().trim();
        if (content.isEmpty()) {
            throw new RuntimeException("评价内容不能为空");
        }
        if (content.length() > 1000) {
            throw new RuntimeException("评价内容不能超过1000个字符");
        }
        //8.判断评分的字段是全空、全填还是只填了一部分
        //全空：则是不带评分的评价
        //全填：带评分的评价
        //只填了部分：报错
        Integer[] scores = {
                dto.getDormitoryScore(),
                dto.getCanteenScore(),
                dto.getLocationScore(),
                dto.getStudyScore(),
                dto.getCultureScore(),
                dto.getClubScore(),
                dto.getEmploymentScore(),
                dto.getCampusScore()
        };
        int scoreCount = 0;
        for (Integer score : scores) {
            if (score != null) {
                scoreCount++;
            }
        }
        if (scoreCount != 8 && scoreCount != 0) {
            throw new RuntimeException("评分必须全部填写或者全部不填写");
        }
        //9.如果是全填，判断评分是否限制在 1-5分
        //10.如果是全填，则计算 overallScore
        BigDecimal overallScore = null;
        if (scoreCount == 8) {
            int total = 0;
            for (Integer score : scores) {
                if (score < 1 || score > 5) {
                    throw new RuntimeException("评分必须在 1-5分之间");
                }
                total += score;
            }

            overallScore = BigDecimal.valueOf(total)
                    .divide(BigDecimal.valueOf(8), 2, RoundingMode.HALF_UP);
        }

        Integer isAnonymous = dto.getIsAnonymous();
        if (isAnonymous == null) {
            isAnonymous = 0;
        }
        if (isAnonymous != 0 && isAnonymous != 1) {
            throw new RuntimeException("匿名标记不合法");
        }

        //11.组装 UniversityReview
        UniversityReview review = new UniversityReview();
        review.setUserId(userId);
        review.setUniversityId(universityId);
        review.setCampusId(dto.getCampusId());
        review.setContent(content);
        review.setDormitoryScore(dto.getDormitoryScore());
        review.setCanteenScore(dto.getCanteenScore());
        review.setLocationScore(dto.getLocationScore());
        review.setStudyScore(dto.getStudyScore());
        review.setCultureScore(dto.getCultureScore());
        review.setClubScore(dto.getClubScore());
        review.setEmploymentScore(dto.getEmploymentScore());
        review.setCampusScore(dto.getCampusScore());
        review.setOverallScore(overallScore);
        review.setIsAnonymous(isAnonymous);
        //12.调用 reviewMapper.insertReview(review)
        int rows = reviewMapper.insertReview(review);
        //13.根据返回值判断 rows 是否为 1
        if (rows != 1) {
            throw new RuntimeException("评论添加失败");
        }
    }

    @Override
    public PageResult<ReviewVO> listReviews(Long universityId, ReviewPageQuery query, Long currentUserId) {
        // 1. 校验 universityId
        if (universityId == null) {
            throw new RuntimeException("高校 ID 不能为空");
        }
        // 2. 查询高校是否存在
        UniversityDetailVO universityDetailVO = universityMapper.selectUniversityById(universityId);
        if (universityDetailVO == null) {
            throw new RuntimeException("该高校不存在");
        }
        // 3. 处理 page / size
        int page = (query == null) ? 1 : query.safePage();
        int size = (query == null) ? 10 : query.safeSize();
        // 4. PageHelper.startPage(page, size)
        PageHelper.startPage(page, size);

        // 5. 查询主评价列表
        List<ReviewVO> reviews = reviewMapper.selectReviewsByUniversityId(universityId, currentUserId);

        // 6. PageInfo 包装
        PageInfo<ReviewVO> pageInfo = new PageInfo<>(reviews);

        // 7. 取 reviewId 列表
        List<Long> reviewsIds = new ArrayList<>();
        for (ReviewVO review : pageInfo.getList()) {
            reviewsIds.add(review.getId());
        }
        // 8. 批量查回复
        // 9. 按 reviewId 分组
        Map<Long, List<ReviewReplyVO>> replyMap = new HashMap<>();

        if (!reviewsIds.isEmpty()) {
            List<ReviewReplyVO> replies = reviewMapper.selectRepliesByReviewIds(reviewsIds);
            for (ReviewReplyVO reply : replies) {
                Long reviewId = reply.getReviewId();
                List<ReviewReplyVO> list = replyMap.computeIfAbsent(reviewId, k -> new ArrayList<>());
                list.add(reply);
            }
        }

        // 10. 塞 replies
        for (ReviewVO review : pageInfo.getList()) {
            List<ReviewReplyVO> replies = replyMap.get(review.getId());
            if (replies == null) {
                replies = new ArrayList<>();
            }
            review.setReplies(replies);
        }

        // 11. 返回 PageResult
        return new PageResult<>(
                pageInfo.getTotal(),
                pageInfo.getPageNum(),
                pageInfo.getPageSize(),
                pageInfo.getList()
        );

    }

    @Override
    @Transactional
    public void deleteReview(Long userId, Long reviewId) {
        // 1. 校验用户是否登录
        if (userId == null) {
            throw new RuntimeException("用户未登录");
        }

        // 2. 校验用户是否存在且状态正常
        User user = userMapper.selectById(userId);
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("用户不存在或已被禁用");
        }

        // 3. 校验评价 ID
        if (reviewId == null) {
            throw new RuntimeException("评价 ID 不能为空");
        }

        // 4. 查询评价是否存在
        UniversityReview review = reviewMapper.selectReviewById(reviewId);
        if (review == null || review.getIsDeleted() == null || review.getIsDeleted() == 1) {
            throw new RuntimeException("评价不存在或已删除");
        }

        // 5. 执行逻辑删除。SQL 中带 user_id 条件，防止删除别人的评价。
        int rows = reviewMapper.logicDeleteReviewByIdAndUserId(reviewId, userId);

        // 6. rows 为 0 通常表示当前用户不是评价作者，或评价已被并发删除。
        if (rows != 1) {
            throw new RuntimeException("无权限删除该评价");
        }
    }

    @Override
    public void likeReview(Long userId, Long reviewId) {
        //1.校验用户ID
        if(userId==null){
            throw new RuntimeException("用户 ID 不能为空");
        }
        //2.校验用户状态
        User user =userMapper.selectById(userId);
        if(user==null||user.getStatus()==null||user.getStatus()!=1){
            throw new RuntimeException("用户不存在或被禁用");
        }
        //3.校验评价是否存在
        UniversityReview review = reviewMapper.selectReviewById(reviewId);
        if(review==null){
            throw new RuntimeException("评价不存在");
        }
        //4.校验评价是否被删除
        if(review.getIsDeleted()==null||review.getIsDeleted()==1){
            throw new RuntimeException("评价已被删除");
        }
        //5.更新点赞的状态
        int rows = reviewMapper.insertLike(reviewId, userId);

        if(rows==0){
            throw new RuntimeException("不能重复点赞");
        }

    }

    @Override
    public void unlikeReview(Long userId, Long reviewId) {

    }

    @Override
    public void createReply(Long userId, Long reviewId, ReviewReplyCreateDTO dto) {

    }

    @Override
    public void deleteReply(Long userId, Long replyId) {

    }
}
