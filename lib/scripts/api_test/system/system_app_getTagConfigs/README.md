# 获取标签配置 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取标签配置 |
| 接口路径 | `/system/app/getTagConfigs` |
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
GET /system/app/getTagConfigs
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1700461429998,
  "data": [
    {
      "title": "123",
      "tags": [
        {
          "classifyId": 1,
          "title": "123",
          "tagValue": "123"
        }
      ]
    }
  ]
}
```

## 响应字段说明

### 外层对象

| 字段 | 类型 | 说明 |
|------|------|------|
| title | string | 分类名 |
| tags | array | 标签列表 |

### tags 数组项

| 字段 | 类型 | 说明 |
|------|------|------|
| classifyId | int | 分类id |
| title | string | 分类名 |
| tagValue | string | 标签 |
