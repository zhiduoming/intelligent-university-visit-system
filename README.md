# UniTour 高校多维认知与择校辅助系统

UniTour 是一个面向学生择校场景的 Java 后端项目，核心目标不是单纯做高校信息查询，而是帮助学生从校园生活、校区差异、食堂宿舍、学习氛围、就业感受等维度理解一所大学。

当前项目已经实现了用户认证、个人资料、高校信息、校区 POI、评价、回复、点赞，以及 Redis 高校详情缓存等后端能力。

## 技术栈

- Java 21
- Spring Boot 4.0.5
- MyBatis
- MySQL 8.4
- Redis 7.4
- Docker Compose
- Maven

## 本地环境结构

本项目使用 Docker Compose 管理本地基础设施：

```text
MySQL: 127.0.0.1:3307 -> 容器内 3306
Redis: 127.0.0.1:6379 -> 容器内 6379
```

当前 Spring Boot 项目会连接：

```text
MySQL: jdbc:mysql://localhost:3307/uni_tour
Redis: localhost:6379
```

MySQL 容器数据保存在 Docker volume 中。不要随便执行：

```bash
docker compose down -v
```

因为 `-v` 会删除 Docker volume，也就是会删除 Docker MySQL 里的数据。

如果只是停止服务，使用：

```bash
docker compose stop
```

## 环境变量配置

项目根目录下需要有一个本地 `.env` 文件，用来保存本机数据库密码等私密配置。

第一次启动时，可以从模板复制：

```bash
cp .env.example .env
```

然后编辑 `.env`：

```env
UNITOUR_MYSQL_ROOT_PASSWORD=你的本地 MySQL root 密码
UNITOUR_MYSQL_USERNAME=root
UNITOUR_MYSQL_URL=jdbc:mysql://localhost:3307/uni_tour
UNITOUR_REDIS_HOST=localhost
UNITOUR_REDIS_PORT=6379
```

`.env` 已经被 `.gitignore` 忽略，不应该提交到 Git。

`application.yml` 会通过下面这行读取项目根目录的 `.env`：

```yaml
spring.config.import: optional:file:.env[.properties]
```

这样 Docker Compose 和 Spring Boot 都可以使用同一份本地环境变量配置。

## 启动基础服务

在项目根目录执行：

```bash
docker compose up -d
```

查看服务状态：

```bash
docker compose ps
```

正常情况下应该看到：

```text
unitour-mysql   Up ... healthy
unitour-redis   Up ... healthy
```

验证 Redis：

```bash
docker exec unitour-redis redis-cli ping
```

如果返回：

```text
PONG
```

说明 Redis 正常。

连接 Docker MySQL：

```bash
mysql -h127.0.0.1 -P3307 -uroot -p
```

进入后可以检查数据库：

```sql
SHOW DATABASES;
USE uni_tour;
SHOW TABLES;
```

## 启动后端项目

可以直接在 IDEA 中启动主类，也可以在项目根目录执行：

```bash
mvn spring-boot:run
```

项目启动后默认监听：

```text
http://localhost:8080
```

## 编译检查

```bash
mvn -q -DskipTests compile
```

## 数据库初始化

全新本地数据库只需要按顺序执行：

```text
src/main/database/schema.sql
src/main/database/init_info.sql
```

`schema.sql` 负责建库建表，`init_info.sql` 负责插入当前演示数据。当前数据库脚本已经整合，初始化不需要再执行额外的增量 SQL。

演示用户的原始密码统一为 `123456`，数据库中保存的是 BCrypt 哈希。

## 当前主要功能

- 用户注册、登录
- JWT 登录态校验
- 查看当前用户信息
- 完善或更新个人资料
- 高校列表查询
- 高校详情查询
- 校区信息查询
- 校园 POI 查询
- 新增高校评价
- 分页查询高校评价列表
- 删除自己的评价
- 新增评价回复
- 删除自己的回复
- 点赞评价
- 取消点赞评价
- Redis 缓存高校详情

## Redis 缓存说明

当前 Redis 主要用于缓存高校详情：

```text
unitour:university:detail:{universityId}
```

查询高校详情时：

```text
先查 Redis
如果命中，直接返回缓存
如果未命中，查询 MySQL
然后将高校详情写入 Redis
```

当新增评价或删除评价时，会删除对应高校详情缓存，避免评分数据长期不更新。

## 常用 Docker 命令

启动 MySQL 和 Redis：

```bash
docker compose up -d
```

停止 MySQL 和 Redis，不删除数据：

```bash
docker compose stop
```

重新启动已停止的服务：

```bash
docker compose start
```

查看容器状态：

```bash
docker compose ps
```

查看 MySQL 日志：

```bash
docker compose logs -f mysql
```

查看 Redis 日志：

```bash
docker compose logs -f redis
```
