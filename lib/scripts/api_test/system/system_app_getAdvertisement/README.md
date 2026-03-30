# 获取广告列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取广告列表 |
| 接口路径 | `/system/app/getAdvertisement` |
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
GET /system/app/getAdvertisement
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation success",
  "timestamp": 1709117190059,
  "data": {
    "list": [
      {
        "id": 3,
        "appChannel": "sela100",
        "countryCode": 840,
        "jumpUrl": "https://www.baidu.com",
        "img": "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/test/awss3/manage/upload/9c0e0a5e3b4032296937aa46bfa3a71b.png",
        "sort": 3,
        "createdAt": 0
      },
      {
        "id": 2,
        "appChannel": "sela100",
        "countryCode": 840,
        "jumpUrl": "https://www.baidu.com",
        "img": "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/test/awss3/manage/upload/9c0e0a5e3b4032296937aa46bfa3a71b.png",
        "sort": 2,
        "createdAt": 0
      },
      {
        "id": 1,
        "appChannel": "sela100",
        "countryCode": 840,
        "jumpUrl": "https://www.baidu.com",
        "img": "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/test/awss3/manage/upload/9c0e0a5e3b4032296937aa46bfa3a71b.png",
        "sort": 1,
        "createdAt": 0
      }
    ]
  }
}
```

## 响应字段说明

### data 对象

| 字段 | 类型 | 说明 |
|------|------|------|
| list | array | 广告列表 |

### list 数组项

| 字段 | 类型 | 说明 |
|------|------|------|
| id | int | 广告id |
| appChannel | string | 应用渠道 |
| countryCode | int | 国家编码 |
| jumpUrl | string | 跳转链接 |
| img | string | 广告图片 |
| sort | int | 排序 |
| createdAt | int | 创建时间 |
