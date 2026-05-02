# UniTour Redis 高校详情缓存说明

更新时间：2026-05-02

## 1. 模块目标

当前 Redis 缓存用于优化高校详情接口：

```http
GET /api/v1/universities/{universityId}
```

高校详情接口会组装多部分数据：

```text
高校基础信息
校区列表 campusList
评分汇总 rating
```

其中评分汇总来自 `university_review` 表的动态聚合。这个接口如果每次都直接查 MySQL，会重复执行高校基础信息、校区列表和评分聚合查询。

因此当前使用 Redis 缓存高校详情结果：

```text
第一次查询：查 MySQL，组装 UniversityDetailVO，写入 Redis
后续查询：命中 Redis，直接反序列化返回
评价变化：删除对应高校详情缓存，下次查询重新加载
```

## 2. 当前实现状态

已完成并验证：

1. 引入 Redis 依赖。
2. 配置 Redis 连接。
3. 使用 `StringRedisTemplate` 操作 Redis String。
4. 使用 `ObjectMapper` 做 `UniversityDetailVO` 和 JSON 字符串转换。
5. 高校详情缓存 key 统一放在 `RedisKeyConstants`。
6. 高校详情查询支持缓存命中和缓存未命中。
7. 缓存写入时设置 30 分钟 TTL。
8. 发布评价后删除高校详情缓存。
9. 删除评价后删除高校详情缓存。
10. 已通过 `redis-cli` 验证 key、value、TTL、缓存命中和缓存失效。

## 3. Redis 依赖和配置

### 3.1 Maven 依赖

项目使用 Spring Boot Redis Starter：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

当前不额外引入 Jedis 或连接池依赖。Spring Boot 默认 Redis 客户端已经足够支撑当前本地开发和简历项目演示。

### 3.2 application.yml

当前 Redis 配置：

```yaml
spring:
  data:
    redis:
      host: localhost
      port: 6379
```

本地 Redis 通过 OrbStack / Docker 启动，并暴露到：

```text
localhost:6379
```

## 4. 缓存 key 设计

缓存 key 统一由 `RedisKeyConstants` 生成：

```java
public class RedisKeyConstants {
    public static final String UNIVERSITY_DETAIL_KEY_PREFIX = "unitour:university:detail:";

    private RedisKeyConstants() {
    }

    public static String universityDetailKey(Long universityId) {
        return UNIVERSITY_DETAIL_KEY_PREFIX + universityId;
    }
}
```

key 格式：

```text
unitour:university:detail:{universityId}
```

示例：

```text
unitour:university:detail:1
```

含义：

| 片段 | 含义 |
| --- | --- |
| unitour | 项目名，避免和其他项目 key 冲突 |
| university | 业务模块 |
| detail | 缓存对象类型 |
| 1 | 具体高校 ID |

## 5. 缓存 value 设计

当前使用 Redis String 类型存储 JSON 字符串。

Redis key：

```text
unitour:university:detail:1
```

Redis value：

```json
{
  "id": 1,
  "name": "北京邮电大学",
  "shortName": "北邮",
  "campusList": [
    {
      "id": 1,
      "universityId": 1,
      "name": "西土城校区",
      "address": "北京市海淀区西土城路10号",
      "hotScore": 95
    }
  ],
  "rating": {
    "dormitoryScore": 4.00,
    "canteenScore": 4.00,
    "locationScore": 4.25,
    "studyScore": 4.50,
    "cultureScore": 4.25,
    "clubScore": 4.00,
    "employmentScore": 5.00,
    "campusScore": 4.00,
    "overallScore": 4.25,
    "reviewCount": 5
  }
}
```

实际 Redis 中看到的是 JSON 字符串。`redis-cli` 可能把中文显示成 UTF-8 转义形式，例如：

```text
\xe5\x8c\x97\xe4\xba\xac...
```

这不是错误。Java 读取后会反序列化成对象，接口响应中仍然是正常中文。

## 6. 为什么使用 String 存 JSON

当前缓存目标是整个高校详情接口返回结果，而不是频繁修改某个单独字段。

`UniversityDetailVO` 不是扁平对象，它包含：

```text
高校基础信息
campusList 数组
rating 嵌套对象
```

如果使用 Redis Hash，会遇到嵌套结构拆分问题：

```text
campusList 仍然需要转 JSON
rating 仍然需要转 JSON
多个 key / 多个 field 的 TTL 和删除一致性更复杂
```

因此当前采用：

```text
String key
JSON value
```

优点：

1. 代码简单。
2. 直接缓存接口返回对象。
3. 命中后可以直接反序列化成 `UniversityDetailVO`。
4. 删除缓存时只需要删除一个 key。
5. 更适合当前 V1 的高校详情缓存场景。

## 7. Cache Aside 查询流程

当前采用 Cache Aside 模式。

查询高校详情流程：

```text
1. 根据 universityId 生成 Redis key。
2. 查询 Redis。
3. 如果 Redis 命中，JSON 反序列化成 UniversityDetailVO 并直接返回。
4. 如果 Redis 未命中，查询 MySQL。
5. 查询高校基础信息。
6. 查询校区列表。
7. 查询评分汇总。
8. 组装 UniversityDetailVO。
9. 序列化成 JSON 字符串。
10. 写入 Redis，并设置 TTL。
11. 返回 UniversityDetailVO。
```

对应代码位置：

```text
src/main/java/com/github/zhiduoming/service/impl/UniversityServiceImpl.java
```

核心逻辑：

```java
String key = RedisKeyConstants.universityDetailKey(universityId);
String cacheJson = stringRedisTemplate.opsForValue().get(key);
if (cacheJson != null) {
    log.info("高校详情缓存命中, universityId={}, key={}", universityId, key);
    return objectMapper.readValue(cacheJson, UniversityDetailVO.class);
}

log.info("高校详情缓存未命中, universityId={}, key={}", universityId, key);

UniversityDetailVO universityDetail = universityMapper.selectUniversityById(universityId);
if (universityDetail == null) {
    return null;
}
List<CampusVO> campusList = campusMapper.selectCampusesByUniversityId(universityId);
universityDetail.setCampusList(campusList);
UniversityRatingVO rating = universityMapper.selectUniversityRating(universityId);
universityDetail.setRating(rating);

String detailJson = objectMapper.writeValueAsString(universityDetail);
stringRedisTemplate.opsForValue().set(
        key,
        detailJson,
        Duration.ofMinutes(30)
);
```

## 8. TTL 设计

当前高校详情缓存 TTL：

```text
30 分钟
```

代码：

```java
Duration.ofMinutes(30)
```

Redis 中查看：

```redis
TTL unitour:university:detail:1
```

示例：

```text
(integer) 1693
```

说明该 key 还剩 1693 秒过期。

设置 TTL 的原因：

1. 防止缓存长期占用 Redis 内存。
2. 即使缓存失效逻辑有遗漏，数据也会在一段时间后自动刷新。
3. 当前 V1 数据变化频率不高，30 分钟足够用于本地演示和面试讲解。

## 9. 缓存失效策略

高校详情中的 `rating` 来自评价表聚合。

因此以下操作会影响高校详情缓存：

```text
发布评价
删除评价
```

当前处理方式：

```text
MySQL 写成功后，删除对应高校详情缓存。
```

不直接更新缓存，而是删除缓存。下次查询高校详情时重新查 MySQL 并写入 Redis。

### 9.1 发布评价后删除缓存

位置：

```text
ReviewServiceImpl#createReview
```

逻辑：

```java
int rows = reviewMapper.insertReview(review);
if (rows != 1) {
    throw new RuntimeException("评论添加失败");
}
stringRedisTemplate.delete(RedisKeyConstants.universityDetailKey(universityId));
```

### 9.2 删除评价后删除缓存

位置：

```text
ReviewServiceImpl#deleteReview
```

删除评价接口只有 `reviewId`，没有 `universityId`，所以要先查出评价实体：

```java
UniversityReview review = checkReviewExists(reviewId);
```

然后删除成功后，根据评价所属高校删除缓存：

```java
int rows = reviewMapper.logicDeleteReviewByIdAndUserId(reviewId, userId);
if (rows != 1) {
    throw new RuntimeException("无权限删除该评价");
}
stringRedisTemplate.delete(RedisKeyConstants.universityDetailKey(review.getUniversityId()));
```

### 9.3 哪些操作不删除高校详情缓存

以下操作当前不删除高校详情缓存：

```text
点赞评价
取消点赞评价
发布回复
删除回复
```

原因：

```text
这些操作不影响 UniversityDetailVO.rating。
```

如果后续高校详情页也展示评价点赞数、回复数等聚合信息，再重新评估是否需要清理缓存。

## 10. 为什么删除缓存而不是更新缓存

当前使用 Cache Aside 模式，数据变更时采用：

```text
先更新 MySQL
再删除 Redis 缓存
```

不采用：

```text
先更新 MySQL
再重新计算并更新 Redis
```

原因：

1. 删除缓存更简单。
2. 避免在 ReviewService 中重复写高校详情组装逻辑。
3. 下次查询会重新从 MySQL 生成最新详情。
4. 更符合常见缓存一致性处理方式。

当前一致性模型：

```text
MySQL 是最终数据源。
Redis 是临时缓存。
缓存失效后，下次查询重新加载最新数据。
```

## 11. 日志验证

当前已在 `UniversityServiceImpl#getUniversityDetail` 中加入缓存日志。

缓存命中：

```text
高校详情缓存命中, universityId=1, key=unitour:university:detail:1
```

缓存未命中：

```text
高校详情缓存未命中, universityId=1, key=unitour:university:detail:1
```

写入缓存：

```text
高校详情写入缓存, universityId=1, key=unitour:university:detail:1, ttl=30min
```

配合 MyBatis SQL 日志可以判断请求来源：

```text
缓存未命中：控制台会出现 MyBatis SQL 查询。
缓存命中：不会再出现高校详情相关 SQL。
```

## 12. redis-cli 验证流程

### 12.1 查看所有 key

```redis
KEYS *
```

示例：

```text
1) "unitour:university:detail:1"
```

### 12.2 查看缓存内容

```redis
GET unitour:university:detail:1
```

预期：

```text
返回 UniversityDetailVO 的 JSON 字符串
```

### 12.3 查看过期时间

```redis
TTL unitour:university:detail:1
```

预期：

```text
返回 0 到 1800 之间的正整数
```

### 12.4 删除缓存

```redis
DEL unitour:university:detail:1
```

### 12.5 验证缓存命中和未命中

1. 删除缓存：

```redis
DEL unitour:university:detail:1
```

2. Apifox 请求：

```http
GET /api/v1/universities/1
```

预期：

```text
控制台打印“高校详情缓存未命中”
控制台出现 MyBatis SQL
Redis 写入 unitour:university:detail:1
```

3. 再次请求同一个接口：

```http
GET /api/v1/universities/1
```

预期：

```text
控制台打印“高校详情缓存命中”
不再出现高校详情相关 MyBatis SQL
```

### 12.6 验证缓存失效

1. 先请求高校详情，确保缓存存在。

2. 发布评价：

```http
POST /api/v1/universities/1/reviews
```

3. 查看缓存：

```redis
GET unitour:university:detail:1
```

预期：

```text
(nil)
```

4. 再次请求高校详情：

```http
GET /api/v1/universities/1
```

预期：

```text
缓存未命中
重新查 MySQL
重新写入 Redis
```

## 13. 当前限制

当前第一版 Redis 缓存暂不处理：

1. Redis 异常时的降级。
2. 缓存穿透空值缓存。
3. 缓存击穿互斥锁。
4. 缓存雪崩随机 TTL。
5. Redis 主从、哨兵、集群。
6. 分布式锁。
7. 热点 key 保护。

当前这些不做是有意控制范围。

V1 目标是先完成：

```text
Cache Aside 查询缓存
评价变更后缓存失效
可通过日志和 redis-cli 验证
```

## 14. 后续可优化方向

如果后续继续增强，可以考虑：

1. Redis 异常降级：Redis 失败时记录日志，仍然查 MySQL 返回。
2. 空值缓存：高校不存在时缓存空值，防止缓存穿透。
3. 随机 TTL：在基础 TTL 上加随机秒数，降低缓存雪崩风险。
4. 缓存 key 统一管理更多模块。
5. Docker Compose 管理 MySQL 和 Redis。
6. README 中补充 Redis 启动和验证步骤。

## 15. 面试讲法

可以这样讲：

```text
我对高校详情接口做了 Redis 缓存，采用 Cache Aside 模式。查询时先根据 universityId 生成 unitour:university:detail:{id} 这样的 key，然后查 Redis。如果命中，就把 JSON 字符串反序列化成 UniversityDetailVO 返回；如果未命中，就查 MySQL，组装高校基础信息、校区列表和评分汇总，再序列化成 JSON 写入 Redis，并设置 30 分钟 TTL。

因为高校详情中的评分来自评价表，所以发布评价或删除评价后，我会删除对应高校详情缓存。这样下次查询会重新从 MySQL 加载最新评分，再写入 Redis。点赞、回复这些轻互动不影响高校评分，所以当前不会删除高校详情缓存。
```

需要能进一步解释：

```text
为什么用 String 存 JSON，而不是 Hash
为什么删除缓存，而不是更新缓存
为什么设置 TTL
怎么判断请求命中了缓存
发布评价后为什么要删除缓存
```
