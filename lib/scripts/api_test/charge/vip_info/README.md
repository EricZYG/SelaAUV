# 获取VIP信息 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取VIP信息 |
| 接口路径 | `/vip/info` |
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

## 实际请求报文

```
GET /vip/info
```

## 实际响应报文

```json
{
  "timestamp": 1774842337556,
  "path": "/vip/info",
  "status": 404,
  "error": "Not Found",
  "message": null,
  "requestId": "b9e7cf1b-7660871"
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 404 | 接口不存在或路径错误 |

## 说明

此接口返回404，可能接口路径不正确。
