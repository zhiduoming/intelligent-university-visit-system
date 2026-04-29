package com.github.zhiduoming.mapper;

import com.github.zhiduoming.pojo.ReviewReply;
import com.github.zhiduoming.pojo.UniversityReview;
import com.github.zhiduoming.vo.ReviewReplyVO;
import com.github.zhiduoming.vo.ReviewVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ReviewMapper {

    /**
     * 新增一条主评价。
     */
    int insertReview(UniversityReview review);

    /**
     * 按高校 ID 查询主评价列表。
     * 分页不要在 SQL 里写 limit，交给 PageHelper。
     */
    List<ReviewVO> selectReviewsByUniversityId(@Param("universityId") Long universityId,
                                               @Param("currentUserId") Long currentUserId);

    /**
     * 根据当前页评价 ID，批量查询这些评价下面的一级回复。
     */
    List<ReviewReplyVO> selectRepliesByReviewIds(@Param("reviewIds") List<Long> reviewIds);

    /**
     * 根据评价 ID 查询主评价。
     * 删除、点赞、回复前都可以先用它判断评价是否存在。
     */
    UniversityReview selectReviewById(@Param("reviewId") Long reviewId);

    /**
     * 当前用户逻辑删除自己的主评价。
     */
    int logicDeleteReviewByIdAndUserId(@Param("reviewId") Long reviewId,
                                       @Param("userId") Long userId);

    /**
     * 新增点赞记录。
     */
    int insertLike(@Param("reviewId") Long reviewId,
                   @Param("userId") Long userId);

    /**
     * 取消点赞。
     */
    int deleteLike(@Param("reviewId") Long reviewId,
                   @Param("userId") Long userId);

    /**
     * 新增一条一级回复。
     */
    int insertReply(ReviewReply reply);

    /**
     * 根据回复 ID 查询回复。
     * 删除回复前用于判断回复是否存在、是否属于当前用户。
     */
    ReviewReply selectReplyById(@Param("replyId") Long replyId);

    /**
     * 当前用户逻辑删除自己的回复。
     */
    int logicDeleteReplyByIdAndUserId(@Param("replyId") Long replyId,
                                      @Param("userId") Long userId);

    /**
     * 检查某个校区是否属于某个高校。
     * 发布评价时如果传了 campusId，需要校验它和 universityId 的关系。
     */
    int countCampusByUniversityId(@Param("campusId") Long campusId,
                                  @Param("universityId") Long universityId);
}
