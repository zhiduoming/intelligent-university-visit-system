# Intelligent University Visit System

## MVP 接口文档与命名规范（v1.1）

- 文档版本：v1.1
- 更新时间：2026-04-16
- 适用阶段：MVP（先跑通“高校 -> 校区 -> POI”只读闭环，再扩展认证与愿望墙）

### v1.1 修订说明（2026-04-16）

- 修正“大学详情”返回字段定义：以下字段设为必返字段  
  `officialWebsite`、`is985`、`is211`、`isDoubleFirstClass`、`schoolType`
- 大学详情示例已同步修正，字段口径与大学列表保持一致

---

## 1. 统一约定

### 1.1 接口前缀

- 统一使用：`/api/v1`
- 示例：`GET /api/v1/universities`

### 1.2 命名规范（核心）

- URL 路径变量必须使用完整语义名：`{universityId}`、`{campusId}`、`{poiId}`、`{wishId}`
- Java 方法名使用“动词 + 业务对象”：
  - 查询列表：`listXxx`
  - 查询详情：`getXxxDetail`
  - 新增：`createXxx`
  - 更新：`updateXxx`
  - 删除：`deleteXxx`
  - 登录注册：`register`、`login`
- Service/Mapper 命名建议保持一致，避免“Controller 叫 list，Mapper 叫 findAllCampus”这种不一致
- 变量命名禁止泛化 `id`，统一使用 `universityId`、`campusId`、`poiId`
- POJO 字段统一驼峰：`campusId`（不要 `campus_id`）
- 状态/布尔语义字段统一 `isXxx` 风格：`isDeleted`、`is985`、`is211`

### 1.3 统一响应结构

```json
{
  "code": 1,
  "msg": "success",
  "data": {}
}
```

- `code=1`：成功
- `code=0`：失败
- 失败时 `data` 可为 `null`

---

## 2. 分层方法命名总表（推荐标准版）

| 模块 | Controller 方法 | Service 方法 | Mapper 方法 |
|---|---|---|---|
| 大学列表 | `listUniversities()` | `listUniversities()` | `selectUniversityList()` |
| 大学详情（含校区） | `getUniversityDetail(Long universityId)` | `getUniversityDetail(Long universityId)` | `selectUniversityById(Long universityId)` |
| 大学下校区列表 | `listCampusesByUniversityId(Long universityId)` | `listCampusesByUniversityId(Long universityId)` | `selectCampusesByUniversityId(Long universityId)` |
| 校区下 POI 列表 | `listPoisByCampusId(Long campusId)` | `listPoisByCampusId(Long campusId)` | `selectPoisByCampusId(Long campusId)` |
| POI 详情 | `getPoiDetail(Long poiId)` | `getPoiDetail(Long poiId)` | `selectPoiById(Long poiId)` |
| 注册 | `register(RegisterRequest request)` | `register(RegisterRequest request)` | `insertUser(User user)` |
| 登录 | `login(LoginRequest request)` | `login(LoginRequest request)` | `selectUserByUsername(String username)` |
| 当前用户 | `getCurrentUser()` | `getCurrentUser(Long userId)` | `selectUserById(Long userId)` |
| 发愿望 | `createWish(CreateWishRequest request)` | `createWish(Long userId, CreateWishRequest request)` | `insertWish(Wish wish)` |
| 愿望列表 | `listWishesByUniversityId(Long universityId, Integer page, Integer size)` | `listWishesByUniversityId(Long universityId, Integer page, Integer size)` | `selectWishesByUniversityId(Long universityId, Integer offset, Integer size)` |
| 删愿望 | `deleteWish(Long wishId)` | `deleteWish(Long userId, Long wishId)` | `softDeleteWish(Long wishId, Long userId)` |

---

## 3. 数据模型命名建议（POJO/DTO/VO）

### 3.1 POJO（与数据库主表对应）

- `University`
- `Campus`
- `Poi`
- `User`
- `Wish`

### 3.2 DTO（入参）

- `RegisterRequest`
- `LoginRequest`
- `CreateWishRequest`

### 3.3 VO（出参）

- `UniversitySimpleVO`（列表）
- `UniversityDetailVO`（详情，含 `campusList`，且必须包含学校层字段：`officialWebsite`、`is985`、`is211`、`isDoubleFirstClass`、`schoolType`）
- `CampusVO`
- `PoiVO`
- `UserProfileVO`
- `WishVO`

---

## 4. MVP 已实现与优先实现接口（标准定义）

## 4.1 获取大学列表

- 方法：`GET`
- 路径：`/api/v1/universities`
- 鉴权：否
- 当前版本请求参数：无
- 可扩展查询参数（后续）：`keyword`、`province`
- 返回 `data`：`UniversityListVO[]`

```json
{
  "code": 1,
  "msg": "success",
  "data": [
    {
      "id": 1,
      "name": "北京邮电大学",
      "shortName": "北邮",
      "description": "信息与通信特色高校，MVP重点完善数据。",
      "logoUrl": "https://www.bupt.edu.cn",
      "officialWebsite": "https://www.bupt.edu.cn",
      "is985": 1,
      "is211": 1,
      "isDoubleFirstClass": 1,
      "schoolType": "理工",
      "province": "北京",
      "city": "北京"
    }
  ]
}
```

- 推荐方法名：
  - Controller：`listUniversities`
  - Service：`listUniversities`
  - Mapper：`selectUniversityList`

## 4.2 获取大学详情（含校区）

- 方法：`GET`
- 路径：`/api/v1/universities/{universityId}`
- 鉴权：否
- 路径参数：
  - `universityId`：`Long`，大学 ID
- 返回 `data`：`UniversityDetailVO`

返回字段（学校层，必返）：

| 字段 | 类型 | 说明 |
|---|---|---|
| `id` | `Long` | 大学ID |
| `name` | `String` | 大学全称 |
| `shortName` | `String` | 大学简称 |
| `description` | `String` | 大学简介 |
| `logoUrl` | `String` | 学校 logo URL |
| `officialWebsite` | `String` | 学校官网 URL |
| `is985` | `Integer` | 是否 985（1是/0否） |
| `is211` | `Integer` | 是否 211（1是/0否） |
| `isDoubleFirstClass` | `Integer` | 是否双一流（1是/0否） |
| `schoolType` | `String` | 学校类型（理工/综合/师范...） |
| `province` | `String` | 省份 |
| `city` | `String` | 城市 |
| `campusList` | `List<CampusVO>` | 该大学下校区列表 |

```json
{
  "code": 1,
  "msg": "success",
  "data": {
    "id": 1,
    "name": "北京邮电大学",
    "shortName": "北邮",
    "description": "信息与通信特色高校，MVP重点完善数据。",
    "logoUrl": "https://www.bupt.edu.cn",
    "officialWebsite": "https://www.bupt.edu.cn",
    "is985": 1,
    "is211": 1,
    "isDoubleFirstClass": 1,
    "schoolType": "理工",
    "province": "北京",
    "city": "北京",
    "campusList": [
      {
        "id": 1,
        "uniId": 1,
        "name": "西土城校区",
        "address": "北京市海淀区西土城路10号",
        "hotScore": 95
      },
      {
        "id": 2,
        "uniId": 1,
        "name": "沙河校区",
        "address": "北京市昌平区沙河高教园",
        "hotScore": 88
      }
    ]
  }
}
```

- 推荐方法名：
  - Controller：`getUniversityDetail`
  - Service：`getUniversityDetail`
  - Mapper：
    - `selectUniversityById`
    - `selectCampusesByUniversityId`

## 4.3 获取校区下 POI 列表

- 方法：`GET`
- 路径：`/api/v1/campuses/{campusId}/pois`
- 鉴权：否
- 路径参数：
  - `campusId`：`Long`，校区 ID
- 查询参数（建议先支持默认行为）：
  - `category`：`Integer`，可选（1文化/2学术/3生活/4风景）
  - `sort`：`String`，可选，默认 `hotScoreDesc`
- 排序规则：默认 `hot_score DESC`
- 返回 `data`：`PoiVO[]`

```json
{
  "code": 1,
  "msg": "success",
  "data": [
    {
      "id": 101,
      "campusId": 2,
      "name": "图书馆",
      "category": 2,
      "suggestedDuration": 60,
      "intro": "学习与文献检索核心场所。",
      "imageUrl": null,
      "hotScore": 95
    }
  ]
}
```

- 推荐方法名：
  - Controller：`listPoisByCampusId`
  - Service：`listPoisByCampusId`
  - Mapper：`selectPoisByCampusId`

---

## 5. MVP 下一阶段接口（提前定义，避免后续返工）

## 5.1 认证模块

### 5.1.1 用户注册

- 方法：`POST`
- 路径：`/api/v1/auth/register`
- 请求体：`RegisterRequest`

```json
{
  "username": "xiaochen",
  "password": "12345678",
  "nickname": "小陈",
  "identityType": 2,
  "targetUniId": 1,
  "currentUniId": null
}
```

### 5.1.2 用户登录

- 方法：`POST`
- 路径：`/api/v1/auth/login`
- 请求体：`LoginRequest`

```json
{
  "username": "xiaochen",
  "password": "12345678"
}
```

- 返回 `data` 示例：

```json
{
  "token": "jwt_token_xxx",
  "tokenType": "Bearer",
  "expiresIn": 7200
}
```

### 5.1.3 当前用户信息

- 方法：`GET`
- 路径：`/api/v1/users/me`
- 鉴权：是（Bearer Token）

## 5.2 愿望墙模块

### 5.2.1 发愿望

- 方法：`POST`
- 路径：`/api/v1/wishes`
- 鉴权：是
- 请求体：`CreateWishRequest`

```json
{
  "universityId": 1,
  "content": "明年一定上岸北邮！",
  "color": "#FFD966"
}
```

### 5.2.2 按大学查愿望

- 方法：`GET`
- 路径：`/api/v1/universities/{universityId}/wishes`
- 鉴权：否
- 查询参数：`page`、`size`

### 5.2.3 删除愿望

- 方法：`DELETE`
- 路径：`/api/v1/wishes/{wishId}`
- 鉴权：是（仅本人可删，逻辑删除）

---

## 6. 参数与字段命名白名单（建议直接照用）

### 6.1 路径参数

- `universityId`
- `campusId`
- `poiId`
- `wishId`
- `userId`

### 6.2 通用查询参数

- `page`
- `size`
- `keyword`
- `category`
- `sort`

### 6.3 常用业务字段

- `shortName`
- `officialWebsite`
- `suggestedDuration`
- `hotScore`
- `dataStatus`
- `isDeleted`

---

## 7. 当前代码建议重命名清单（可渐进改，不必一次改完）

| 当前命名 | 推荐命名 | 说明 |
|---|---|---|
| `CampusService.findAllCampus(Long id)` | `listCampusesByUniversityId(Long universityId)` | 避免 `id` 语义不明 |
| `CampusMapper.findAll(Long id)` | `selectCampusesByUniversityId(Long universityId)` | 与 SQL 语义一致 |
| `PoiService.findAllPoi(Long campusId)` | `listPoisByCampusId(Long campusId)` | 语义更自然 |
| `PoiMapper.findAll(Long campusId)` | `selectPoisByCampusId(Long campusId)` | 与 Mapper 命名统一 |
| `Poi.campus_id` | `Poi.campusId` | Java 字段统一驼峰 |
| `Poi.hotScore (String)` | `Poi.hotScore (Integer)` | 与数据库 `INT` 对齐 |
| `CampusController.findCampus` | `listCampusesByUniversityId` | 方法名和返回值语义一致 |
| `PoiController.findAllPoi` | `listPoisByCampusId` | 与路径参数语义一致 |

---

## 8. 联调验收最小清单（本周可投递版）

- `GET /api/v1/universities`
- `GET /api/v1/universities/{universityId}`
- `GET /api/v1/campuses/{campusId}/pois`
- `GET /api/v1/health`（建议补一个健康检查）

全部通过后，你就具备可展示的后端主链路，可直接写进简历。
