# 获取敏感词库V2 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取敏感词库V2 |
| 接口路径 | `/system/sensitive/getSensitiveWordsV2` |
| 请求方式 | GET |
| 需要签名 | 否 |

## 请求参数

无

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
GET /system/sensitive/getSensitiveWordsV2
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1702025053438,
  "data": [
    {
      "id": 1,
      "type": 1,
      "mode": 1,
      "words": "232323",
      "wordsStop": "232323"
    }
  ]
}
```

## 响应字段说明

### data 数组项

| 字段 | 类型 | 说明 |
|------|------|------|
| id | int | 敏感词id |
| type | int | 敏感词类型，1.不能发送(引流词)，2.脱敏发送(私聊敏感词)，3.不能发送并提示(公聊敏感词) |
| mode | int | 敏感词模式，1.单个词，2.范围 |
| words | string | 敏感词/开始范围敏感词 |
| wordsStop | string | 结束范围敏感词 |

### 敏感词类型说明

| type值 | 说明 |
|--------|------|
| 1 | 不能发送（引流词） |
| 2 | 脱敏发送（私聊敏感词） |
| 3 | 不能发送并提示（公聊敏感词） |

### 敏感词模式说明

| mode值 | 说明 |
|--------|------|
| 1 | 单个词 |
| 2 | 范围 |
