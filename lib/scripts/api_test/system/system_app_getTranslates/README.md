# 获取翻译文案 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取翻译文案 |
| 接口路径 | `/system/app/getTranslates` |
| 请求方式 | GET |
| 需要签名 | 否 |
| 登录要求 | 可登录可不登录 |

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
GET /system/app/getTranslates
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774846175444,
  "data": "https://wss3.vipcallco.com/users/test/0/translate/sela100/en1765938887766.json"
}
```

## 响应字段说明

### 翻译文案

| 字段 | 类型 | 说明 |
|------|------|------|
| code | int | 响应码，0表示成功 |
| message | string | 响应信息 |
| timestamp | long | 时间戳 |
| data | string | 翻译文案JSON文件的URL链接 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |

## 翻译文案JSON文件格式

下载URL指向的JSON文件格式示例:

```json
{
  "app_name": "Sela",
  "home_title": "Home",
  "login_btn": "Login",
  "register_btn": "Register"
}
```
