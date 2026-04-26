# UniTour 高校多维认知与择校辅助系统需求文档 v2

更新时间：2026-04-26

## 1. 项目定位

UniTour 不是一个单纯的高校查询系统，而是一个面向升学选择场景的高校多维认知与择校辅助系统。

项目核心目标是：帮助高中生、家长以及对大学感兴趣的用户，从分数、排名和专业之外，理解一所大学更真实的学习、生活、地理、文化和发展环境，从而做出更全面的择校判断。

一句话描述：

> UniTour 通过高校基础信息、校区差异、校园 POI、多维评分和真实评价，帮助用户建立对大学的立体认知。

## 2. 问题背景

很多学生在高考择校时，主要关注：

- 分数是否够
- 学校排名
- 专业是否热门
- 是否 985 / 211 / 双一流
- 地域是否能接受

但进入大学后，才发现很多真实体验和预期不一致，例如：

- 宿舍条件差异大
- 食堂质量和价格不符合预期
- 校区位置偏远，交通不便
- 学习氛围与想象不同
- 校园文化和管理风格不适合自己
- 社团活动不活跃
- 就业资源和实习机会不如预期
- 同一所大学不同校区体验差异很大

这些信息在传统招生资料中往往不透明、不结构化，也很难通过学校官网获得真实感受。

## 3. 目标用户

### 3.1 核心用户

- 高中生
- 高考志愿填报阶段的学生
- 高中生家长

### 3.2 扩展用户

- 初中生、小学生及其家长
- 想提前了解大学生活的人
- 大学生、校友
- 准备参观大学的用户
- 对高校信息感兴趣的普通用户

## 4. 核心价值

UniTour 的核心价值不是“查到一所大学”，而是回答：

- 这所大学真实体验怎么样？
- 这所大学适不适合我？
- 不同校区差异在哪里？
- 学生真实评价如何？
- 宿舍、食堂、地理位置、学习氛围、就业资源分别怎么样？
- 如果我去参观这所学校，应该看哪些地方？

## 5. 产品核心主线

项目主线从旧的“高校查询 + 愿望墙”调整为：

```text
高校基础信息
    |
    v
校区与校园 POI
    |
    v
多维评分
    |
    v
真实评价
    |
    v
择校辅助与参访决策
```

愿望墙不再作为主功能，而是后续互动模块。

## 6. 功能范围规划

### 6.1 V1 可投递 MVP

V1 的目标是：在面试前做出一个可运行、可展示、可讲清楚的后端项目。

V1 必做功能：

1. 用户注册与登录
2. JWT 登录认证
3. 当前用户信息查询
4. 高校列表
5. 高校详情
6. 校区信息
7. 校园 POI 查询
8. 高校多维评分展示
9. 用户发布评价
10. 高校评价列表
11. 评价逻辑删除或本人删除
12. Redis 缓存高校详情
13. 统一返回结果
14. 全局异常处理
15. Docker Compose 管理 MySQL 和 Redis
16. README 与接口说明

V1 暂不做：

- 组队参观
- 校园导游
- 复杂路线规划
- 开放日活动系统
- AI 推荐
- 完整后台审核系统
- 学信网认证
- 邮箱验证码认证
- 复杂社区通知
- 私信
- 管理员后台完整权限

### 6.2 V2 体验增强版

V2 可以在 V1 稳定后扩展：

- 高校对比
- 收藏高校
- 评价点赞
- 评价回复
- 评价图片上传
- 热门高校排行
- 热门 POI 排行
- 用户身份标签：高中生、大学生、校友
- 简单管理员审核评价

### 6.3 V3 参访辅助版

V3 聚焦“去大学实地参观”：

- 校园参观路线
- POI 打卡
- 推荐参观路径
- 校区入口和交通建议
- 校园开放日信息
- 参观计划收藏

### 6.4 V4 社区与推荐版

V4 是长期构想：

- 组队参观
- 学长学姐答疑
- AI 总结评价
- 根据偏好推荐高校
- 根据分数、地域、专业和体验偏好做择校辅助
- 学校官方认证与回应

## 7. V1 详细需求

### 7.1 用户模块

#### 注册

接口示例：

```http
POST /api/v1/auth/register
```

请求字段：

- username
- password
- nickname
- identityType
- targetUniId
- currentUniId

要求：

- 用户名唯一
- 密码不建议明文入库，推荐 BCrypt
- 注册成功返回统一结果

#### 登录

接口示例：

```http
POST /api/v1/auth/login
```

流程：

1. 用户提交 username / password
2. 后端查询用户
3. 校验密码
4. 生成 JWT
5. 返回 token 和用户基础信息

#### 当前用户信息

接口示例：

```http
GET /api/v1/users/me
```

要求：

- 必须登录
- 从 JWT 中获取 userId
- 返回当前用户基本信息

### 7.2 高校模块

#### 高校列表

接口示例：

```http
GET /api/v1/universities?page=1&size=10&keyword=北邮&province=北京
```

支持：

- 分页
- 按关键词搜索
- 按省份筛选
- 按城市筛选

返回字段建议：

- id
- name
- shortName
- province
- city
- schoolType
- is985
- is211
- isDoubleFirstClass
- overallScore
- reviewCount

#### 高校详情

接口示例：

```http
GET /api/v1/universities/{universityId}
```

返回内容：

- 高校基础信息
- 校区列表
- 多维评分汇总
- 简要评价统计

### 7.3 校区模块

一所大学可能有多个校区，同一所大学不同校区的体验可能差异很大。

校区字段：

- id
- universityId
- name
- address
- province
- city
- lat
- lng
- description
- hotScore

高校详情中应该包含校区列表。

### 7.4 POI 模块

POI 指校园内用户可能关心的点位，例如：

- 图书馆
- 食堂
- 宿舍区
- 教学楼
- 体育馆
- 校门
- 实验楼
- 操场
- 标志性建筑

接口示例：

```http
GET /api/v1/campuses/{campusId}/pois
GET /api/v1/pois/{poiId}
```

POI 支持：

- 按校区查询
- 按分类筛选
- 按热度排序
- 查看 POI 详情

### 7.5 多维评分模块

V1 建议先固定评分维度，不做动态配置。

建议维度：

| 字段 | 含义 |
|---|---|
| dormitoryScore | 宿舍条件 |
| canteenScore | 食堂质量 |
| locationScore | 地理位置 |
| studyScore | 学习氛围 |
| cultureScore | 文化氛围 |
| clubScore | 社团活动 |
| employmentScore | 就业前景 |
| campusScore | 校园环境 |
| overallScore | 综合评分 |

评分范围：

```text
1-5 分
```

综合评分可以先简单取平均值，后续再引入权重。

### 7.6 用户评价模块

评价是 V1 的核心功能之一，比愿望墙更重要。

用户可以对某所高校或某个校区发布评价。

评价字段建议：

- id
- userId
- universityId
- campusId
- content
- dormitoryScore
- canteenScore
- locationScore
- studyScore
- cultureScore
- clubScore
- employmentScore
- campusScore
- overallScore
- isAnonymous
- createTime
- updateTime
- isDeleted

接口：

```http
POST /api/v1/reviews
GET /api/v1/universities/{universityId}/reviews?page=1&size=10
DELETE /api/v1/reviews/{reviewId}
```

规则：

- 发布评价需要登录
- 删除评价只能删除自己的评价
- 删除建议使用逻辑删除
- 评价发布后会影响高校评分汇总
- 发布或删除评价后，需要删除高校详情缓存

## 8. Redis 使用规划

V1 只做一个明确、合理、可解释的 Redis 场景：

```text
高校详情缓存
```

缓存 key：

```text
iuvs:university:detail:{universityId}
```

缓存 value：

```text
UniversityDetailVO 的 JSON 字符串
```

缓存逻辑：

1. 查询高校详情时，先查 Redis
2. Redis 命中，直接反序列化返回
3. Redis 未命中，查询 MySQL
4. 组装高校详情、校区列表、评分汇总
5. 写入 Redis，设置过期时间
6. 返回结果

缓存失效：

- 用户发布评价后，删除对应高校详情缓存
- 用户删除评价后，删除对应高校详情缓存
- 后续如果有高校后台更新，也在更新后删除缓存

面试表达：

> 高校详情属于读多写少数据，而且包含高校基础信息、校区列表和评分汇总。我使用 Redis 缓存高校详情结果，查询时先查缓存，未命中再查数据库。评价会影响评分，所以发布或删除评价后删除对应缓存，采用 Cache Aside 模式保证最终一致性。

## 9. 技术栈

V1 建议技术栈：

- Java 21
- Spring Boot
- Spring MVC
- MyBatis
- MySQL
- Redis
- JWT
- PageHelper
- Lombok
- Docker Compose

暂不引入：

- Spring Security
- Elasticsearch
- RabbitMQ
- 微服务
- Kubernetes
- 复杂推荐算法

## 10. 核心数据表建议

V1 重点表：

- users
- university
- campus
- poi
- university_review

可选表：

- university_rating_summary
- user_favorite
- review_like

V1 为了赶进度，可以先不做 rating_summary 表，直接基于 review 表计算平均分。后续为了性能和缓存一致性，可以引入汇总表。

## 11. 与竞品的差异化

已有网站“神人高校网”已经实现了较完整的高校口碑评价平台，包括多维评分、认证用户、评价、收藏、对比、投稿、后台等功能。

UniTour 不应直接复制其形态，而应做出差异化定位：

```text
神人高校网：高校口碑社区 / 评价平台
UniTour：高校多维画像 + 校区体验 + 择校辅助 + 参访决策
```

短期差异化：

- 更强调校区差异
- 保留校园 POI 和参访场景
- 从后端工程角度实现清晰的评分、评价、缓存、认证闭环

长期差异化：

- 校园参访路线
- 高校对比解释
- 基于用户偏好的择校辅助
- AI 总结评价
- 参观计划与组队

## 12. 第一版成功标准

V1 成功不是功能多，而是闭环完整。

最低成功标准：

1. 项目能本地稳定启动
2. MySQL 数据库能初始化
3. 用户能注册、登录并获取 JWT
4. 受保护接口能通过 JWT 拦截
5. 能查询高校列表
6. 能查询高校详情
7. 高校详情包含校区和评分
8. 登录用户能发布评价
9. 能分页查看评价
10. 用户只能删除自己的评价
11. Redis 能缓存高校详情
12. 发布或删除评价后能删除缓存
13. README 能说明项目定位、启动方式、接口示例和技术亮点

