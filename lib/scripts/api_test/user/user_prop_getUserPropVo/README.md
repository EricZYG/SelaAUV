# 获取用户背包道具列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取用户背包道具列表 |
| 接口路径 | `/user/prop/getUserPropVo` |
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

## 实际请求报文

```
GET /user/prop/getUserPropVo
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842295817,
  "data": []
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| propId | int | 道具ID |
| propName | string | 道具名称 |
| propNum | int | 道具数量 |
| propIcon | string | 道具图标 |

## 说明

当前用户背包为空，返回空数组。
