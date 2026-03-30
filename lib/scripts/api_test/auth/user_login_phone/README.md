# 手机号登录 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 手机号登录 |
| 接口路径 | `/user/login/phone` |
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
| phone | 是 | string | 手机号 |
| code | 是 | string | 验证码 |

## 签名规则

1. 将请求参数按照参数名ASCII码从小到大排序
2. 使用URL键值对格式拼接成字符串
3. 在末尾拼接 `time` 和 `key`（key从getAppConfig接口获取）
4. 对结果进行MD5运算，转小写得到sign

## 实际请求报文

```json
{
  "phone": "1234567890",
  "code": "123456"
}
```

## 实际响应报文

```json
{
  "timestamp": 1774842358093,
  "status": 404,
  "error": "Not Found",
  "path": "/login/phone"
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 404 | 接口不存在或路径错误 |
| 1003 | 账号或密码输入错误 |
