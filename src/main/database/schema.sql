CREATE DATABASE IF NOT EXISTS intelligent_university_visit_system;
DROP TABLE university;
DROP TABLE campus;
DROP TABLE users;


CREATE TABLE IF NOT EXISTS university
(
    id                    BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '高校ID',
    name                  VARCHAR(100) NOT NULL UNIQUE COMMENT '高校名称',
    short_name            VARCHAR(20) UNIQUE COMMENT '高校简称',
    description           VARCHAR(500) COMMENT '高校简介',
    logo_url              VARCHAR(255) COMMENT '校徽链接',
    official_website      VARCHAR(255) COMMENT '官网链接',
    is_985                TINYINT               DEFAULT 0 COMMENT '是否为985',
    is_211                TINYINT               DEFAULT 0 COMMENT '是否为211',
    is_double_first_class TINYINT               DEFAULT 0 COMMENT '是否为双一流',
    school_type           VARCHAR(20) COMMENT '综合/理工/师范/文史',
    province              VARCHAR(30) COMMENT '所在省',
    city                  VARCHAR(30) COMMENT '所在市',
    create_time           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted            TINYINT      NOT NULL DEFAULT 0 COMMENT '逻辑删除标记'
) COMMENT '高校信息表';


CREATE TABLE IF NOT EXISTS campus
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '校区ID',
    uni_id      BIGINT      NOT NULL COMMENT '所属高校ID',
    name        VARCHAR(50) NOT NULL COMMENT '校区名称',
    address     VARCHAR(255) COMMENT '校区地址',
    province    VARCHAR(50) COMMENT '省份',
    city        VARCHAR(50) COMMENT '城市',
    lat         DECIMAL(10, 6) COMMENT '纬度',
    lng         DECIMAL(10, 6) COMMENT '经度',
    description VARCHAR(500) COMMENT '校区描述',
    main_gate   VARCHAR(100) COMMENT '主校门名称',
    hot_score   INT         NOT NULL DEFAULT 0 COMMENT '热度分',
    data_status TINYINT     NOT NULL DEFAULT 0 COMMENT '数据状态:0占位/1完善',
    create_time DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted  TINYINT     NOT NULL DEFAULT 0 COMMENT '逻辑删除'
) COMMENT '校区表';


CREATE TABLE IF NOT EXISTS users
(
    id             BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username       VARCHAR(50)  NOT NULL UNIQUE COMMENT '用户名',
    password       VARCHAR(100) NOT NULL COMMENT '密码',
    nickname       VARCHAR(50) COMMENT '昵称',
    avatar_url     VARCHAR(255) COMMENT '头像链接',
    role           TINYINT      NOT NULL DEFAULT 0 COMMENT '角色:0普通用户/1在校生/9管理员',
    identity_type  TINYINT      NOT NULL DEFAULT 0 COMMENT '身份:0未知/1高中生/2大学生',
    high_school    VARCHAR(100) COMMENT '毕业高中',
    target_uni_id  BIGINT COMMENT '目标高校ID(可填)',
    current_uni_id BIGINT COMMENT '当前就读高校',
    phone_number   VARCHAR(20) COMMENT '手机号',
    email          VARCHAR(100) COMMENT '邮箱(可空)',
    bio            VARCHAR(500) COMMENT '个性签名',
    status         TINYINT      NOT NULL DEFAULT 1 COMMENT '账号状态:1正常/0禁用',
    create_time    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted     TINYINT      NOT NULL DEFAULT 0 COMMENT '逻辑删除'
) COMMENT '用户信息表';

CREATE TABLE IF NOT EXISTS poi
(
    id                 BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'POI主键ID',
    campus_id          BIGINT NOT NULL COMMENT '所属校区ID',
    name               VARCHAR(100) NOT NULL COMMENT '点位名称',
    category           TINYINT NOT NULL COMMENT '分类:1文化/2学术/3生活/4风景',
    suggested_duration INT NOT NULL DEFAULT 30 COMMENT '建议停留时长(分钟)',
    intro              VARCHAR(500) COMMENT '点位简介',
    image_url          VARCHAR(255) COMMENT '图片链接',
    hot_score          INT NOT NULL DEFAULT 0 COMMENT '热度分',
    data_status        TINYINT NOT NULL DEFAULT 0 COMMENT '数据状态:0占位/1完善',
    create_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted         TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除'
) COMMENT '校园点位表';
