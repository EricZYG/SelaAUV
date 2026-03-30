# 获取用户详情（我的页面）API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取用户详情（我的页面） |
| 接口路径 | `/user/user/getUserDetail` |
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
GET /user/user/getUserDetail
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842291605,
  "data": {
    "userId": 10208982,
    "username": "10208982",
    "nickname": "eiotC",
    "portrait": "https://wss3.vipcallco.com/users/test/0/avatar/fb5dbb5ca2dfa6f5bfb1f8a84d0ec6bd.png",
    "sex": 1,
    "countryCode": 840,
    "countrySubCode": "US",
    "appChannel": "sela100",
    "birthday": null,
    "signature": null,
    "remainDiamonds": 0,
    "vipEndTime": 0,
    "totalRecharge": 0,
    "totalConsume": 0,
    "rechargeFlag": 1,
    "hasSplitOrder": 0,
    "hasPendingSplit": 0,
    "multiUser": 1,
    "todayUser": 0,
    "faceFlag": false,
    "propVoList": [],
    "vipFlag": false,
    "showGuild": 1,
    "notifyFlag": 1,
    "sexyTipFlag": 1,
    "sexyMomentFlag": 1,
    "isAdult": 1,
    "tagImgId": 0,
    "createdAt": 1774510071720,
    "firstPaidTime": 0,
    "sexSelected": 1,
    "userGuildFlag": 0,
    "remainCoins": 0,
    "currencyCode": "USD",
    "rflag": 0
  }
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | int | 用户ID |
| username | string | 用户名 |
| nickname | string | 昵称 |
| portrait | string | 头像URL |
| sex | int | 性别（0未知，1男，2女） |
| countryCode | int | 国家代码 |
| remainDiamonds | int | 剩余钻石 |
| remainCoins | int | 剩余金币 |
| vipEndTime | long | VIP到期时间戳 |
| vipFlag | bool | VIP标志 |
| sexSelected | int | 是否已选性别 |
| totalRecharge | int | 总充值金额 |
| totalConsume | int | 总消费金额 |
