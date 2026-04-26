# UniTour 面试前项目推进规划

更新时间：2026-04-26

## 1. 当前目标

目标不是把 UniTour 做成完整产品，而是在 5 月中旬找日常实习前，完成一个可以写进简历、可以运行、可以讲清楚的 Java 后端 MVP。

项目主线调整为：

```text
高校多维画像 + 用户评价 + 校区 POI + Redis 缓存 + JWT 登录认证
```

不要再把愿望墙作为主功能。愿望墙可以作为后续互动功能。

## 2. 面试前必须完成到什么程度

到投递和面试前，项目至少要达到：

1. 后端项目能本地启动
2. 数据库能初始化并插入种子数据
3. 用户注册登录 JWT 闭环完成
4. 拦截器能保护需要登录的接口
5. 高校列表接口可用
6. 高校详情接口可用
7. 高校详情能返回校区列表
8. 高校详情能返回多维评分
9. 登录用户能发布评价
10. 用户能查看高校评价列表
11. 用户能删除自己的评价
12. Redis 能缓存高校详情
13. 发布/删除评价后能删除缓存
14. Docker Compose 能启动 MySQL 和 Redis
15. README 能让面试官看懂项目
16. 你能 3 分钟讲清项目
17. 你能回答 JWT、Redis、MyBatis、事务、缓存一致性的基础追问

## 3. 不要在面试前做的事

面试前不要做：

- 完整前端
- 复杂 UI
- 组队参观
- 导游路线
- 开放日系统
- AI 推荐
- 学信网认证
- 邮箱认证
- 评论审核后台
- 完整管理员系统
- 私信、通知系统
- 微服务
- Spring Security 全套
- Elasticsearch
- RabbitMQ

这些功能可以写进后续规划，但不要抢占当前实现时间。

## 4. 当前学习策略

Tlias 的定位：

```text
训练场
```

UniTour 的定位：

```text
简历项目
```

使用方式：

1. 在 Tlias 练会一个技术点
2. 立刻迁移到 UniTour
3. 不在 Tlias 上追求完整
4. UniTour 才是最终展示项目

例如：

- Tlias 练 JWT 登录，UniTour 做 users 登录认证
- Tlias 练 Redis 部门缓存，UniTour 做高校详情缓存
- Tlias 练 MyBatis 动态 SQL，UniTour 做高校列表筛选
- Tlias 练事务，UniTour 做评价发布和评分更新

## 5. 阶段规划

### Phase 1：重新冻结需求和数据库设计

建议时间：0.5-1 天

目标：

- 更新 docs 中的项目定位
- 明确 V1 只做高校多维画像和评价闭环
- 设计或调整核心表结构

需要完成：

1. 更新 `docs/当前选定范围.md`
2. 更新 `docs/一周冲刺接口文档_v1.md` 或新增 v2 文档
3. 设计 `university_review` 表
4. 确认是否第一版使用实时 AVG 计算评分
5. 确认 Redis key 设计

完成标准：

- 你能一句话讲清 V1 做什么
- 你能说清哪些功能暂不做

## Phase 2：用户认证模块

建议时间：2-3 天

目标：

完成 UniTour 的用户注册、登录、JWT 拦截和当前用户信息。

接口：

```http
POST /api/v1/auth/register
POST /api/v1/auth/login
GET /api/v1/users/me
```

需要完成：

1. User 实体
2. RegisterDTO
3. LoginDTO
4. LoginVO
5. UserVO
6. UserMapper
7. AuthService
8. AuthController
9. JwtUtils
10. LoginCheckInterceptor
11. WebConfig
12. CurrentUserContext 或 ThreadLocal，可选

技术要求：

- 密码建议 BCrypt 加密
- JWT 中只放 userId、username 等非敏感信息
- `/api/v1/auth/register` 和 `/api/v1/auth/login` 放行
- `/api/v1/users/me` 需要登录

完成标准：

- 注册成功
- 重复用户名失败
- 登录成功返回 token
- 密码错误登录失败
- 不带 token 访问 `/users/me` 失败
- 带正确 token 访问 `/users/me` 成功

面试必须能讲：

- JWT 是什么
- 为什么用拦截器
- token 放在哪里
- JWT 里不能放什么
- 拦截器如何放行登录接口

## Phase 3：高校查询主链路整理

建议时间：2 天

目标：

把已有高校列表、高校详情、校区、POI 查询链路整理成稳定接口。

接口：

```http
GET /api/v1/universities
GET /api/v1/universities/{universityId}
GET /api/v1/campuses/{campusId}/pois
GET /api/v1/pois/{poiId}
```

需要完成：

1. 接口路径统一 `/api/v1`
2. 高校列表支持分页
3. 高校列表支持 keyword / province / city
4. 高校详情返回校区列表
5. POI 支持按校区查询
6. POI 详情补齐
7. Controller 使用构造器注入
8. Mapper SQL 统一放 XML

完成标准：

- 高校列表能分页查询
- 高校详情能查到北邮、北航等数据
- 校区 POI 能查到数据
- POI 详情能查到数据

面试必须能讲：

- Controller / Service / Mapper 分层
- MyBatis XML 动态 SQL
- PageHelper 分页
- VO 和实体类为什么分开

## Phase 4：多维评分和评价模块

建议时间：4-5 天

目标：

完成项目最核心的业务能力：用户对高校进行多维评分和评价。

接口：

```http
POST /api/v1/reviews
GET /api/v1/universities/{universityId}/reviews?page=1&size=10
DELETE /api/v1/reviews/{reviewId}
```

需要完成：

1. `university_review` 表
2. Review 实体
3. ReviewCreateDTO
4. ReviewVO
5. ReviewMapper
6. ReviewService
7. ReviewController
8. 发布评价
9. 查询评价列表
10. 删除自己的评价
11. 计算评分平均值
12. 高校详情合并评分数据

评分维度：

- dormitoryScore
- canteenScore
- locationScore
- studyScore
- cultureScore
- clubScore
- employmentScore
- campusScore
- overallScore

业务规则：

- 发布评价必须登录
- 删除评价必须登录
- 用户只能删除自己的评价
- 删除使用逻辑删除
- 评价内容不能为空
- 分数范围 1-5

完成标准：

- 登录用户能发布评价
- 高校详情能显示评分
- 评价列表能分页
- 用户不能删除别人的评价
- 删除评价后评价列表不再显示

面试必须能讲：

- 为什么评价是核心功能
- 评分维度如何设计
- 逻辑删除是什么
- 如何做本人删除权限校验
- 评分如何计算
- 是否需要事务

## Phase 5：Redis 高校详情缓存

建议时间：1-2 天

目标：

使用 Redis 缓存高校详情。

缓存 key：

```text
iuvs:university:detail:{universityId}
```

需要完成：

1. 引入 Redis starter
2. 配置 Redis
3. 使用 StringRedisTemplate
4. 使用 ObjectMapper 序列化 UniversityDetailVO
5. 高校详情先查缓存
6. 缓存未命中查 MySQL
7. 写入 Redis，并设置 TTL
8. 发布评价后删除对应缓存
9. 删除评价后删除对应缓存

完成标准：

- 第一次查高校详情走 MySQL
- 第二次查同一高校详情命中 Redis
- 发布评价后缓存被删除
- 再次查询重新写入缓存

面试必须能讲：

- 为什么高校详情适合缓存
- Cache Aside 模式
- 为什么更新后删除缓存
- 缓存命中和未命中
- 缓存穿透、击穿、雪崩的基础概念

## Phase 6：Docker Compose 和本地开发环境

建议时间：1 天

目标：

让项目依赖可以一键启动。

需要完成：

```text
docker-compose.yml
```

服务：

- MySQL
- Redis

可选：

- Spring Boot app 容器化

完成标准：

- `docker compose up -d` 可以启动 MySQL 和 Redis
- README 写清楚如何初始化数据库
- application.yml 能连接本地 Docker 服务

面试必须能讲：

- Docker 容器和镜像
- 端口映射
- volume 数据卷
- compose 的作用
- Spring Boot 在本机连接 Docker 服务时用 localhost

## Phase 7：README、接口说明和面试材料

建议时间：1-2 天

目标：

把项目包装成可投递状态。

README 必须包括：

1. 项目背景
2. 项目定位
3. 技术栈
4. 核心功能
5. 项目架构
6. 数据库表说明
7. 本地启动方式
8. Docker Compose 使用方式
9. 核心接口示例
10. Redis 缓存设计
11. JWT 认证流程
12. 项目亮点
13. 后续规划

面试材料：

- 1 分钟项目介绍
- 3 分钟项目介绍
- 8 分钟项目介绍
- 10 个高频追问题

完成标准：

- 简历可以写这个项目
- 面试官打开 README 能看懂
- 你能不看稿讲清楚项目

## 6. 推荐时间安排

如果以 5 月中旬为投递节点，可以按以下节奏：

### 第 1 周

重点：认证 + 主链路

- 完成需求收敛
- 完成 JWT 注册登录
- 完成 `/users/me`
- 整理高校列表、详情、校区、POI 接口

### 第 2 周

重点：评分评价

- 建评价表
- 发布评价
- 查询评价列表
- 删除自己的评价
- 高校详情合并评分

### 第 3 周

重点：Redis + 包装

- Redis 高校详情缓存
- Docker Compose
- README
- 接口文档
- 简历描述
- 面试讲稿

### 第 4 周

重点：投递 + 查漏补缺

- 开始投递
- 每天复述项目
- 每天算法
- 每天补八股
- 根据面试反馈修项目

## 7. 每天工作节奏

建议每天：

```text
2 小时：UniTour 主功能
40 分钟：Tlias / demo 练技术点
1 小时：算法
1 小时：Java / Spring / MySQL / Redis 面试基础
20 分钟：复述项目
```

如果当天时间不够，优先级：

```text
UniTour 主功能 > 算法 > 面试基础 > Tlias
```

## 8. 每个模块的完成流程

每个模块都按这个流程走：

1. 明确业务问题
2. 写接口设计
3. 写表结构
4. 写 Controller
5. 写 Service
6. 写 Mapper / XML
7. 自测接口
8. 记录关键代码
9. 整理面试表达
10. 复写核心逻辑

不要只追求“代码跑通”。

每个模块完成后必须能回答：

- 这个模块解决什么问题？
- 涉及哪些表？
- 涉及哪些接口？
- 为什么这样设计？
- 事务在哪里？
- 缓存在哪里？
- 可能有什么问题？

## 9. 简历项目描述草稿

项目名称：

```text
UniTour 高校多维认知与择校辅助系统
```

技术栈：

```text
Spring Boot、MyBatis、MySQL、Redis、JWT、PageHelper、Docker Compose
```

项目描述：

```text
面向高中生和家长的高校多维认知与择校辅助系统，围绕宿舍、食堂、地理位置、学习氛围、文化氛围、社团活动、就业前景等维度构建高校画像，支持高校查询、校区 POI、用户评价、评分聚合和登录认证。
```

主要工作：

1. 设计高校、校区、POI、用户、评价等核心表结构，基于 MyBatis XML 实现查询、分页和动态 SQL。
2. 使用 JWT 实现登录认证，通过 Spring MVC 拦截器统一校验用户身份。
3. 实现高校列表、高校详情、校区 POI 和 POI 详情等核心查询链路。
4. 设计多维评分模型，支持用户从宿舍、食堂、地理位置、学习氛围等维度发布评价。
5. 实现评价分页查询和本人删除权限校验，使用逻辑删除保护数据。
6. 使用 Redis 缓存高校详情，发布或删除评价后删除缓存，采用 Cache Aside 模式保证最终一致性。
7. 使用 Docker Compose 管理 MySQL 和 Redis 本地开发依赖。

## 10. 面试时必须能讲的 8 个点

1. 为什么做这个项目
2. 为什么不是普通高校查询系统
3. 多维评分怎么设计
4. JWT 登录认证流程
5. 拦截器如何工作
6. MyBatis 动态 SQL 如何实现查询
7. Redis 缓存高校详情的流程
8. 评价发布后为什么要删除缓存

## 11. 当前风险

### 风险 1：范围过大

解决：

严格控制 V1，只做认证、查询、评分、评价、Redis。

### 风险 2：竞品完成度高

解决：

不和竞品拼完整社区，聚焦后端工程能力和“高校多维画像 + 校区体验 + 择校辅助”。

### 风险 3：代码依赖 AI 后自己讲不清

解决：

每个模块完成后必须复盘、复写核心逻辑，并整理面试表达。

### 风险 4：时间不够

解决：

先完成最小闭环，不做边缘功能。项目 70 分即可开始投递。

## 12. 最终判断标准

项目不是做到“完整产品”才可以投递。

达到以下状态即可开始投：

```text
认证闭环可跑
高校查询闭环可跑
评价评分闭环可跑
Redis 缓存可跑
README 可读
你能讲清楚
```

做到这一步，UniTour 就可以作为你的主简历项目。

