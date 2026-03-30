# 获取用户是否在线 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取用户是否在线 |
| 接口路径 | `/user/user/getIsOnlines` |
| 请求方式 | POST |
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

| 参数名 | 必选 | 类型 | 说明 |
|--------|------|------|------|
| userIds | 是 | List<Long> | 用户id列表 |

## 实际请求报文

```json
{
  "userIds": [10160608, 10000389]
}
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1701054487480,
  "data": [
    {
      "userId": 10160608,
      "isOnline": 1,
      "inScreen": 1
    },
    {
      "userId": 10000389,
      "isOnline": 0,
      "inScreen": 0
    }
  ]
}
```

## 响应字段说明

### data (数组)

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | long | 用户ID |
| isOnline | int | 是否在线：0.离线，1.在线，2.忙线 |
| inScreen | int | 是否在屏幕中：0.否，1.是 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
