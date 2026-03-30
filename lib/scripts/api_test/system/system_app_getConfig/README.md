# 获取应用配置 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取应用配置 |
| 接口路径 | `/system/app/getConfig` |
| 请求方式 | GET |
| 需要签名 | 否 |
| 说明 | 此接口返回的 ok 字段是签名密钥，用于其他需要签名的接口 |

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
GET /system/app/getConfig
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842282036,
  "data": {
    "gameNotification": "5,12,60",
    "pddDialogDisplay2": "1,1,1,3,3,180",
    "chatCardDiamonds": 100000,
    "pddDialogDisplay1": "1,1,1,5,3,180",
    "bindGoogleReward": {
      "matchCardNum": 1,
      "diamonds": 0,
      "chatCardNum": 1,
      "callCardNum": 0
    },
    "callCardSeconds": 60,
    "agoraAppId": "178cfdcc9e2e4effaf014d02686f349b",
    "pddDialogDisplay": "0,0,0,5,3,100",
    "matchCardSeconds": 20,
    "isMustInputInviteCode": "flase",
    "versionUpdate": "27,27",
    "sayHiTime": "180,60",
    "liveUrl": "https://testemma.selalive.com",
    "callPrice": 240000,
    "msgLiveMinLevel": 1,
    "matchFreeCallState": "1",
    "ok": "SndkOePkw8V6zcjFeWJhfmozNrZ8JX6B1W6gkD",
    "inviteRewardUrl": "https://www.janelive.info/Girl-agency.html",
    "privacyChatVideoDiamonds": 200000,
    "liveAutoGame": "1",
    "coins2Diamonds": 10,
    "matchCardDiamonds": 30000,
    "freeUserShowPrice": "0",
    "luckyGiftDiamonds": 500000,
    "giftRankTopDiamonds": 4000000,
    "matchFirstDiamonds": 30000,
    "aiHelpUrl": "https://testaihelp.selalive.com",
    "guestRegisterReward": 1,
    "homeSwitchCountry": "0",
    "proVersionUrl": "https://testguild.selalive.com/#/download/",
    "supportAgentCountry": "360,170,484,784,818,504,152,682,634,724,376,792,840",
    "privacyChatImgDiamonds": 200000,
    "chatCardDays": 1,
    "registerReward": {
      "matchCardNum": 1,
      "diamonds": 10000,
      "chatCardNum": 1,
      "callCardNum": 1
    },
    "callCardDiamonds": 300000,
    "deregisterDelaySecond": 180
  }
}
```

## 重要字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| ok | string | 签名密钥（用于其他需要签名的接口） |
| callPrice | int | 通话价格（单位：钻石/分钟） |
| matchCardSeconds | int | 匹配卡秒数 |
| callCardSeconds | int | 通话卡秒数 |
| coins2Diamonds | int | 金币转钻石比例 |
| registerReward | object | 注册奖励配置 |
