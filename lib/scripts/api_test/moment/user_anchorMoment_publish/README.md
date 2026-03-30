# 发布动态 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 发布动态 |
| 接口路径 | `/user/anchorMoment/publish` |
| 请求方式 | POST |
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
| content | 否 | string | 文字内容 |
| medias | 否 | list | 动态资源列表 |
| visibleType | 否 | int | 可见范围：0公开，1仅付费用户 |
| autoSend | 否 | bool | 是否自动发送 |

## 实际请求报文

```json
{
  "content": "这是一条测试动态",
  "visibleType": 0,
  "autoSend": true
}
```

## 实际响应报文

```json
{
  "code": 1006,
  "message": "参数错误",
  "timestamp": 1774842328600,
  "data": null
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1006 | 参数错误 |

## 说明

此接口返回参数错误，可能是缺少必要参数或参数格式不正确。
