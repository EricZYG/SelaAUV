# 按国家获取银行渠道列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 按国家获取银行渠道列表 |
| 接口路径 | `/system/bank/getPayoutChannels` |
| 请求方式 | GET |
| 需要签名 | 否 |

## 请求参数

| 参数名 | 必选 | 类型 | 说明 |
|--------|------|------|------|
| countryCode | 是 | int | 国家编码 |

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
GET /system/bank/getPayoutChannels?countryCode=123
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774847411292,
  "data": [
    {
      "payId": 1740299275442601985,
      "payoutType": 1,
      "channelType": "BankTransfer",
      "channelName": "BankTransfer",
      "nationalFlagPath": "https://wss3.vipcallco.com/users/test/0/payout/3c98422f95225d4032919b8e6684c1bf.png"
    },
    {
      "payId": 1959931541792161794,
      "payoutType": 3,
      "channelType": "USDT-Tron",
      "channelName": "USDT-Tron",
      "nationalFlagPath": "https://wss3.vipcallco.com/users/test/0/payout/66b0359b0a7eaa487b22e1729504e3bb.png"
    },
    {
      "payId": 1800500783786024962,
      "payoutType": 2,
      "channelType": "USDT",
      "channelName": "USDT",
      "nationalFlagPath": "https://wss3.vipcallco.com/users/test/0/payout/376e14a5eae2386b2ed27fdc1aae07c6.jpeg"
    }
  ]
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| payId | long | 收款id |
| payoutType | int | 收款类型 |
| channelType | string | 支付渠道编码 |
| channelName | string | 支付渠道名称 |
| nationalFlagPath | string | 图标 |
