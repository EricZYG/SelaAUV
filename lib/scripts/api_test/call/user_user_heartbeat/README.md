# 心跳请求 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 心跳请求 |
| 接口路径 | `/user/user/heartbeat` |
| 请求方式 | POST |
| 需要签名 | 否 |
| 说明 | 1-2分钟间隔请求一次，用于保持在线状态 |

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

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| isScreenOff | 否 | bool | 主播是否熄屏 |
| rtmStatus | 否 | int | 用户RTM状态：0离线，1在线 |

## 实际请求报文

```json
{
  "isScreenOff": false,
  "rtmStatus": 1
}
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842327831,
  "data": null
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| code | int | 响应码，0表示成功 |
| message | string | 响应消息 |
| data | null | 无需返回数据 |
