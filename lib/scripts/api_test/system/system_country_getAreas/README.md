# 获取地区列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取地区列表 |
| 接口路径 | `/system/country/getAreas` |
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
GET /system/country/getAreas
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1693826271387,
  "data": [
    {
      "areaCode": 1,
      "path": "",
      "title": "",
      "anchorCount": 500,
      "portraits": [
        "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/common/portraits/default4.png",
        "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/common/portraits/default4.png",
        "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/common/portraits/default4.png",
        "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/common/portraits/default4.png"
      ]
    }
  ]
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| areaCode | int | 地区编码 |
| path | string | 图片链接 |
| title | string | 地区名 |
| anchorCount | int | 主播数 |
| portraits | string[] | 主播头像列表 |
