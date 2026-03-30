# 苹果登录 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 苹果登录 |
| 接口路径 | `/user/login/apple` |
| 请求方式 | POST |
| 需要签名 | 是 |

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
| identity_token | 是 | string | Apple Identity Token |
| authorization_code | 否 | string | 苹果授权码 |
| name | 否 | string | 用户显示名称 |

## 签名规则

1. 将请求参数按照参数名ASCII码从小到大排序
2. 使用URL键值对格式拼接成字符串
3. 在末尾拼接 `time` 和 `key`（key从getAppConfig接口获取）
4. 对结果进行MD5运算，转小写得到sign

## 实际请求报文

```json
{
  "identity_token": "apple_identity_token",
  "authorization_code": "authorization_code_here",
  "name": "Test User"
}
```

## 实际响应报文

```json
{
  "code": 1003,
  "message": "账号或密码输入错误",
  "timestamp": 1774842359472
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1003 | 账号或密码输入错误 |
| 1004 | 账号已被禁用 |
