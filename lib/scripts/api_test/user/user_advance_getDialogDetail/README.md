# 获取高级用户弹窗接口 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取高级用户弹窗接口 |
| 接口路径 | `/user/advance/getDialogDetail` |
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
GET /user/advance/getDialogDetail
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation success",
  "timestamp": 1722479786474,
  "data": {
    "rewardVo": {
      "diamondNum": 100000,
      "callCardNum": 1,
      "matchCardNum": null,
      "chatCardNum": null,
      "couponNum": null,
      "goldNum": null,
      "dollarNum": null
    },
    "whatsappId": "123456",
    "isAdvanceUser": 1,
    "isReward": 0
  }
}
```

## 响应字段说明

### data

| 字段 | 类型 | 说明 |
|------|------|------|
| rewardVo | object | 奖励信息，和任务奖励结果一样 |
| whatsappId | string | WhatsApp ID |
| isAdvanceUser | int | 是否高级用户：0.不是，1.是 |
| isReward | int | 是否已领取奖励：0.未领取，1.已领取 |

### rewardVo

| 字段 | 类型 | 说明 |
|------|------|------|
| diamondNum | int | 钻石数量 |
| callCardNum | int | 通话卡数量 |
| matchCardNum | int | 匹配卡数量 |
| chatCardNum | int | 聊天卡数量 |
| couponNum | int | 优惠券数量 |
| goldNum | int | 金币数量 |
| dollarNum | int | 美元数量 |

## 特殊说明

1. 如果不是高级用户则 `isAdvanceUser=0`
2. 如果是高级用户但是今日不弹窗则也控制 `isAdvanceUser=0`
3. WebSocket 消息 `messageType=57` 代表成为大客户，此时需要拉取此接口请求弹窗显示的内容

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
