# 分页查询聊天记录 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 分页查询聊天记录 |
| 接口路径 | `/user/msg/getMsgRecords` |
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

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| otherUserId | 否 | int | 对方用户id（选填） |
| offsetId | 否 | string | 偏移id，初始不传，后续传上次记录列表中的最后一个元素的id |
| pageSize | 是 | int | 每页条数 |

## 实际请求报文

```
GET /user/msg/getMsgRecords?pageSize=20
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842321516,
  "data": []
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| msgId | string | 消息ID |
| fromUserId | int | 发送者用户ID |
| toUserId | int | 接收者用户ID |
| type | int | 消息类型 |
| content | string | 消息内容 |
| createTime | long | 创建时间戳 |

## 说明

当前用户没有聊天记录，返回空数组。
