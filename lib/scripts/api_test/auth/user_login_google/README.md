# 谷歌登录 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 谷歌登录 |
| 接口路径 | `/user/login/google` |
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
| id_token | 是 | string | Google ID Token |

## 签名规则

1. 将请求参数按照参数名ASCII码从小到大排序
2. 使用URL键值对格式拼接成字符串
3. 在末尾拼接 `time` 和 `key`（key从getAppConfig接口获取）
4. 对结果进行MD5运算，转小写得到sign

## 实际请求报文

```json
{
  "id_token": "google_id_token_here"
}
```

## 实际响应报文

```json
{
  "timestamp": 1774842358880,
  "status": 500,
  "error": "Internal Server Error",
  "path": "/login/google"
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 500 | 服务器内部错误 |
| 1004 | 账号已被禁用 |
