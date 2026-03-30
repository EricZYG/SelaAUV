# 获取Banner列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取Banner列表 |
| 接口路径 | `/system/banner/getBanners` |
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
GET /system/banner/getBanners
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842329950,
  "data": [
    {
      "title": "test",
      "cover": "https://wss3.vipcallco.com/users/test/0/banner/9c853dc5eec420e4d4f06c0238cff326.png",
      "coverType": 0,
      "target": -1,
      "link": "",
      "sort": 1
    }
  ]
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| title | string | Banner标题 |
| cover | string | Banner封面图URL |
| coverType | int | 封面类型 |
| target | int | 跳转目标 |
| link | string | 跳转链接 |
| sort | int | 排序 |
