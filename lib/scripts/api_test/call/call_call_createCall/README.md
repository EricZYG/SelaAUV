# 创建通话频道 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 创建通话频道 |
| 接口路径 | `/call/call/createCall` |
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
| type | 是 | int | 0:普通通话, 1:AIB通话, 2:匹配通话 |
| targetUserId | 是 | int | 目标用户ID |

## 实际请求报文

```json
{
  "type": 2,
  "targetUserId": 12345
}
```

## 实际响应报文

```json
{
  "timestamp": 1774842321296,
  "status": 404,
  "error": "Not Found",
  "path": "/call/createCall"
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 404 | 接口不存在或路径错误 |

## 说明

此接口返回404，可能接口路径不正确或后端未实现该接口。
