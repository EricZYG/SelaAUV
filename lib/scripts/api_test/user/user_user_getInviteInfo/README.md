# 获取邀请信息 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取邀请信息 |
| 接口路径 | `/user/user/getInviteInfo` |
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
GET /user/user/getInviteInfo
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842298287,
  "data": {
    "inviteCode": "5048c0a1",
    "awardIncome": 0,
    "inviteAward": 0,
    "rechargeAward": 1000000,
    "shareUrl": "https://share.selalive.com/1bvkyzwm?label=5048c0a1",
    "inviteDailyCount": 5,
    "inviteCount": 0
  }
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| inviteCode | string | 邀请码 |
| awardIncome | int | 奖励收入 |
| inviteAward | int | 邀请奖励 |
| rechargeAward | int | 充值奖励 |
| shareUrl | string | 分享链接 |
| inviteDailyCount | int | 每日邀请次数限制 |
| inviteCount | int | 已邀请人数 |
