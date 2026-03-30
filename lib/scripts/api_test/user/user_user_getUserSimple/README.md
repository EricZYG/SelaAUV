# 获取对方简要信息 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取对方的简要信息 |
| 接口路径 | `/user/user/getUserSimple` |
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

| 参数名 | 必选 | 类型 | 说明 |
|--------|------|------|------|
| userId | 是 | Long | 用户id |

## 实际请求报文

```
GET /user/user/getUserSimple?userId=xxx
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774844189644,
  "data": {
    "userId": 10160608,
    "username": "10160608",
    "nickname": "YsRpm",
    "srcNickname": "YsRpm",
    "portrait": "https://wss3.vipcallco.com/users/common/portraits/019.png",
    "isOnline": 0,
    "vipEndTime": 0,
    "levelConfig": {
      "level": 0,
      "begin": 0,
      "end": 100000,
      "avatarFrame": null,
      "icon": "https://wss3.vipcallco.com/users/test/0/icon/922ddc7cef281c3faf7ec1d056041fac.webp"
    },
    "totalRecharge": 9999,
    "isAdvanceUser": 0,
    "sendMsgPrice": 100000,
    "sendMsgFlag": false,
    "followFlag": 0
  }
}
```

## 响应字段说明

### 基础信息

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | long | 用户ID |
| username | string | 用于显示的UID |
| nickname | string | 用户昵称 |
| srcNickname | string | 原昵称 |
| portrait | string | 头像URL |
| isOnline | int | 是否在线：0.离线，1.在线，2.忙线 |
| vipEndTime | long | VIP结束时间（时间戳） |

### 等级信息 (levelConfig)

| 字段 | 类型 | 说明 |
|------|------|------|
| id | int | 等级配置ID |
| title | string | 等级标题 |
| level | int | 等级值 |
| begin | int | 等级起始值 |
| end | int | 等级结束值 |
| avatarFrame | string | 等级头像框URL |
| icon | string | 等级图标URL |
| userType | int | 用户类型 |
| createdAt | long | 创建时间 |

### 其他信息

| 字段 | 类型 | 说明 |
|------|------|------|
| totalRecharge | int | 总充值额（分） |
| isAdvanceUser | int | 是否是高级用户：0.否，1.是 |
| sendMsgPrice | int | 发消息扣除钻石数（小数点后两位） |
| sendMsgFlag | bool | 发消息是否免费：true.免费聊天，false.需要付费扣钻 |
| followFlag | int | 是否关注：0.双方都未关注，1.我未关注&对方已回关，2.我已关注&对方未回关，3.好友 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
