# 领取优惠券 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 领取优惠券 |
| 接口路径 | `/p/coupon/takeCoupon/{couponId}` |
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
| couponId | 是 | int | 优惠券id |

## 实际请求报文

```
POST /p/coupon/takeCoupon/1
```

## 实际响应报文

```json
{
  "code": 1009,
  "message": "请求过于频繁",
  "timestamp": 1774842346803,
  "data": null
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1006 | 参数错误 |
| 1009 | 请求过于频繁 |
| 1010 | 优惠券已领取 |
| 1011 | 优惠券不存在 |

## 说明

此接口返回请求过于频繁，需要限制请求频率。
