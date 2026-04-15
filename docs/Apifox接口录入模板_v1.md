# Apifox 接口录入模板（MVP v1）

- 更新时间：2026-04-16
- 适用项目：Intelligent-University-Visit-System
- 建议环境：
  - `dev`：`http://localhost:8080`
  - 统一前缀：`/api/v1`
  - 完整 Base URL：`http://localhost:8080/api/v1`

---

## 1. Apifox 项目基础配置

## 1.1 环境变量

- `{{baseUrl}} = http://localhost:8080/api/v1`
- `{{token}} =`（先留空，登录后填）

## 1.2 通用请求头

- `Content-Type: application/json`
- 需要鉴权的接口再加：`Authorization: Bearer {{token}}`

## 1.3 统一响应示例

```json
{
  "code": 1,
  "msg": "success",
  "data": {}
}
```

---

## 2. 目录结构（建议在 Apifox 新建分组）

- `01-健康检查`
- `02-高校与校区`
- `03-POI`
- `04-认证`
- `05-愿望墙`

---

## 3. 可直接录入接口清单

## 3.1 01-健康检查

### 接口：健康检查

- 名称：`health`
- 方法：`GET`
- 路径：`/health`
- 鉴权：否
- 请求参数：无
- 成功响应示例：

```json
{
  "code": 1,
  "msg": "success",
  "data": "ok"
}
```

---

## 3.2 02-高校与校区

### 接口：查询高校列表

- 名称：`listUniversities`
- 方法：`GET`
- 路径：`/universities`
- 鉴权：否
- 请求参数：无
- 成功响应示例：

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

### 接口：查询高校详情（含校区）

- 名称：`getUniversityDetail`
- 方法：`GET`
- 路径：`/universities/{universityId}`
- 鉴权：否
- 路径参数：
  - `universityId`：`Long`，必填，大学ID
- 返回字段（学校层，必返）：
  - `id`
  - `name`
  - `shortName`
  - `description`
  - `logoUrl`
  - `officialWebsite`
  - `is985`
  - `is211`
  - `isDoubleFirstClass`
  - `schoolType`
  - `province`
  - `city`
  - `campusList`
- 成功响应示例：

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

---

## 3.3 03-POI

### 接口：按校区查询 POI 列表

- 名称：`listPoisByCampusId`
- 方法：`GET`
- 路径：`/campuses/{campusId}/pois`
- 鉴权：否
- 路径参数：
  - `campusId`：`Long`，必填，校区ID
- 查询参数（建议）：
  - `category`：`Integer`，可选，1文化/2学术/3生活/4风景
  - `sort`：`String`，可选，默认 `hotScoreDesc`
- 成功响应示例：

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

### 接口：查询 POI 详情

- 名称：`getPoiDetail`
- 方法：`GET`
- 路径：`/pois/{poiId}`
- 鉴权：否
- 路径参数：
  - `poiId`：`Long`，必填，POI ID

---

## 3.4 04-认证

### 接口：注册

- 名称：`register`
- 方法：`POST`
- 路径：`/auth/register`
- 鉴权：否
- 请求体：

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

### 接口：登录

- 名称：`login`
- 方法：`POST`
- 路径：`/auth/login`
- 鉴权：否
- 请求体：

```json
{
  "username": "xiaochen",
  "password": "12345678"
}
```

- 成功响应示例：

```json
{
  "code": 1,
  "msg": "success",
  "data": {
    "token": "jwt_token_xxx",
    "tokenType": "Bearer",
    "expiresIn": 7200
  }
}
```

### 接口：当前用户信息

- 名称：`getCurrentUser`
- 方法：`GET`
- 路径：`/users/me`
- 鉴权：是（Bearer Token）

---

## 3.5 05-愿望墙

### 接口：发布愿望

- 名称：`createWish`
- 方法：`POST`
- 路径：`/wishes`
- 鉴权：是
- 请求体：

```json
{
  "universityId": 1,
  "content": "明年一定上岸北邮！",
  "color": "#FFD966"
}
```

### 接口：按高校查询愿望

- 名称：`listWishesByUniversityId`
- 方法：`GET`
- 路径：`/universities/{universityId}/wishes`
- 鉴权：否
- 路径参数：
  - `universityId`：`Long`，必填
- 查询参数：
  - `page`：`Integer`，默认 `1`
  - `size`：`Integer`，默认 `10`

### 接口：删除愿望

- 名称：`deleteWish`
- 方法：`DELETE`
- 路径：`/wishes/{wishId}`
- 鉴权：是
- 路径参数：
  - `wishId`：`Long`，必填

---

## 4. 录入顺序建议（你当前阶段）

- 第一步先录并调通：
  - `/universities`
  - `/universities/{universityId}`
  - `/campuses/{campusId}/pois`
- 第二步补充：
  - `/health`
  - 认证三接口
- 第三步再录：
  - 愿望墙三接口
