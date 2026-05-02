package com.github.zhiduoming.controller;

import com.github.zhiduoming.common.PageResult;
import com.github.zhiduoming.common.Result;
import com.github.zhiduoming.dto.ReviewCreateDTO;
import com.github.zhiduoming.dto.ReviewPageQuery;
import com.github.zhiduoming.dto.ReviewReplyCreateDTO;
import com.github.zhiduoming.service.ReviewService;
import com.github.zhiduoming.vo.ReviewVO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1")
@Slf4j
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    /**
     * 当前登录用户在指定高校下发布评价。
     */
    @PostMapping("/universities/{universityId}/reviews")
    public Result createReview(@PathVariable Long universityId,
                               @RequestBody ReviewCreateDTO dto,
                               HttpServletRequest request) {
        log.info("新增评价, universityId={}", universityId);
        Long userId = (Long) request.getAttribute("userId");
        reviewService.createReview(userId, universityId, dto);
        return Result.success();
    }

    /**
     * 分页查询指定高校下的评价列表。
     */
    @GetMapping("/universities/{universityId}/reviews")
    public Result listReviews(@PathVariable Long universityId,
                              @ModelAttribute ReviewPageQuery query,
                              HttpServletRequest request) {
        log.info("查询评价列表, universityId={}, page={}, size={}",
                universityId, query.getPage(), query.getSize());
        Long currentUserId = (Long) request.getAttribute("userId");
        PageResult<ReviewVO> pageResult = reviewService.listReviews(universityId, query, currentUserId);
        return Result.success(pageResult);
    }

    /**
     * 当前登录用户删除自己发布的评价。
     */
    @DeleteMapping("/reviews/{reviewId}")
    public Result deleteReview(@PathVariable Long reviewId,
                               HttpServletRequest request) {
        log.info("删除评价, reviewId={}", reviewId);
        Long userId = (Long) request.getAttribute("userId");
        reviewService.deleteReview(userId, reviewId);
        return Result.success();
    }

    /**
     * 当前登录用户点赞指定评价。
     */
    @PostMapping("/reviews/{reviewId}/likes")
    public Result likeReview(@PathVariable Long reviewId,
                             HttpServletRequest request) {
        log.info("点赞评价, reviewId={}", reviewId);
        Long userId = (Long) request.getAttribute("userId");
        reviewService.likeReview(userId, reviewId);
        return Result.success();
    }

    /**
     * 当前登录用户取消点赞指定评价。
     */
    @DeleteMapping("/reviews/{reviewId}/likes")
    public Result unlikeReview(@PathVariable Long reviewId,
                               HttpServletRequest request) {
        log.info("取消点赞评价, reviewId={}", reviewId);
        Long userId = (Long) request.getAttribute("userId");
        reviewService.unlikeReview(userId, reviewId);
        return Result.success();
    }

    /**
     * 当前登录用户回复指定评价。
     */
    @PostMapping("/reviews/{reviewId}/replies")
    public Result createReply(@PathVariable Long reviewId,
                              @RequestBody ReviewReplyCreateDTO dto,
                              HttpServletRequest request) {
        log.info("新增评价回复, reviewId={}", reviewId);
        Long userId = (Long) request.getAttribute("userId");
        reviewService.createReply(userId, reviewId, dto);
        return Result.success();
    }

    /**
     * 当前登录用户删除自己发布的回复。
     */
    @DeleteMapping("/review-replies/{replyId}")
    public Result deleteReply(@PathVariable Long replyId,
                              HttpServletRequest request) {
        log.info("删除评价回复, replyId={}", replyId);
        Long userId = (Long) request.getAttribute("userId");
        reviewService.deleteReply(userId, replyId);
        return Result.success();
    }
}
