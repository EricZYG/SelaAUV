# 充值（下单）API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 充值（下单） |
| 接口路径 | `/p/order/createOrder` |
| 请求方式 | POST |
| 需要签名 | 是 |

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
s-time: {timestamp}
s-sign: {signature}
```

## 请求参数

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| ppId | 是 | int | 支付渠道id |
| productId | 是 | int | 商品id |
| anchorUserId | 否 | int | 引导充值的主播 |
| couponRecordId | 否 | int | 优惠券记录id |
| videoId | 否 | int | 充值转化的虚拟视频id |
| createPath | 否 | string | 下单路径 |
| gameRoomId | 否 | string | 游戏房间ID |
| paymentToken | 否 | string | payermax支付token |
| sessionKey | 否 | string | payermax会话密钥 |

## 签名规则

1. 将请求参数按照参数名ASCII码从小到大排序
2. 使用URL键值对格式拼接成字符串
3. 在末尾拼接 `time` 和 `key`（key从getAppConfig接口获取）
4. 对结果进行MD5运算，转小写得到sign

## 实际请求报文

```json
{
  "ppId": 1,
  "productId": 1001,
  "createPath": "recharge_page"
}
```

## 实际响应报文

```json
{
  "code": 2001,
  "message": "订单无法支付",
  "timestamp": 1774842347774,
  "data": null
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1006 | 参数错误 |
| 2001 | 订单无法支付 |
| 2002 | 商品不存在 |
| 2003 | 支付渠道不可用 |

## 说明

此接口返回订单无法支付，可能是支付渠道配置问题或商品信息不正确。
