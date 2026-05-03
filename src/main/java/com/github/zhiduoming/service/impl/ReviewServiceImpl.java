package com.github.zhiduoming.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.zhiduoming.common.PageResult;
import com.github.zhiduoming.common.RedisKeyConstants;
import com.github.zhiduoming.dto.ReviewCreateDTO;
import com.github.zhiduoming.dto.ReviewPageQuery;
import com.github.zhiduoming.dto.ReviewReplyCreateDTO;
import com.github.zhiduoming.mapper.ReviewMapper;
import com.github.zhiduoming.mapper.UniversityMapper;
import com.github.zhiduoming.mapper.UserMapper;
import com.github.zhiduoming.pojo.ReviewReply;
import com.github.zhiduoming.pojo.UniversityReview;
import com.github.zhiduoming.pojo.User;
import com.github.zhiduoming.service.ReviewService;
import com.github.zhiduoming.vo.ReviewReplyVO;
import com.github.zhiduoming.vo.ReviewVO;
import com.github.zhiduoming.vo.UniversityDetailVO;
import org.springframework.data.redis.core.StringRedisTemplate;
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
    private final StringRedisTemplate stringRedisTemplate;


    public ReviewServiceImpl(ReviewMapper reviewMapper, UserMapper userMapper, UniversityMapper universityMapper, StringRedisTemplate stringRedisTemplate) {
        this.reviewMapper = reviewMapper;
        this.userMapper = userMapper;
        this.universityMapper = universityMapper;
        this.stringRedisTemplate = stringRedisTemplate;
    }

    /**
     * 当前登录用户在指定高校下发布主评价，支持整校评价和可选校区评价。
     */
    @Override
    @Transactional
    public void createReview(Long userId, Long universityId, ReviewCreateDTO dto) {
        User user = checkActiveUser(userId);
        checkCompletedProfile(user);
        checkUniversityExists(universityId);
        if (dto == null) {
            throw new RuntimeException("请求体不能为空");
        }

        checkCampusBelongsToUniversity(dto.getCampusId(), universityId);
        String content = validateText(dto.getContent(), "评价内容", 1000);
        BigDecimal overallScore = calculateOverallScore(dto);
        Integer isAnonymous = normalizeAnonymous(dto.getIsAnonymous());
        UniversityReview review = buildReview(userId, universityId, dto, content, overallScore, isAnonymous);

        int rows = reviewMapper.insertReview(review);
        if (rows != 1) {
            throw new RuntimeException("评论添加失败");
        }
        stringRedisTemplate.delete(RedisKeyConstants.universityDetailKey(universityId));

    }

    /**
     * 分页查询指定高校下的评价列表，并批量补齐当前页评价的回复列表。
     */
    @Override
    public PageResult<ReviewVO> listReviews(Long universityId, ReviewPageQuery query, Long currentUserId) {
        checkUniversityExists(universityId);

        int page = (query == null) ? 1 : query.safePage();
        int size = (query == null) ? 10 : query.safeSize();

        PageHelper.startPage(page, size);
        List<ReviewVO> reviews = reviewMapper.selectReviewsByUniversityId(universityId, currentUserId);
        PageInfo<ReviewVO> pageInfo = new PageInfo<>(reviews);
        fillReplies(pageInfo.getList());

        return new PageResult<>(
                pageInfo.getTotal(),
                pageInfo.getPageNum(),
                pageInfo.getPageSize(),
                pageInfo.getList()
        );

    }

    /**
     * 普通用户只能删除自己的主评价；管理员可以删除任意主评价。
     */
    @Override
    @Transactional
    public void deleteReview(Long userId, Long reviewId) {
        User user = checkActiveUser(userId);
        UniversityReview review = checkReviewExists(reviewId);
        int rows = isAdmin(user)
                ? reviewMapper.logicDeleteReviewById(reviewId)
                : reviewMapper.logicDeleteReviewByIdAndUserId(reviewId, userId);
        if (rows != 1) {
            throw new RuntimeException("无权限删除该评价");
        }
        stringRedisTemplate.delete(RedisKeyConstants.universityDetailKey(review.getUniversityId()));

    }

    /**
     * 当前登录用户点赞主评价，重复点赞保持幂等。
     */
    @Override
    @Transactional
    public void likeReview(Long userId, Long reviewId) {
        checkActiveUser(userId);
        checkReviewExists(reviewId);
        reviewMapper.insertLike(reviewId, userId);
    }

    /**
     * 当前登录用户取消点赞主评价，未点赞时取消也保持幂等。
     */
    @Override
    @Transactional
    public void unlikeReview(Long userId, Long reviewId) {
        checkActiveUser(userId);
        checkReviewExists(reviewId);
        reviewMapper.deleteLike(reviewId, userId);
    }

    /**
     * 当前登录用户回复一条未删除的主评价。
     */
    @Override
    @Transactional
    public void createReply(Long userId, Long reviewId, ReviewReplyCreateDTO dto) {
        checkActiveUser(userId);
        checkReviewExists(reviewId);
        if (dto == null) {
            throw new RuntimeException("请求体不能为空");
        }
        String content = validateText(dto.getContent(), "回复内容", 500);

        ReviewReply reply = new ReviewReply();
        reply.setReviewId(reviewId);
        reply.setContent(content);
        reply.setUserId(userId);

        int rows = reviewMapper.insertReply(reply);
        if (rows != 1) {
            throw new RuntimeException("回复发布失败");
        }
    }

    /**
     * 普通用户只能删除自己的回复；管理员可以删除任意回复。
     */
    @Override
    @Transactional
    public void deleteReply(Long userId, Long replyId) {
        User user = checkActiveUser(userId);
        checkReplyExists(replyId);

        int rows = isAdmin(user)
                ? reviewMapper.logicDeleteReplyById(replyId)
                : reviewMapper.logicDeleteReplyByIdAndUserId(replyId, userId);
        if (rows != 1) {
            throw new RuntimeException("无权限删除该回复");
        }
    }

    /**
     * 校验用户已登录、存在且状态正常，并返回用户实体。
     */
    private User checkActiveUser(Long userId) {
        if (userId == null) {
            throw new RuntimeException("用户未登录");
        }

        User user = userMapper.selectById(userId);
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            throw new RuntimeException("用户不存在或已被禁用");
        }
        return user;
    }

    /**
     * 当前项目约定 role=9 为管理员。
     */
    private boolean isAdmin(User user) {
        return user.getRole() != null && user.getRole() == 9;
    }

    /**
     * 校验用户资料已完善；当前只用于发布主评价。
     */
    private void checkCompletedProfile(User user) {
        if (user.getProfileCompleted() == null || user.getProfileCompleted() != 1) {
            throw new RuntimeException("用户资料不完整，请完善用户资料");
        }
    }

    /**
     * 校验高校 ID 有效且高校存在。
     */
    private void checkUniversityExists(Long universityId) {
        if (universityId == null) {
            throw new RuntimeException("高校 ID 不能为空");
        }
        UniversityDetailVO university = universityMapper.selectUniversityById(universityId);
        if (university == null) {
            throw new RuntimeException("该高校不存在");
        }
    }

    /**
     * 校验可选校区是否属于当前高校；未传校区时跳过。
     */
    private void checkCampusBelongsToUniversity(Long campusId, Long universityId) {
        if (campusId == null) {
            return;
        }
        int campusCount = reviewMapper.countCampusByUniversityId(campusId, universityId);
        if (campusCount != 1) {
            throw new RuntimeException("该校区不属于该高校");
        }
    }

    /**
     * 校验主评价 ID 有效、评价存在且未被逻辑删除。
     */
    private UniversityReview checkReviewExists(Long reviewId) {
        if (reviewId == null) {
            throw new RuntimeException("评价 ID 不能为空");
        }
        UniversityReview review = reviewMapper.selectReviewById(reviewId);
        if (review == null || review.getIsDeleted() == null || review.getIsDeleted() == 1) {
            throw new RuntimeException("评价不存在或已删除");
        }
        return review;
    }

    /**
     * 校验回复 ID 有效、回复存在且未被逻辑删除。
     */
    private ReviewReply checkReplyExists(Long replyId) {
        if (replyId == null) {
            throw new RuntimeException("回复 ID 不能为空");
        }
        ReviewReply reply = reviewMapper.selectReplyById(replyId);
        if (reply == null || reply.getIsDeleted() == null || reply.getIsDeleted() == 1) {
            throw new RuntimeException("回复不存在或已被删除");
        }
        return reply;
    }

    /**
     * 校验文本内容不为空并做 trim，同时限制最大字符数。
     */
    private String validateText(String rawContent, String fieldName, int maxLength) {
        if (rawContent == null) {
            throw new RuntimeException(fieldName + "不能为空");
        }

        String content = rawContent.trim();
        if (content.isEmpty()) {
            throw new RuntimeException(fieldName + "不能为空");
        }
        if (content.length() > maxLength) {
            throw new RuntimeException(fieldName + "不能超过 " + maxLength + " 个字符");
        }
        return content;
    }

    /**
     * 校验评分要么全空、要么全填，并在全填时计算 8 个维度的平均分。
     */
    private BigDecimal calculateOverallScore(ReviewCreateDTO dto) {
        Integer[] scores = getReviewScores(dto);
        int scoreCount = 0;
        for (Integer score : scores) {
            if (score != null) {
                scoreCount++;
            }
        }

        if (scoreCount != scores.length && scoreCount != 0) {
            throw new RuntimeException("评分必须全部填写或者全部不填写");
        }
        if (scoreCount == 0) {
            return null;
        }

        int total = 0;
        for (Integer score : scores) {
            if (score < 1 || score > 5) {
                throw new RuntimeException("评分必须在 1-5分之间");
            }
            total += score;
        }
        return BigDecimal.valueOf(total)
                .divide(BigDecimal.valueOf(scores.length), 2, RoundingMode.HALF_UP);
    }

    /**
     * 从评价创建 DTO 中提取 8 个评分维度。
     */
    private Integer[] getReviewScores(ReviewCreateDTO dto) {
        return new Integer[]{
                dto.getDormitoryScore(),
                dto.getCanteenScore(),
                dto.getLocationScore(),
                dto.getStudyScore(),
                dto.getCultureScore(),
                dto.getClubScore(),
                dto.getEmploymentScore(),
                dto.getCampusScore()
        };
    }

    /**
     * 规范化匿名标记；未传时默认非匿名。
     */
    private Integer normalizeAnonymous(Integer isAnonymous) {
        if (isAnonymous == null) {
            return 0;
        }
        if (isAnonymous != 0 && isAnonymous != 1) {
            throw new RuntimeException("匿名标记不合法");
        }
        return isAnonymous;
    }

    /**
     * 根据校验后的入参组装主评价实体。
     */
    private UniversityReview buildReview(Long userId, Long universityId, ReviewCreateDTO dto,
                                         String content, BigDecimal overallScore, Integer isAnonymous) {
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
        return review;
    }

    /**
     * 为当前页评价批量查询回复，并按 reviewId 填充到各自的 replies 字段。
     */
    private void fillReplies(List<ReviewVO> reviews) {
        List<Long> reviewIds = new ArrayList<>();
        for (ReviewVO review : reviews) {
            reviewIds.add(review.getId());
        }

        Map<Long, List<ReviewReplyVO>> replyMap = new HashMap<>();
        if (!reviewIds.isEmpty()) {
            List<ReviewReplyVO> replies = reviewMapper.selectRepliesByReviewIds(reviewIds);
            for (ReviewReplyVO reply : replies) {
                replyMap.computeIfAbsent(reply.getReviewId(), key -> new ArrayList<>()).add(reply);
            }
        }

        for (ReviewVO review : reviews) {
            List<ReviewReplyVO> replies = replyMap.get(review.getId());
            if (replies == null) {
                replies = new ArrayList<>();
            }
            review.setReplies(replies);
        }
    }
}
