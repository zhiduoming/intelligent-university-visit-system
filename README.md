# UniTour 高校多维认知与择校辅助系统

## 一、项目简介

UniTour 是一个面向高中生、家长、大学生以及其他高校信息关注者的高校多维认知与择校辅助系统。

项目不只提供高校基础信息查询，而是围绕“真实校园体验”建立高校画像。当前系统覆盖高校基础信息、校区差异、校园 POI、多维评分、用户评价、回复互动、点赞、JWT 认证、Redis 缓存、注册验证码等后端能力，帮助用户从分数、排名之外理解一所大学的学习、生活、地理和文化环境。

简单来说，UniTour 想解决的问题不是“这所大学叫什么、在哪个城市”，而是：

- 这所大学真实体验怎么样？
- 同一所大学不同校区差异在哪里？
- 宿舍、食堂、地理位置、学习氛围、就业资源分别怎么样？
- 学生和校友真实评价如何？
- 如果我要了解或参观这所学校，哪些地点和信息值得重点关注？

## 二、项目背景

我本人刚刚高考完的时候，家长、教育机构和老师在讨论择校时，往往更关注分数线、专业、学校层次、地域这些硬指标。这些指标当然重要，因为它们决定了学校和专业的基本门槛。

但真正进入大学后，很多人会发现，影响大学四年体验的因素不只包括学校名气和专业强弱，还包括校区位置、宿舍条件、食堂质量、交通便利程度、学习氛围、校园文化、实习通勤成本等更具体的生活体验。

例如，有的学校整体名气不错，但学生所在校区离市中心很远，日常出行和实习通勤成本都很高；有的学校不同校区之间资源差异明显；有的学校宿舍、食堂、校园环境和学生预期差距很大。这些信息在招生资料和学校官网中通常不够直观，也很难结构化比较。

因此，UniTour 的定位不是再做一个普通的“高校查询系统”，而是尝试把高校基础信息、校区差异、校园 POI、多维评分和用户真实评价结合起来，让用户在择校前能看到更立体的高校画像。

## 三、当前实现范围

### 3.1 用户与认证

- 用户注册
- 注册验证码：后端生成验证码，写入 Redis，并设置过期时间
- 用户名或手机号登录
- JWT 登录认证
- 登录拦截器，保护需要登录的接口
- 当前用户信息查询
- 用户资料完善
- 用户头像上传
- 忘记密码：通过用户名和绑定手机号进行辅助验证
- BCrypt 密码加密存储

### 3.2 高校信息

- 高校列表分页查询
- 按关键词、省份、城市筛选高校
- 高校详情查询
- 高校详情返回校区信息
- 高校详情返回多维评分汇总
- 高校详情 Redis 缓存

### 3.3 校区与 POI

- 按校区查询校园 POI
- 展示食堂、宿舍、教学楼、图书馆等校园地点信息
- 管理员上传校区平面图
- 管理员上传 POI 图片

### 3.4 评价模块

- 登录且资料完善的用户发布高校评价
- 评价可选关联具体校区，用来表达同一高校不同校区的体验差异
- 支持纯文字评价
- 支持 8 个维度评分评价
- 分页查询高校评价列表
- 查询评价列表时批量补齐回复列表，避免 N+1 查询
- 普通用户删除自己的评价，管理员可以删除任意评价
- 新增评价回复
- 普通用户删除自己的回复，管理员可以删除任意回复
- 点赞评价
- 取消点赞评价

### 3.5 Redis 缓存

- 高校详情缓存
- 新增或删除评价后删除对应高校详情缓存
- 注册验证码缓存
- 注册验证码校验成功后立即删除，避免重复使用

## 四、技术栈

| 技术 | 用途 |
| --- | --- |
| Java 21 | 主要开发语言 |
| Spring Boot 4.0.5 | 后端应用框架 |
| Spring MVC | Web 接口开发 |
| MyBatis | 数据库访问层 |
| PageHelper | 分页查询 |
| MySQL 8.4 | 核心业务数据存储 |
| Redis 7.4 | 高校详情缓存、注册验证码缓存 |
| JWT | 登录态认证 |
| BCrypt | 密码加密 |
| Aliyun OSS | 用户头像、校区图、POI 图片上传 |
| Docker Compose | 本地 MySQL 和 Redis 环境管理 |
| Maven | 项目构建和依赖管理 |

## 五、系统架构

项目采用典型 Spring Boot 分层结构：

```text
Client / Static Pages
   |
   v
Controller
   |
   v
Service
 |    |
 |    v
 |  Redis
 v
Mapper
 |
 v
 MySQL
```

### 5.1 主要分层说明

- Controller 层：负责接收 HTTP 请求、读取路径参数和请求体，并返回统一响应结果。
- Service 层：负责核心业务规则，例如登录校验、资料完善校验、发布评价、缓存删除、管理员权限判断等。
- Mapper 层：负责通过 MyBatis 访问 MySQL。
- Interceptor：负责 JWT 登录态校验，对需要登录的接口进行保护。
- Config：负责 Web 拦截器、密码加密器、OSS 配置等基础配置。
- DTO：承接前端请求参数，例如注册、登录、评价发布、资料更新等请求。
- VO：负责返回给前端的响应视图对象，例如用户信息、高校详情、评价列表等。
- POJO：对应数据库核心实体，例如 `University`、`Campus`、`Poi`、`User`、`UniversityReview`。
- Common：放置统一返回结构、分页结构、Redis Key 常量、全局异常处理等公共能力。

## 六、核心业务流程

### 6.1 注册流程

```text
前端请求 GET /api/v1/auth/register-captcha
        |
        v
后端生成 captchaId 和验证码
        |
        v
验证码写入 Redis，设置 5 分钟过期时间
        |
        v
前端提交注册信息、手机号、captchaId、captchaCode
        |
        v
后端校验验证码
        |
        v
校验用户名和手机号唯一性
        |
        v
使用 BCrypt 加密密码
        |
        v
写入 users 表
        |
        v
删除 Redis 中的验证码
```

注册验证码不是前端随机生成，而是由后端生成并存入 Redis。这样可以证明注册流程真正经过服务端校验，而不是只做前端表单限制。

### 6.2 登录与 JWT 校验流程

```text
用户提交用户名/手机号 + 密码
        |
        v
后端根据用户名或手机号查询用户
        |
        v
校验账号状态和 BCrypt 密码
        |
        v
登录成功后签发 JWT
        |
        v
前端后续请求携带 Authorization: Bearer <token>
        |
        v
LoginCheckInterceptor 解析 token
        |
        v
将 userId 写入 request 作用域
        |
        v
Controller 从 request 中获取当前用户 ID
```

当前约定 token 放在请求头中：

```http
Authorization: Bearer <token>
```

JWT 中只放用户 ID、用户名等非敏感信息，不放密码、手机号等敏感信息。

### 6.3 用户资料完善流程

```text
用户注册后可以先浏览高校、校区、POI 等公开信息
        |
        v
用户进入个人中心补充身份、目标高校、当前高校、高中等资料
        |
        v
PUT /api/v1/users/me/profile 更新资料
        |
        v
后端更新 users.profile_completed
        |
        v
发布评价前校验 profile_completed 是否为 1
```

这样设计的原因是：注册阶段只收集必要账号信息，降低用户进入门槛；但发布评价这类贡献型行为需要更完整的用户资料，避免低质量匿名灌水。

### 6.4 高校详情查询与缓存流程

```text
用户请求 GET /api/v1/universities/{universityId}
        |
        v
先查询 Redis key: unitour:university:detail:{universityId}
        |
        --> 命中：反序列化 JSON，直接返回
        |
        --> 未命中：查询 MySQL
                    |
                    v
              组装高校基础信息、校区列表、多维评分
                    |
                    v
              写入 Redis，设置 TTL
                    |
                    v
                  返回结果
```

高校详情不是简单查一张表，而是聚合高校基础信息、校区列表和评价评分汇总。使用 Redis 缓存可以减少重复聚合查询。

### 6.5 发布评价与缓存删除流程

```text
登录用户发布评价
        |
        v
校验用户状态
        |
        v
校验用户资料是否完善
        |
        v
校验高校是否存在
        |
        v
如果传入 campusId，校验该校区是否属于当前高校
        |
        v
校验评分规则：8 个评分全部填写或全部不填写
        |
        v
写入 university_review 表
        |
        v
删除 unitour:university:detail:{universityId}
```

新增或删除评价后删除高校详情缓存，是因为高校详情中的评分汇总来自评价表聚合。评价变化后，如果不删除缓存，用户短时间内可能看到旧评分。

### 6.6 评价回复与点赞流程

```text
用户查看高校评价列表
        |
        v
后端分页查询主评价
        |
        v
批量查询当前页主评价的回复列表
        |
        v
返回评价、回复、点赞数量、当前用户是否点赞等信息
```

回复和点赞用于增强评价互动，但不直接参与高校多维评分计算。当前评分只由 `university_review` 主评价中的评分字段聚合产生。

## 七、数据库设计

当前数据库名为 `uni_tour`，核心表如下：

| 表名 | 说明 |
| --- | --- |
| `university` | 高校基础信息表 |
| `campus` | 校区表，一所高校可以有多个校区 |
| `poi` | 校园点位表，例如食堂、宿舍、图书馆、教学楼等 |
| `users` | 用户信息表，包含账号、手机号、头像、身份、资料完善状态等 |
| `university_review` | 高校多维评价表 |
| `review_reply` | 评价回复表 |
| `review_like` | 评价点赞表 |

### 7.1 表关系

```text
university 1 --- N campus
campus     1 --- N poi

university 1 --- N university_review
campus     1 --- N university_review（可选关联）
users      1 --- N university_review

university_review 1 --- N review_reply
users             1 --- N review_reply

users N --- N university_review，通过 review_like 表关联
```

### 7.2 评价评分设计

`university_review` 表中包含 8 个评分维度：

- `dormitory_score`：宿舍条件
- `canteen_score`：食堂质量
- `location_score`：地理位置
- `study_score`：学习氛围
- `culture_score`：校园文化
- `club_score`：社团活动
- `employment_score`：就业资源
- `campus_score`：校园环境

当前评分规则是：

- 可以只写文字评价，不填写评分。
- 如果填写评分，8 个评分字段必须全部填写。
- `overall_score` 由后端根据 8 个维度计算。
- 高校详情中的评分汇总来自 `university_review` 表的动态聚合。

这样做的原因是保证评分数据完整，避免用户只给某一两个维度打分导致高校综合评分失真。

## 八、接口说明

### 8.1 认证模块

| 方法 | 路径 | 说明 | 是否需要登录 |
| --- | --- | --- | --- |
| GET | `/api/v1/auth/register-captcha` | 获取注册验证码 | 否 |
| POST | `/api/v1/auth/register` | 用户注册 | 否 |
| POST | `/api/v1/auth/login` | 用户登录 | 否 |
| POST | `/api/v1/auth/forgot-password` | 忘记密码 | 否 |

### 8.2 用户模块

| 方法 | 路径 | 说明 | 是否需要登录 |
| --- | --- | --- | --- |
| GET | `/api/v1/users/me` | 查询当前用户信息 | 是 |
| PUT | `/api/v1/users/me/profile` | 更新当前用户资料 | 是 |
| POST | `/api/v1/users/me/avatar` | 上传当前用户头像 | 是 |

### 8.3 高校模块

| 方法 | 路径 | 说明 | 是否需要登录 |
| --- | --- | --- | --- |
| GET | `/api/v1/universities` | 高校列表分页查询 | 否 |
| GET | `/api/v1/universities/{universityId}` | 高校详情查询 | 否 |

高校列表支持的查询条件包括：

- `keyword`
- `province`
- `city`
- `page`
- `pageSize`

### 8.4 校区与 POI 模块

| 方法 | 路径 | 说明 | 是否需要登录 |
| --- | --- | --- | --- |
| GET | `/api/v1/campuses/{campusId}/pois` | 查询校区 POI 列表 | 否 |
| POST | `/api/v1/campuses/{campusId}/map` | 上传校区平面图 | 是，管理员 |
| POST | `/api/v1/pois/{poiId}/image` | 上传 POI 图片 | 是，管理员 |

### 8.5 评价模块

| 方法 | 路径 | 说明 | 是否需要登录 |
| --- | --- | --- | --- |
| POST | `/api/v1/universities/{universityId}/reviews` | 发布高校评价 | 是 |
| GET | `/api/v1/universities/{universityId}/reviews` | 分页查询高校评价 | 当前实现需要登录 |
| DELETE | `/api/v1/reviews/{reviewId}` | 删除自己的评价 | 是 |
| POST | `/api/v1/reviews/{reviewId}/likes` | 点赞评价 | 是 |
| DELETE | `/api/v1/reviews/{reviewId}/likes` | 取消点赞评价 | 是 |
| POST | `/api/v1/reviews/{reviewId}/replies` | 回复评价 | 是 |
| DELETE | `/api/v1/review-replies/{replyId}` | 删除自己的回复 | 是 |

注意：当前 `GET /api/v1/universities/{universityId}/reviews` 在实现上也需要登录。如果后续希望游客也能查看评价列表，需要设计“可选登录解析 token”，不能简单地把接口放行，否则当前用户是否点赞等字段会缺少上下文。

## 九、本地启动

### 9.1 环境要求

- JDK 21
- Maven 3.9+
- Docker Desktop 或 OrbStack
- MySQL 客户端，可选
- Redis 客户端，可选

### 9.2 环境变量

项目根目录需要准备 `.env` 文件，用于保存本地数据库密码、Redis 地址和 OSS 配置等信息。`.env` 不应该提交到 Git。

第一次启动前，可以先从模板复制：

```bash
cp .env.example .env
```

然后根据本机环境修改 `.env`：

```env
UNITOUR_MYSQL_ROOT_PASSWORD=your_mysql_root_password
UNITOUR_MYSQL_USERNAME=root
UNITOUR_MYSQL_URL=jdbc:mysql://localhost:3307/uni_tour
UNITOUR_REDIS_HOST=localhost
UNITOUR_REDIS_PORT=6379

UNITOUR_OSS_ENDPOINT=https://oss-cn-beijing.aliyuncs.com
UNITOUR_OSS_ACCESS_KEY_ID=your_access_key_id
UNITOUR_OSS_ACCESS_KEY_SECRET=your_access_key_secret
UNITOUR_OSS_BUCKET_NAME=your_bucket_name
UNITOUR_OSS_PUBLIC_BASE_URL=https://your_bucket_name.oss-cn-beijing.aliyuncs.com
UNITOUR_OSS_AVATAR_DIR=avatars
```

`application.yml` 通过下面配置读取项目根目录下的 `.env`：

```yaml
spring:
  config:
    import: optional:file:.env[.properties]
```

### 9.3 启动 MySQL 和 Redis

在项目根目录执行：

```bash
docker compose up -d
```

查看容器状态：

```bash
docker compose ps
```

当前 Docker Compose 暴露的端口：

```text
MySQL: 127.0.0.1:3307 -> 容器内 3306
Redis: 127.0.0.1:6379 -> 容器内 6379
```

注意：如果只是停止服务，使用：

```bash
docker compose stop
```

不要随便执行：

```bash
docker compose down -v
```

因为 `-v` 会删除 Docker volume，也就是会删除本地 MySQL 容器中的数据。

### 9.4 初始化数据库

全新本地数据库按顺序执行：

```text
src/main/database/schema.sql
src/main/database/init_info.sql
```

`schema.sql` 负责创建数据库和表结构，`init_info.sql` 负责插入演示数据。

可以通过 MySQL 客户端连接：

```bash
mysql -h127.0.0.1 -P3307 -uroot -p
```

进入后检查：

```sql
SHOW DATABASES;
USE uni_tour;
SHOW TABLES;
```

### 9.5 启动后端项目

可以在 IDEA 中直接启动主类：

```text
IntelligentUniversityVisitSystemApplication
```

也可以在项目根目录执行：

```bash
mvn spring-boot:run
```

项目默认访问地址：

```text
http://localhost:8080
```

### 9.6 编译检查

```bash
mvn -q -DskipTests compile
```

## 十、Redis 设计

当前项目中 Redis 主要用于两个场景：

1. 高校详情缓存
2. 注册验证码缓存

### 10.1 高校详情缓存

Key：

```text
unitour:university:detail:{universityId}
```

示例：

```text
unitour:university:detail:1
```

Value：

```text
UniversityDetailVO 序列化后的 JSON 字符串
```

缓存策略：

- 查询高校详情时先查 Redis。
- Redis 命中，直接反序列化并返回。
- Redis 未命中，查询 MySQL 并组装高校详情。
- 查询完成后将高校详情写入 Redis。
- 当前高校详情缓存设置 TTL，避免长期占用内存。

缓存删除时机：

- 用户新增评价后删除对应高校详情缓存。
- 用户删除评价后删除对应高校详情缓存。

这里采用的是“更新数据库后删除缓存”的策略。对当前项目来说，这比同时更新 MySQL 和 Redis 更简单，也更容易讲清楚一致性边界。

### 10.2 注册验证码缓存

Key：

```text
unitour:auth:register-captcha:{captchaId}
```

示例：

```text
unitour:auth:register-captcha:550e8400-e29b-41d4-a716-446655440000
```

验证码流程：

- 后端生成 `captchaId` 和 4 位验证码。
- 将验证码写入 Redis。
- 设置 5 分钟过期时间。
- 注册时提交 `captchaId` 和 `captchaCode`。
- 后端从 Redis 查询验证码并进行忽略大小写校验。
- 校验成功后删除 Redis key，避免同一验证码重复使用。

可以通过下面命令验证 Redis 是否正常：

```bash
docker exec unitour-redis redis-cli ping
```

返回：

```text
PONG
```

说明 Redis 正常。

## 十一、统一返回和异常处理

项目使用 `Result<T>` 作为统一响应结构。

成功响应示例：

```json
{
  "code": 1,
  "msg": "success",
  "data": {}
}
```

失败响应示例：

```json
{
  "code": 0,
  "msg": "错误原因",
  "data": null
}
```

分页接口使用 `PageResult<T>` 返回分页数据，包含总数、页码、每页数量和当前页列表。

全局异常通过 `GlobalExceptionHandler` 统一处理，避免在每个 Controller 中重复编写错误响应逻辑。

## 十二、项目亮点

### 12.1 业务方向

项目不止于在“高校信息表查询”，而是拆分出：

- 高校 `university`
- 校区 `campus`
- 校园 POI `poi`
- 多维评价 `university_review`
- 回复 `review_reply`
- 点赞 `review_like`

这种结构可以表达同一所高校不同校区之间的体验差异，也能支撑食堂、宿舍、图书馆等校园生活信息。

### 12.2 认证链路完整

项目完成了注册、登录、JWT 签发、拦截器校验、当前用户查询、资料完善等完整认证链路。

公开浏览接口和需要登录的贡献型接口被区分开，用户可以先浏览高校信息，但发布评价、点赞、回复、上传图片等行为需要登录。

### 12.3 Redis 使用

- 高校详情缓存：减少高校详情聚合查询。
- 注册验证码缓存：让验证码具备服务端校验、过期和一次性使用能力。

评价变化后删除高校详情缓存，可以避免评分汇总长期不更新。

### 12.4 评价模块有真实业务规则

评价模块不只是插入一条评论，还包含：

- 发布评价前校验用户资料是否完善
- 校验高校是否存在
- 校验可选校区是否属于当前高校
- 8 个评分维度必须全部填写或全部不填写
- 普通用户只能删除自己的评价和回复
- 管理员可以删除任意评价和回复
- 查询评价列表时批量补齐回复，避免 N+1 查询

### 12.5 本地环境可复现

项目使用 Docker Compose 管理 MySQL 和 Redis，本地启动方式相对稳定，方便面试前演示和复盘。

## 十三、后续规划

后续可以继续扩展：

- 在首页增加高校开放日功能
- 用户评价被回复触发提醒
- 可以在评论区展开多级回复
- 增加聊天窗口
- 增加学长学姐留言墙和学弟学妹愿望墙
- 增加高校参访组队功能
- 增加高校美食展示页面

## 十四、相关文档

- [UniTour 高校多维认知与择校辅助系统需求文档 v2](docs/UniTour_高校多维认知与择校辅助系统_需求文档_v2.md)
- [UniTour 面试前项目推进规划](docs/UniTour_面试前项目推进规划.md)
- [UniTour Review 模块接口说明](docs/UniTour_review模块接口说明.md)
- [UniTour Redis 高校详情缓存说明](docs/UniTour_Redis高校详情缓存说明.md)
- [数据库说明](src/main/database/README.md)
