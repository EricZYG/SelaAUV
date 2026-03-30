# 游客登录 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 游客登录 |
| 接口路径 | `/user/login/guest` |
| 请求方式 | POST |
| 需要签名 | 否 |

## 请求头

```
Accept: */*
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
content-type: application/json; charset=utf-8
device-id: d89793035d98c48f-Xiaomi
user-agent: sela,3.0.8,android Mi Note 3,9,sela100,40
user-language: zh
```

## 请求参数

### Body (JSON)

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| password | string | 是 | 加密后的密码 |
| aidLimit | int | 否 | 是否限制广告id获取：0.未限制，1.限制获取 |
| aid | string | 否 | 广告id |
| useVpn | int | 否 | 是否使用了vpn：0.未使用，1.使用了 |

## 实际请求报文

```json
{
  "password": "123456",
  "aidLimit": 0,
  "aid": "xxx",
  "useVpn": 0
}
```

## 实际响应报文

```json
{
  "code": 0,
  "data": {
    "userId": "132666486",
    "username": "132666486",
    "appChannel": "app100",
    "deregisterFlag": 1,
    "deregisterTime": 1744624195548,
    "authorization": "sv-eyJhbGciOiJIUzUxMiJ9..."
  },
  "message": "Operation succeeded"
}
```

## 响应字段说明

### data

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | string | 用户ID |
| username | string | 用户名 |
| appChannel | string | App渠道 |
| deregisterFlag | int | 是否待注销：1.是，其他.否 |
| deregisterTime | long | 注销时间戳 |
| authorization | string | 请求凭证 (JWT Token) |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
