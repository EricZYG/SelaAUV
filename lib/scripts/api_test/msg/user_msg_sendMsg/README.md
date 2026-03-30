# 发送消息 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 发送消息 |
| 接口路径 | `/user/msg/sendMsg` |
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

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| recipientId | 是 | int | 接收者id |
| type | 是 | int | 消息类型：11.文字，12.图片，14.视频，15.语音 |
| urlOrContent | 是 | string | 图片地址/视频地址/语音地址/文本内容 |
| jsonData | 否 | string | 客户端自定义数据 |

## 实际请求报文

```json
{
  "recipientId": 12345,
  "type": 11,
  "urlOrContent": "你好，这是一条测试消息"
}
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842319338,
  "data": true
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| code | int | 响应码，0表示成功 |
| message | string | 响应消息 |
| data | bool | 是否发送成功 |

## 消息类型说明

| type | 说明 |
|------|------|
| 11 | 文字消息 |
| 12 | 图片消息 |
| 14 | 视频消息 |
| 15 | 语音消息 |
