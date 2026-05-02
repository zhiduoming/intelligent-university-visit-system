USE uni_tour;

ALTER TABLE university_review
    MODIFY dormitory_score TINYINT COMMENT '宿舍条件评分:1-5,纯文字评价为空',
    MODIFY canteen_score TINYINT COMMENT '食堂质量评分:1-5,纯文字评价为空',
    MODIFY location_score TINYINT COMMENT '地理位置评分:1-5,纯文字评价为空',
    MODIFY study_score TINYINT COMMENT '学习氛围评分:1-5,纯文字评价为空',
    MODIFY culture_score TINYINT COMMENT '文化氛围评分:1-5,纯文字评价为空',
    MODIFY club_score TINYINT COMMENT '社团活动评分:1-5,纯文字评价为空',
    MODIFY employment_score TINYINT COMMENT '就业前景评分:1-5,纯文字评价为空',
    MODIFY campus_score TINYINT COMMENT '校园环境评分:1-5,纯文字评价为空',
    MODIFY overall_score DECIMAL(3, 2) COMMENT '综合评分,纯文字评价为空';

ALTER TABLE university_review
    ADD CONSTRAINT ck_review_score_all_or_none CHECK (
        (
            dormitory_score IS NULL
                AND canteen_score IS NULL
                AND location_score IS NULL
                AND study_score IS NULL
                AND culture_score IS NULL
                AND club_score IS NULL
                AND employment_score IS NULL
                AND campus_score IS NULL
                AND overall_score IS NULL
            )
            OR
        (
            dormitory_score IS NOT NULL
                AND canteen_score IS NOT NULL
                AND location_score IS NOT NULL
                AND study_score IS NOT NULL
                AND culture_score IS NOT NULL
                AND club_score IS NOT NULL
                AND employment_score IS NOT NULL
                AND campus_score IS NOT NULL
                AND overall_score IS NOT NULL
            )
        );

CREATE TABLE IF NOT EXISTS review_like
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '点赞ID',
    review_id   BIGINT   NOT NULL COMMENT '评价ID',
    user_id     BIGINT   NOT NULL COMMENT '点赞用户ID',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    UNIQUE KEY uk_review_like (review_id, user_id),
    KEY idx_review_like_user_id (user_id),
    CONSTRAINT fk_review_like_review FOREIGN KEY (review_id) REFERENCES university_review (id),
    CONSTRAINT fk_review_like_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
  COMMENT ='评价点赞表';

CREATE TABLE IF NOT EXISTS review_reply
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '回复ID',
    review_id   BIGINT       NOT NULL COMMENT '评价ID',
    user_id     BIGINT       NOT NULL COMMENT '回复用户ID',
    content     VARCHAR(500) NOT NULL COMMENT '回复内容',
    create_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted  TINYINT      NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    KEY idx_review_reply_review_id (review_id, is_deleted),
    KEY idx_review_reply_user_id (user_id, is_deleted),
    CONSTRAINT fk_review_reply_review FOREIGN KEY (review_id) REFERENCES university_review (id),
    CONSTRAINT fk_review_reply_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
  COMMENT ='评价回复表';
