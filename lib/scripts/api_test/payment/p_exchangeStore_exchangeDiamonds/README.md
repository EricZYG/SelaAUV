# 兑换钻石 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 兑换钻石 |
| 接口路径 | `/p/exchangeStore/exchangeDiamonds` |
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
| storeId | 是 | int | 商店id |

## 实际请求报文

```json
{
  "storeId": 1
}
```

## 实际响应报文

```json
{
  "code": 1006,
  "message": "参数错误",
  "timestamp": 1774842346234,
  "data": null
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1006 | 参数错误 |

## 说明

此接口返回参数错误，可能是storeId不存在或格式不正确。
