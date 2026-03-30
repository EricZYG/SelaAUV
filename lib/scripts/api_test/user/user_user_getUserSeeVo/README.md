# 获取访客列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取访客列表 |
| 接口路径 | `/user/user/getUserSeeVo` |
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

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| size | 否 | int | 查询个数，不传返回24小时内的全部 |

## 实际请求报文

```
GET /user/user/getUserSeeVo?size=10
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842297084,
  "data": []
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | int | 访客用户ID |
| nickname | string | 访客昵称 |
| portrait | string | 访客头像 |
| seeTime | long | 访问时间戳 |

## 说明

当前用户没有访客记录，返回空数组。
