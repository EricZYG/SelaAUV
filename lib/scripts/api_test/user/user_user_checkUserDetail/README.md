# 检查用户数据完整性 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 检查用户是否缺少某些数据 |
| 接口路径 | `/user/user/checkUserDetail` |
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

无

## 实际请求报文

```
GET /user/user/checkUserDetail
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774844398756,
  "data": {
    "userId": 10208982,
    "hasSignature": 0,
    "hasTag": 0
  }
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | long | 用户ID |
| hasSignature | int | 是否有个性签名：0.否，1.是 |
| hasTag | int | 是否有标签：0.否，1.是 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
