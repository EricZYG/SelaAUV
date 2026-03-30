# 获取单个礼物详情 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取单个礼物详情 |
| 接口路径 | `/user/gift/getOne` |
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

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| gid | int | 是 | 礼物ID |

## 实际请求报文

```
GET /user/gift/getOne?gid=1001
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1700203007895,
  "data": {
    "id": 1,
    "gid": 1001,
    "name": "玫瑰花",
    "diamonds": 10000,
    "coins": null,
    "countryCode": 840,
    "icon": null,
    "animEffectUrl": null,
    "md5": null,
    "online": 1,
    "rankBy": 1,
    "createdAt": 1642749763769,
    "updatedAt": 1642749763769
  }
}
```

## 响应字段说明

### data

| 字段 | 类型 | 说明 |
|------|------|------|
| id | long | 数据库主键ID |
| gid | long | 礼物ID |
| name | string | 礼物名称 |
| diamonds | long | 钻石价格（小数点后两位） |
| coins | long | 金币价格（小数点后两位） |
| countryCode | int | 国家代码 |
| icon | string | 图标URL |
| animEffectUrl | string | 特效URL |
| md5 | string | 资源MD5 |
| online | int | 在线状态：1.在线，其他.离线 |
| rankBy | int | 排序权重 |
| createdAt | long | 创建时间戳 |
| updatedAt | long | 更新时间戳 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
