# 获取招呼话术列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取招呼话术列表 |
| 接口路径 | `/system/ai/getAigConfigs` |
| 请求方式 | GET |
| 需要签名 | 否 |

## 请求参数

无

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
GET /system/ai/getAigConfigs
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1700632391285,
  "data": [
    "abc",
    "abc"
  ]
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| data | array | 话术字符串列表 |
