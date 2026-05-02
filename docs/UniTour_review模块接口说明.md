# UniTour Review 模块接口说明

更新时间：2026-05-02

## 1. 模块定位

Review 模块是 UniTour V1 的核心互动模块，用来承载高校维度的用户真实评价。

当前 V1 中，评价不是独立的全站评论广场，而是挂在高校详情页下：

```text
高校详情
  -> 主评价列表
      -> 每条评价下的回复
      -> 点赞 / 取消点赞
      -> 当前用户删除自己的评价或回复
```

业务目标：

1. 让用户能围绕某所高校发布真实校园体验评价。
2. 评价可以可选关联具体校区，用来表达同一高校不同校区的体验差异。
3. 主评价可以带 8 个维度评分，也可以只写文字。
4. 回复和点赞作为轻互动能力，不直接参与高校评分计算。
5. 查询评价列表时同时返回当前页评价下的回复，便于高校详情页直接展示。

## 2. 当前实现状态

已完成并通过 Apifox 手动测试：

```http
POST   /api/v1/universities/{universityId}/reviews
GET    /api/v1/universities/{universityId}/reviews
DELETE /api/v1/reviews/{reviewId}

POST   /api/v1/reviews/{reviewId}/likes
DELETE /api/v1/reviews/{reviewId}/likes

POST   /api/v1/reviews/{reviewId}/replies
DELETE /api/v1/review-replies/{replyId}
```

已完成的关键后端能力：

1. 发布主评价。
2. 分页查询高校评价列表。
3. 查询评价列表时批量补齐回复列表，避免 N+1 查询。
4. 删除自己的主评价。
5. 点赞和取消点赞。
6. 发布回复。
7. 删除自己的回复。
8. JWT 拦截器解析 `Authorization` 请求头，把 `userId` 放入 `request` 作用域。

当前注意点：

```text
当前 WebConfig 配置下，review 相关接口都需要携带 token。
GET /api/v1/universities/{universityId}/reviews 当前也需要登录。
如果后续希望游客也能查看评价列表，需要额外设计“可选登录解析 token”的机制。
```

## 3. 认证规则

登录态通过请求头传递：

```http
Authorization: Bearer <token>
```

注意：

1. `Bearer` 和 token 中间必须有一个空格。
2. token 来自登录接口 `POST /api/v1/auth/login` 返回的 `data.token`。
3. 不要把 token 放在 JSON 请求体中。
4. 后端拦截器解析 token 后，会把当前用户 ID 放到：

```java
request.setAttribute("userId", userId);
```

Controller 层再通过：

```java
Long userId = (Long) request.getAttribute("userId");
```

传给 Service 层。

## 4. 统一响应格式

成功：

```json
{
  "code": 1,
  "msg": "success",
  "data": null
}
```

成功并返回数据：

```json
{
  "code": 1,
  "msg": "success",
  "data": {}
}
```

业务失败：

```json
{
  "code": 0,
  "msg": "错误原因",
  "data": null
}
```

未登录：

```json
{
  "code": 0,
  "msg": "NOT_LOGIN",
  "data": null
}
```

## 5. 接口总览

| 功能 | 方法 | 路径 | 是否需要登录 |
| --- | --- | --- | --- |
| 发布评价 | POST | `/api/v1/universities/{universityId}/reviews` | 是 |
| 查询评价列表 | GET | `/api/v1/universities/{universityId}/reviews` | 当前实现需要 |
| 删除评价 | DELETE | `/api/v1/reviews/{reviewId}` | 是 |
| 点赞评价 | POST | `/api/v1/reviews/{reviewId}/likes` | 是 |
| 取消点赞评价 | DELETE | `/api/v1/reviews/{reviewId}/likes` | 是 |
| 回复评价 | POST | `/api/v1/reviews/{reviewId}/replies` | 是 |
| 删除回复 | DELETE | `/api/v1/review-replies/{replyId}` | 是 |

## 6. 发布评价

### 6.1 接口

```http
POST /api/v1/universities/{universityId}/reviews
```

### 6.2 路径参数

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| universityId | Long | 是 | 被评价的高校 ID |

### 6.3 Header

```http
Authorization: Bearer <token>
Content-Type: application/json
```

### 6.4 请求体字段

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| campusId | Long | 否 | 可选校区 ID；传入时必须属于当前 universityId |
| content | String | 是 | 评价正文，trim 后不能为空，最长 1000 个字符 |
| dormitoryScore | Integer | 否 | 宿舍评分，1-5 |
| canteenScore | Integer | 否 | 食堂评分，1-5 |
| locationScore | Integer | 否 | 地理位置评分，1-5 |
| studyScore | Integer | 否 | 学习氛围评分，1-5 |
| cultureScore | Integer | 否 | 校园文化评分，1-5 |
| clubScore | Integer | 否 | 社团活动评分，1-5 |
| employmentScore | Integer | 否 | 就业资源评分，1-5 |
| campusScore | Integer | 否 | 校园环境评分，1-5 |
| isAnonymous | Integer | 否 | 是否匿名；0 非匿名，1 匿名；不传默认 0 |

### 6.5 评分规则

评分字段支持两种情况：

```text
1. 8 个评分字段全部不传：纯文字评价。
2. 8 个评分字段全部传入：带评分评价。
```

不允许只填写一部分评分。

错误示例：

```json
{
  "content": "这条评价应该失败，因为评分只填了一部分。",
  "dormitoryScore": 4,
  "canteenScore": 5
}
```

预期返回：

```json
{
  "code": 0,
  "msg": "评分必须全部填写或者全部不填写",
  "data": null
}
```

### 6.6 纯文字评价请求示例

```json
{
  "campusId": null,
  "content": "这是 Apifox 测试发布的一条纯文字评价。",
  "isAnonymous": 0
}
```

### 6.7 带评分评价请求示例

```json
{
  "campusId": null,
  "content": "这是一条带 8 个维度评分的测试评价。",
  "dormitoryScore": 4,
  "canteenScore": 4,
  "locationScore": 5,
  "studyScore": 4,
  "cultureScore": 5,
  "clubScore": 4,
  "employmentScore": 5,
  "campusScore": 4,
  "isAnonymous": 0
}
```

### 6.8 响应示例

```json
{
  "code": 1,
  "msg": "success",
  "data": null
}
```

### 6.9 业务校验

1. 用户必须登录。
2. 用户必须存在且状态正常。
3. 用户资料必须完善，即 `profileCompleted == 1`。
4. 高校 ID 不能为空。
5. 高校必须存在。
6. 如果传了 `campusId`，该校区必须属于当前高校。
7. 评价正文 trim 后不能为空。
8. 评价正文不能超过 1000 个字符。
9. 评分要么全空，要么全填。
10. 评分必须在 1-5 之间。
11. 匿名标记只能是 0 或 1。

## 7. 查询评价列表

### 7.1 接口

```http
GET /api/v1/universities/{universityId}/reviews?page=1&size=10
```

### 7.2 路径参数

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| universityId | Long | 是 | 要查询评价的高校 ID |

### 7.3 Query 参数

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| page | Integer | 否 | 1 | 页码，小于 1 时后端兜底为 1 |
| size | Integer | 否 | 10 | 每页条数，小于 1 时后端兜底为 10，最大 50 |

### 7.4 Header

当前实现需要携带：

```http
Authorization: Bearer <token>
```

### 7.5 响应示例

```json
{
  "code": 1,
  "msg": "success",
  "data": {
    "total": 2,
    "page": 1,
    "size": 10,
    "list": [
      {
        "id": 10,
        "userId": 3,
        "nickname": "评价测试用户",
        "universityId": 1,
        "campusId": null,
        "campusName": null,
        "content": "这是一条带 8 个维度评分的测试评价。",
        "dormitoryScore": 4,
        "canteenScore": 4,
        "locationScore": 5,
        "studyScore": 4,
        "cultureScore": 5,
        "clubScore": 4,
        "employmentScore": 5,
        "campusScore": 4,
        "overallScore": 4.38,
        "isAnonymous": 0,
        "createTime": "2026-05-02T13:20:00",
        "likeCount": 1,
        "replyCount": 1,
        "likedByCurrentUser": true,
        "replies": [
          {
            "id": 5,
            "reviewId": 10,
            "userId": 3,
            "nickname": "评价测试用户",
            "content": "这是 Apifox 测试发布的一条回复。",
            "createTime": "2026-05-02T13:25:00"
          }
        ]
      }
    ]
  }
}
```

### 7.6 返回字段说明

评价字段：

| 字段 | 说明 |
| --- | --- |
| id | 评价 ID |
| userId | 发布评价的用户 ID |
| nickname | 展示昵称；匿名评价显示为“匿名用户” |
| universityId | 高校 ID |
| campusId | 可选校区 ID |
| campusName | 校区名称 |
| content | 评价正文 |
| overallScore | 8 个维度评分的平均分；纯文字评价为空 |
| likeCount | 点赞数量 |
| replyCount | 回复数量 |
| likedByCurrentUser | 当前用户是否已点赞 |
| replies | 当前页评价下的回复列表 |

回复字段：

| 字段 | 说明 |
| --- | --- |
| id | 回复 ID |
| reviewId | 所属评价 ID |
| userId | 发布回复的用户 ID |
| nickname | 回复用户昵称 |
| content | 回复内容 |
| createTime | 回复创建时间 |

### 7.7 查询回复的方式

当前没有单独的“查询某条评价回复列表”接口。

回复会跟随评价列表一起返回：

```text
GET /api/v1/universities/{universityId}/reviews
  -> data.list[n].replies
```

测试新增回复和删除回复时，也通过重新查询评价列表来观察变化。

后续如果单条评价下回复数量变多，可以扩展：

```http
GET /api/v1/reviews/{reviewId}/replies?page=1&size=10
```

当前 V1 暂不实现。

## 8. 删除评价

### 8.1 接口

```http
DELETE /api/v1/reviews/{reviewId}
```

### 8.2 路径参数

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| reviewId | Long | 是 | 要删除的评价 ID |

### 8.3 Header

```http
Authorization: Bearer <token>
```

### 8.4 响应示例

```json
{
  "code": 1,
  "msg": "success",
  "data": null
}
```

### 8.5 业务规则

1. 只能删除自己发布的评价。
2. 删除方式是逻辑删除，即把 `university_review.is_deleted` 改为 1。
3. SQL 中带 `user_id` 条件，防止用户删除别人的评价。
4. 删除评价不要求 `profileCompleted == 1`。

核心 SQL 约束：

```sql
UPDATE university_review
SET is_deleted = 1
WHERE id = #{reviewId}
  AND user_id = #{userId}
  AND is_deleted = 0
```

## 9. 点赞评价

### 9.1 接口

```http
POST /api/v1/reviews/{reviewId}/likes
```

### 9.2 路径参数

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| reviewId | Long | 是 | 要点赞的评价 ID |

### 9.3 Header

```http
Authorization: Bearer <token>
```

### 9.4 响应示例

```json
{
  "code": 1,
  "msg": "success",
  "data": null
}
```

### 9.5 业务规则

1. 用户必须登录，且账号状态正常。
2. 评价必须存在且未被删除。
3. 点赞不要求 `profileCompleted == 1`。
4. 重复点赞保持幂等。

幂等含义：

```text
第一次点赞：插入点赞记录，最终状态是已点赞。
重复点赞：不插入重复记录，也不报错，最终状态仍然是已点赞。
```

当前通过唯一索引和 `INSERT IGNORE` 实现：

```sql
UNIQUE KEY uk_review_like (review_id, user_id)
```

```sql
INSERT IGNORE INTO review_like (review_id, user_id)
VALUES (#{reviewId}, #{userId})
```

## 10. 取消点赞评价

### 10.1 接口

```http
DELETE /api/v1/reviews/{reviewId}/likes
```

### 10.2 路径参数

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| reviewId | Long | 是 | 要取消点赞的评价 ID |

### 10.3 Header

```http
Authorization: Bearer <token>
```

### 10.4 响应示例

```json
{
  "code": 1,
  "msg": "success",
  "data": null
}
```

### 10.5 业务规则

1. 用户必须登录，且账号状态正常。
2. 评价必须存在且未被删除。
3. 取消点赞不要求 `profileCompleted == 1`。
4. 未点赞时取消也保持幂等。

幂等含义：

```text
已点赞：删除点赞记录，最终状态是未点赞。
未点赞：删除影响 0 行，不报错，最终状态仍然是未点赞。
```

## 11. 回复评价

### 11.1 接口

```http
POST /api/v1/reviews/{reviewId}/replies
```

### 11.2 路径参数

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| reviewId | Long | 是 | 被回复的评价 ID |

### 11.3 Header

```http
Authorization: Bearer <token>
Content-Type: application/json
```

### 11.4 请求体

```json
{
  "content": "这是 Apifox 测试发布的一条回复。"
}
```

字段说明：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| content | String | 是 | 回复内容，trim 后不能为空，最长 500 个字符 |

### 11.5 响应示例

```json
{
  "code": 1,
  "msg": "success",
  "data": null
}
```

### 11.6 业务规则

1. 用户必须登录，且账号状态正常。
2. 被回复的主评价必须存在且未删除。
3. 回复不要求 `profileCompleted == 1`。
4. 回复内容 trim 后不能为空。
5. 回复内容不能超过 500 个字符。

回复不直接参与高校评分聚合，因此门槛低于主评价。

## 12. 删除回复

### 12.1 接口

```http
DELETE /api/v1/review-replies/{replyId}
```

### 12.2 路径参数

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| replyId | Long | 是 | 要删除的回复 ID |

### 12.3 Header

```http
Authorization: Bearer <token>
```

### 12.4 响应示例

```json
{
  "code": 1,
  "msg": "success",
  "data": null
}
```

### 12.5 业务规则

1. 只能删除自己发布的回复。
2. 删除方式是逻辑删除，即把 `review_reply.is_deleted` 改为 1。
3. SQL 中带 `user_id` 条件，防止用户删除别人的回复。
4. 删除回复不要求 `profileCompleted == 1`。

核心 SQL 约束：

```sql
UPDATE review_reply
SET is_deleted = 1
WHERE id = #{replyId}
  AND user_id = #{userId}
  AND is_deleted = 0
```

## 13. Apifox 测试流程

建议在 Apifox 中配置环境变量：

| 变量名 | 示例值 | 说明 |
| --- | --- | --- |
| baseUrl | `http://localhost:8080` | 本地服务地址 |
| token | 登录返回的 token | JWT |
| universityId | `1` | 测试高校 ID |
| campusId | `1` | 可选测试校区 ID |
| reviewId | `10` | 测试评价 ID |
| replyId | `5` | 测试回复 ID |

### 13.1 启动项目

```bash
mvn spring-boot:run
```

### 13.2 注册用户

```http
POST {{baseUrl}}/api/v1/auth/register
```

```json
{
  "username": "review_user_01",
  "password": "123456",
  "nickname": "评价测试用户"
}
```

### 13.3 登录并保存 token

```http
POST {{baseUrl}}/api/v1/auth/login
```

```json
{
  "username": "review_user_01",
  "password": "123456"
}
```

从响应中取：

```text
data.token
```

保存为 Apifox 环境变量：

```text
token
```

后续需要登录的接口统一添加 Header：

```http
Authorization: Bearer {{token}}
```

### 13.4 完善用户资料

```http
PUT {{baseUrl}}/api/v1/users/me/profile
```

```json
{
  "nickname": "评价测试用户",
  "identityType": 1,
  "highSchool": "测试中学",
  "targetUniId": 1,
  "currentUniId": null
}
```

发布主评价前必须完成这一步。

### 13.5 查询高校列表

```http
GET {{baseUrl}}/api/v1/universities?page=1&size=10
```

从返回中确认可用的 `universityId`。

### 13.6 发布评价

```http
POST {{baseUrl}}/api/v1/universities/{{universityId}}/reviews
```

```json
{
  "campusId": null,
  "content": "这是 Apifox 测试发布的一条纯文字评价。",
  "isAnonymous": 0
}
```

### 13.7 查询评价列表并保存 reviewId

```http
GET {{baseUrl}}/api/v1/universities/{{universityId}}/reviews?page=1&size=10
```

从响应中取：

```text
data.list[0].id
```

保存为：

```text
reviewId
```

### 13.8 点赞并重复点赞

```http
POST {{baseUrl}}/api/v1/reviews/{{reviewId}}/likes
```

重复请求一次，预期仍然成功。

再查询评价列表，确认：

```text
likeCount = 1
likedByCurrentUser = true
```

### 13.9 取消点赞并重复取消

```http
DELETE {{baseUrl}}/api/v1/reviews/{{reviewId}}/likes
```

重复请求一次，预期仍然成功。

再查询评价列表，确认：

```text
likeCount = 0
likedByCurrentUser = false
```

### 13.10 发布回复

```http
POST {{baseUrl}}/api/v1/reviews/{{reviewId}}/replies
```

```json
{
  "content": "这是 Apifox 测试发布的一条回复。"
}
```

再查询评价列表，确认对应评价下：

```text
replyCount 增加
replies 中出现新回复
```

保存：

```text
data.list[n].replies[0].id -> replyId
```

### 13.11 删除回复

```http
DELETE {{baseUrl}}/api/v1/review-replies/{{replyId}}
```

再查询评价列表，确认对应回复不再出现。

### 13.12 删除评价

```http
DELETE {{baseUrl}}/api/v1/reviews/{{reviewId}}
```

再查询评价列表，确认该评价不再出现。

## 14. 核心设计说明

### 14.1 评价归属模型

当前评价主归属是高校：

```text
university_id 必填
campus_id 可选
```

含义：

1. 不传 `campusId`：评价整所高校。
2. 传 `campusId`：评价该高校下的某个具体校区。

后端必须校验：

```text
campusId 是否属于 universityId
```

不能只相信前端页面入口。

### 14.2 为什么主评价要求资料完善

主评价会进入高校评价体系，可能影响：

```text
高校评分聚合
校园体验展示
后续简历项目中的“多维认知”故事
```

所以当前要求：

```text
profileCompleted == 1
```

### 14.3 为什么回复和点赞不要求资料完善

回复和点赞是轻互动：

```text
回复：围绕某条评价展开，不直接参与评分聚合。
点赞：表达认可，不产生新的评分内容。
```

因此只要求：

```text
用户登录
用户存在
用户状态正常
```

### 14.4 为什么点赞和取消点赞要幂等

点赞和取消点赞容易被重复触发：

```text
用户连续点击
前端请求重试
网络波动造成重复提交
```

所以接口设计成：

```text
点赞后最终状态是已点赞。
取消点赞后最终状态是未点赞。
```

而不是要求每次请求都必须改变一行数据。

### 14.5 为什么使用逻辑删除

主评价和回复都使用逻辑删除：

```text
is_deleted = 1
```

原因：

1. 保留历史数据，便于后续审计。
2. 避免物理删除导致统计、关联关系难以追踪。
3. 面试中更容易讲清楚“内容类系统的删除策略”。

### 14.6 为什么查询评价列表时批量查回复

错误做法：

```text
查出 10 条评价
每条评价单独查一次回复
总共 1 + 10 次 SQL
```

这就是 N+1 查询问题。

当前做法：

```text
1. 分页查当前页评价列表。
2. 收集当前页 reviewId。
3. 使用 IN 批量查这些评价的回复。
4. 在 Service 层用 Map<reviewId, replies> 分组。
5. 填充到每个 ReviewVO 的 replies 字段。
```

这样当前页评价和回复通常只需要两类查询。

## 15. 当前限制和后续扩展

当前 V1 暂不实现：

1. 单独分页查询某条评价的回复列表。
2. 回复楼中楼。
3. 评论审核后台。
4. 举报功能。
5. 官方回复。
6. 消息通知。
7. 点赞消息提醒。
8. 游客查看评价时可选解析 token。

后续可扩展接口：

```http
GET  /api/v1/reviews/{reviewId}/replies?page=1&size=10
GET  /api/v1/users/me/reviews
GET  /api/v1/users/me/replies
GET  /api/v1/users/me/likes
POST /api/v1/reviews/{reviewId}/reports
```

当前阶段不建议继续扩展这些功能。V1 的优先级是：

```text
review 模块闭环
Redis 高校详情缓存
Docker Compose
README 和简历项目描述
```
