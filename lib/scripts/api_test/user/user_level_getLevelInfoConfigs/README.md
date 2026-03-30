# 获取等级区间详情 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取等级区间详情 |
| 接口路径 | `/user/level/getLevelInfoConfigs` |
| 请求方式 | GET |
| 需要签名 | 否 |

## 请求头

```
Accept: */*
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
authorization: DSTEST-eyJhbGciOiJIUzUxMiJ9...
content-type: application/json; charset=utf-8
device-id: d89793035d98c48f-Xiaomi
user-agent: sela,3.0.8,android Mi Note 3,9,sela100,40
user-language: zh
```

## 请求参数

无

## 实际请求报文

```
GET /user/level/getLevelInfoConfigs
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation success",
  "timestamp": 1709100985689,
  "data": {
    "configs": [
      {
        "id": 1,
        "title": "等级1",
        "level": 1,
        "begin": 0,
        "end": 10000,
        "avatarFrame": "https://example.com/avatar_frame.png",
        "icon": "https://example.com/icon.png",
        "userIcon": "https://example.com/user_icon.png",
        "userType": 1,
        "createdAt": 0
      },
      {
        "id": 2,
        "title": "等级2",
        "level": 2,
        "begin": 10000,
        "end": 100000,
        "avatarFrame": "https://example.com/avatar_frame.png",
        "icon": "https://example.com/icon.png",
        "userIcon": "https://example.com/user_icon.png",
        "userType": 1,
        "createdAt": 0
      }
    ],
    "total": 0
  }
}
```

## 响应字段说明

### data

| 字段 | 类型 | 说明 |
|------|------|------|
| configs | List | 等级配置列表 |
| total | int | 当前总经验值 |

### configs (数组元素)

| 字段 | 类型 | 说明 |
|------|------|------|
| id | int | 等级配置ID |
| title | string | 等级标题 |
| level | int | 等级数值 |
| begin | int | >=等级值起始 |
| end | int | <等级结束值 |
| avatarFrame | string | 头像框URL |
| icon | string | 等级图标URL |
| userIcon | string | 用户图标(主播端配置) |
| userType | int | 用户类型 |
| createdAt | long | 创建时间 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
