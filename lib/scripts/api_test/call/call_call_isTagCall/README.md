# 通话结束是否可打标签 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 通话结束是否可打标签 |
| 接口路径 | `/call/call/isTagCall` |
| 请求方式 | POST |
| 需要签名 | 否 |

## 请求参数

### Body参数

```json
{
  "channelId": 0
}
```

### 参数说明

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| channelId | int | 是 | 通话频道id |

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

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation success",
  "timestamp": 1709551549906,
  "data": {
    "isTagCall": false,
    "tags": [
      {
        "id": "6",
        "classifyId": 1744587327010836481,
        "title": "Relationship",
        "tagValue": "yyy",
        "tagType": 1,
        "tagImg": "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/test/0/icon/cfbe14234095129e7d19b1106be4c6b9.png"
      }
    ]
  }
}
```

## 响应字段说明

### data 对象

| 字段 | 类型 | 说明 |
|------|------|------|
| isTagCall | bool | 是否可打标签 |
| tags | array | 标签列表 |

### tags 数组项

| 字段 | 类型 | 说明 |
|------|------|------|
| id | string | 标签id |
| classifyId | int | 分类id |
| title | string | 分类名 |
| tagValue | string | 标签值 |
| tagType | int | 标签类型 |
| tagImg | string | 标签图片 |
