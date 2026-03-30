# 获取多账号用户 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取多账号用户 |
| 接口路径 | `/user/user/getMultiUser` |
| 请求方式 | GET |
| 需要签名 | 否 |
| 说明 | 存在多个账号时返回余额最多和最新登录的一个账号，与游客登录逻辑一致 |

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
GET /user/user/getMultiUser
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774843950637,
  "data": {
    "userId": 10160608,
    "username": "10160608",
    "nickname": "YsRpm",
    "portrait": "https://wss3.vipcallco.com/users/common/portraits/019.png",
    "email": null,
    "sex": 1,
    "oauthTypes": [0]
  }
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | int | 用户ID |
| username | string | 用于显示的UID |
| nickname | string | 用户昵称 |
| portrait | string | 头像URL |
| email | string | 邮箱 |
| sex | int | 性别，1.男，2.女 |
| oauthTypes | array | 登录方式列表：0.谷歌登录，4.账号密码登录 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |

## 说明

此接口用于获取多账号用户信息。当用户存在多个账号时，返回余额最多的账号和最新登录的账号信息，与游客登录逻辑一致。
