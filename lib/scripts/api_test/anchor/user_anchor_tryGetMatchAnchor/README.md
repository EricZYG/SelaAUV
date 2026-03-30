# 获取匹配主播（不扣款）API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取匹配主播（不扣款） |
| 接口路径 | `/user/anchor/tryGetMatchAnchor` |
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
GET /user/anchor/tryGetMatchAnchor
```

## 实际响应报文

```json
{
  "code": 1008,
  "message": "余额不足，请充值后在试",
  "timestamp": 1774842318350,
  "data": null
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1008 | 余额不足，请充值后在试 |

## 说明

此接口用于预览匹配主播，不实际扣款。但如果用户余额为0可能会返回余额不足错误。
