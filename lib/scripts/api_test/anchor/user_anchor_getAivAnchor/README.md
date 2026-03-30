# 获取AIV主播 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取AIV主播 |
| 接口路径 | `/user/anchor/getAivAnchor` |
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
GET /user/anchor/getAivAnchor
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842310153,
  "data": {
    "anchorUserId": 10069790,
    "videoId": 1820389273679994881,
    "videoUrl": "https://wss3.vipcallco.com/users/test/10069790/upload/0edf581c6818f2f3703799dd3acff3e0.mp4",
    "voiceFlag": 0,
    "rateFlag": 1
  }
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| anchorUserId | int | 主播用户ID |
| videoId | long | 视频ID |
| videoUrl | string | 视频URL |
| voiceFlag | int | 语音标志（0关闭，1开启） |
| rateFlag | int | 评分标志 |
