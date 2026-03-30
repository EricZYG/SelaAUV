# 获取礼物动作列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取礼物动作列表 |
| 接口路径 | `/user/gift/getActions` |
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

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| type | int | 否 | 动作类型：1.1v1动作，2.直播间动作，不传默认为1 |

## 实际请求报文

```
GET /user/gift/getActions?type=1
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1700202784130,
  "data": [
    {
      "actionId": 1001,
      "actionName": "sing a song"
    }
  ]
}
```

## 响应字段说明

### data (数组)

| 字段 | 类型 | 说明 |
|------|------|------|
| actionId | long | 动作ID |
| actionName | string | 动作名称 |

## 动作类型说明

| type | 说明 |
|------|------|
| 1 | 1v1动作 |
| 2 | 直播间动作 |
| 不传 | 默认为1 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
