CREATE DATABASE IF NOT EXISTS uni_tour
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE uni_tour;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS review_reply;
DROP TABLE IF EXISTS review_like;
DROP TABLE IF EXISTS university_review;
DROP TABLE IF EXISTS poi;
DROP TABLE IF EXISTS campus;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS university;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE university
(
    id                    BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '高校ID',
    name                  VARCHAR(100) NOT NULL COMMENT '高校名称',
    short_name            VARCHAR(50) COMMENT '高校简称',
    description           VARCHAR(1000) COMMENT '高校简介',
    logo_url              VARCHAR(255) COMMENT '校徽链接',
    official_website      VARCHAR(255) COMMENT '官网链接',
    is_985                TINYINT      NOT NULL DEFAULT 0 COMMENT '是否为985',
    is_211                TINYINT      NOT NULL DEFAULT 0 COMMENT '是否为211',
    is_double_first_class TINYINT      NOT NULL DEFAULT 0 COMMENT '是否为双一流',
    school_type           VARCHAR(30) COMMENT '学校类型:综合/理工/师范等',
    education_level       VARCHAR(30) COMMENT '办学层次:本科/高职等',
    tags                  VARCHAR(255) COMMENT '学校标签,逗号分隔,如两电一邮,C9',
    province              VARCHAR(50) COMMENT '所在省',
    city                  VARCHAR(50) COMMENT '所在市',
    create_time           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted            TINYINT      NOT NULL DEFAULT 0 COMMENT '逻辑删除标记',
    UNIQUE KEY uk_university_name (name),
    KEY idx_university_region (province, city),
    KEY idx_university_flags (is_985, is_211, is_double_first_class),
    KEY idx_university_deleted (is_deleted)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
  COMMENT ='高校信息表';

CREATE TABLE campus
(
    id            BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '校区ID',
    university_id BIGINT       NOT NULL COMMENT '所属高校ID',
    name          VARCHAR(100) NOT NULL COMMENT '校区名称',
    address       VARCHAR(255) COMMENT '校区地址',
    province      VARCHAR(50) COMMENT '省份',
    city          VARCHAR(50) COMMENT '城市',
    lat           DECIMAL(10, 6) COMMENT '纬度',
    lng           DECIMAL(10, 6) COMMENT '经度',
    description   VARCHAR(1000) COMMENT '校区描述',
    main_gate     VARCHAR(100) COMMENT '主校门名称',
    hot_score     INT          NOT NULL DEFAULT 0 COMMENT '热度分',
    data_status   TINYINT      NOT NULL DEFAULT 0 COMMENT '数据状态:0占位/1完善',
    create_time   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted    TINYINT      NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    KEY idx_campus_university_id (university_id),
    KEY idx_campus_deleted (is_deleted),
    CONSTRAINT fk_campus_university FOREIGN KEY (university_id) REFERENCES university (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
  COMMENT ='校区表';

CREATE TABLE users
(
    id             BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username       VARCHAR(50)  NOT NULL COMMENT '用户名',
    phone          VARCHAR(20) COMMENT '绑定手机号，用于手机号登录和忘记密码辅助验证',
    password       VARCHAR(100) NOT NULL COMMENT '密码哈希',
    nickname       VARCHAR(50) COMMENT '昵称',
    avatar_url     VARCHAR(255) COMMENT '头像链接',
    role           TINYINT      NOT NULL DEFAULT 0 COMMENT '角色:0普通用户/9管理员',
    identity_type  TINYINT      NOT NULL DEFAULT 0 COMMENT '身份:0未知/1高中生/2大学生/3校友/4家长',
    high_school    VARCHAR(100) COMMENT '所在或毕业高中',
    target_uni_id  BIGINT COMMENT '目标高校ID',
    current_uni_id BIGINT COMMENT '当前就读高校ID',
    profile_completed TINYINT  NOT NULL DEFAULT 0 COMMENT '资料是否完善:0否/1是',
    status         TINYINT      NOT NULL DEFAULT 1 COMMENT '账号状态:1正常/0禁用',
    create_time    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted     TINYINT      NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    UNIQUE KEY uk_users_username (username),
    UNIQUE KEY uk_users_phone (phone),
    KEY idx_users_target_uni_id (target_uni_id),
    KEY idx_users_current_uni_id (current_uni_id),
    KEY idx_users_deleted (is_deleted),
    CONSTRAINT fk_users_target_university FOREIGN KEY (target_uni_id) REFERENCES university (id),
    CONSTRAINT fk_users_current_university FOREIGN KEY (current_uni_id) REFERENCES university (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
  COMMENT ='用户信息表';

CREATE TABLE poi
(
    id                 BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'POI主键ID',
    campus_id          BIGINT       NOT NULL COMMENT '所属校区ID',
    name               VARCHAR(100) NOT NULL COMMENT '点位名称',
    category           TINYINT      NOT NULL COMMENT '分类:1文化/2学术/3生活/4风景',
    suggested_duration INT          NOT NULL DEFAULT 30 COMMENT '建议停留时长(分钟)',
    intro              VARCHAR(1000) COMMENT '点位简介',
    image_url          VARCHAR(255) COMMENT '图片链接',
    hot_score          INT          NOT NULL DEFAULT 0 COMMENT '热度分',
    data_status        TINYINT      NOT NULL DEFAULT 0 COMMENT '数据状态:0占位/1完善',
    create_time        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted         TINYINT      NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    KEY idx_poi_campus_id (campus_id),
    KEY idx_poi_category (category),
    KEY idx_poi_deleted (is_deleted),
    CONSTRAINT fk_poi_campus FOREIGN KEY (campus_id) REFERENCES campus (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
  COMMENT ='校园点位表';

CREATE TABLE university_review
(
    id               BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '评价ID',
    user_id          BIGINT        NOT NULL COMMENT '发布用户ID',
    university_id    BIGINT        NOT NULL COMMENT '高校ID',
    campus_id        BIGINT COMMENT '校区ID,评价具体校区时填写',
    content          VARCHAR(1000) NOT NULL COMMENT '评价内容',
    dormitory_score  TINYINT COMMENT '宿舍条件评分:1-5,纯文字评价为空',
    canteen_score    TINYINT COMMENT '食堂质量评分:1-5,纯文字评价为空',
    location_score   TINYINT COMMENT '地理位置评分:1-5,纯文字评价为空',
    study_score      TINYINT COMMENT '学习氛围评分:1-5,纯文字评价为空',
    culture_score    TINYINT COMMENT '文化氛围评分:1-5,纯文字评价为空',
    club_score       TINYINT COMMENT '社团活动评分:1-5,纯文字评价为空',
    employment_score TINYINT COMMENT '就业前景评分:1-5,纯文字评价为空',
    campus_score     TINYINT COMMENT '校园环境评分:1-5,纯文字评价为空',
    overall_score    DECIMAL(3, 2) COMMENT '综合评分,纯文字评价为空',
    is_anonymous     TINYINT       NOT NULL DEFAULT 0 COMMENT '是否匿名:0否/1是',
    create_time      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted       TINYINT       NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    KEY idx_review_university_id (university_id, is_deleted),
    KEY idx_review_user_id (user_id, is_deleted),
    KEY idx_review_campus_id (campus_id),
    KEY idx_review_create_time (create_time),
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_review_university FOREIGN KEY (university_id) REFERENCES university (id),
    CONSTRAINT fk_review_campus FOREIGN KEY (campus_id) REFERENCES campus (id),
    CONSTRAINT ck_review_dormitory_score CHECK (dormitory_score BETWEEN 1 AND 5),
    CONSTRAINT ck_review_canteen_score CHECK (canteen_score BETWEEN 1 AND 5),
    CONSTRAINT ck_review_location_score CHECK (location_score BETWEEN 1 AND 5),
    CONSTRAINT ck_review_study_score CHECK (study_score BETWEEN 1 AND 5),
    CONSTRAINT ck_review_culture_score CHECK (culture_score BETWEEN 1 AND 5),
    CONSTRAINT ck_review_club_score CHECK (club_score BETWEEN 1 AND 5),
    CONSTRAINT ck_review_employment_score CHECK (employment_score BETWEEN 1 AND 5),
    CONSTRAINT ck_review_campus_score CHECK (campus_score BETWEEN 1 AND 5),
    CONSTRAINT ck_review_score_all_or_none CHECK (
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
        )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
  COMMENT ='高校多维评价表';

CREATE TABLE review_like
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

CREATE TABLE review_reply
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
