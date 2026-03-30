# 获取主播列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取主播列表 |
| 接口路径 | `/anchor/list` |
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

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| category_id | 否 | int | 分类ID |
| page | 否 | int | 页码，默认1 |
| page_size | 否 | int | 每页数量，默认20 |

## 实际请求报文

```
GET /anchor/list?page=1&page_size=10
```

## 实际响应报文

```json
{
  "timestamp": 1774842308838,
  "path": "/anchor/list",
  "status": 404,
  "error": "Not Found",
  "message": null,
  "requestId": "b9e7cf1b-7660856"
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 404 | 接口不存在或路径错误 |

## 说明

此接口返回404，可能接口路径不正确。
