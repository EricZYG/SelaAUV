# IP和语言检测 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | IP和语言检测 |
| 接口路径 | `/system/app/checkRegion` |
| 请求方式 | GET |
| 需要签名 | 否 |
| 登录要求 | 可登录可不登录 |

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
GET /system/app/checkRegion
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1694858983538,
  "data": 0
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| data | int | 0-检测不通过，1-检测通过 |
