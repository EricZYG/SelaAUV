# 获取邀请奖励配置列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取邀请奖励配置列表 |
| 接口路径 | `/user/user/queryInviteRewardConfig` |
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

无

## 实际请求报文

```
GET /user/user/queryInviteRewardConfig
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774844070856,
  "data": [
    {
      "countryCode": 0,
      "countryName": null,
      "countryPath": null,
      "femaleAuthCoins": 10000,
      "femaleIncomeCoins": 600000
    },
    {
      "countryCode": 360,
      "countryName": "Indonesia",
      "countryPath": "https://wss3.vipcallco.com/users/test/0/country/44058ad2ea0bbeeaf359cad10d438637.png",
      "femaleAuthCoins": 100000,
      "femaleIncomeCoins": 1200000
    },
    {
      "countryCode": 76,
      "countryName": "Brazil",
      "countryPath": "https://wss3.vipcallco.com/users/test/0/country/5ab75c80f4a4cb72e3fbfa8788898245.png",
      "femaleAuthCoins": 30000000,
      "femaleIncomeCoins": 2000000
    },
    {
      "countryCode": 840,
      "countryName": "America",
      "countryPath": "https://wss3.vipcallco.com/users/test/0/country/47962e125f11835be9b955d99cc5b495.webp",
      "femaleAuthCoins": 100000,
      "femaleIncomeCoins": 1200000
    }
  ]
}
```

## 支持的国家/地区

| 国家编码 | 国家名称 | 女用户认证奖励 | 收入达标奖励 |
|----------|----------|----------------|--------------|
| 0 | 默认 | 10,000 | 600,000 |
| 360 | Indonesia | 100,000 | 1,200,000 |
| 504 | المغرب | 100,000 | 1,200,000 |
| 764 | Thailand | 100,000 | 1,200,000 |
| 792 | Turkey | 100,000 | 1,200,000 |
| 76 | Brazil | 30,000,000 | 2,000,000 |
| 840 | America | 100,000 | 1,200,000 |

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| countryCode | int | 国家编码 |
| countryName | string | 国家名称 |
| countryPath | string | 国旗地址 |
| femaleAuthCoins | int | 被邀请女用户认证奖励（金币） |
| femaleIncomeCoins | int | 被邀请女用户收入达标奖励（金币） |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
