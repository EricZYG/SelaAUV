# 查看对方主页埋点 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 查看对方主页埋点 |
| 接口路径 | `/user/user/saveSeeHome` |
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
| userId | 是 | int | 对方用户id |

## 实际请求报文

```
GET /user/user/saveSeeHome?userId=12345678
```

## 实际响应报文

```json
{
  "code": 1001,
  "message": "系统错误",
  "timestamp": 1774842308280,
  "data": null
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1001 | 系统错误 |
| 1006 | 参数错误 |

## 说明

此接口返回系统错误，可能是后端处理逻辑问题。
