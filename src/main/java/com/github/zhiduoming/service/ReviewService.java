package com.github.zhiduoming.service;

import com.github.zhiduoming.common.PageResult;
import com.github.zhiduoming.dto.ReviewCreateDTO;
import com.github.zhiduoming.dto.ReviewPageQuery;
import com.github.zhiduoming.dto.ReviewReplyCreateDTO;
import com.github.zhiduoming.vo.ReviewVO;

public interface ReviewService {
    /**
     * 当前登录用户在指定高校下发布主评价。
     */
    void createReview(Long userId, Long universityId, ReviewCreateDTO dto);

    /**
     * 分页查询指定高校下的主评价和回复。
     */
    PageResult<ReviewVO> listReviews(Long universityId, ReviewPageQuery query, Long currentUserId);

    /**
     * 当前登录用户逻辑删除自己的主评价。
     */
    void deleteReview(Long userId, Long reviewId);

    /**
     * 当前登录用户点赞主评价。
     */
    void likeReview(Long userId, Long reviewId);

    /**
     * 当前登录用户取消点赞主评价。
     */
    void unlikeReview(Long userId, Long reviewId);

    /**
     * 当前登录用户回复主评价。
     */
    void createReply(Long userId, Long reviewId, ReviewReplyCreateDTO dto);

    /**
     * 当前登录用户逻辑删除自己的回复。
     */
    void deleteReply(Long userId, Long replyId);

}
