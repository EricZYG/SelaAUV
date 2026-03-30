# 游客登录 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 游客登录 |
| 接口路径 | `/user/login/guest` |
| 请求方式 | POST |
| 需要签名 | 是 |
| 说明 | 游客登录，无需验证码 |

## 请求头

```
Accept: */*
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
authorization: {token}
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
| password | 是 | string | 加密后的密码 |
| aidLimit | 否 | int | 是否限制广告id获取，0.未限制，1.限制获取 |
| aid | 否 | string | 广告id |
| useVpn | 否 | int | 是否使用了vpn，0.未使用，1.使用了 |

## 签名规则

1. 将请求参数按照参数名ASCII码从小到大排序
2. 使用URL键值对格式拼接成字符串
3. 在末尾拼接 `time` 和 `key`（key从getAppConfig接口获取）
4. 对结果进行MD5运算，转小写得到sign

## 实际请求报文

```json
{
  "password": "encrypted_password_here",
  "aidLimit": 0,
  "aid": "test_ad",
  "useVpn": 0
}
```

## 实际响应报文

```json
{
  "code": 1004,
  "message": "您的账号已被禁用",
  "timestamp": 1774842357572
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1003 | 账号或密码输入错误 |
| 1004 | 账号已被禁用 |
| 1006 | 参数错误 |
