# 赠送真实礼物 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 赠送真实礼物 |
| 接口路径 | `/user/gift/sendReal` |
| 请求方式 | POST |
| 需要签名 | 是 |

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
s-time: {timestamp}
s-sign: {signature}
```

## 请求参数

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| gift_id | 是 | string | 礼物ID |
| anchor_id | 是 | string | 主播ID |
| room_id | 是 | string | 直播间ID |
| num | 是 | int | 数量 |

## 签名规则

1. 将请求参数按照参数名ASCII码从小到大排序
2. 使用URL键值对格式拼接成字符串
3. 在末尾拼接 `time` 和 `key`（key从getAppConfig接口获取）
4. 对结果进行MD5运算，转小写得到sign

## 实际请求报文

```json
{
  "gift_id": "1001",
  "anchor_id": "12345",
  "room_id": "room001",
  "num": 1
}
```

## 实际响应报文

```json
{
  "code": 1006,
  "message": "参数错误",
  "timestamp": 1774842367562,
  "data": null
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1006 | 参数错误 |
| 1008 | 余额不足 |
| 1012 | 礼物不存在 |
| 1013 | 主播不存在 |

## 说明

此接口返回参数错误，可能是礼物ID、主播ID或房间ID不存在。
