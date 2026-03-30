# 用户端查主播动态 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 用户端查主播动态 |
| 接口路径 | `/user/anchorMoment/userGetMoment` |
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
| pageNum | 是 | int | 页码 |
| pageSize | 是 | int | 每页条数 |
| condition | 否 | object | 查询条件 |

## condition条件参数

| 参数名 | 类型 | 说明 |
|--------|------|------|
| type | int | 1.hot, 2.new, 3.follow |

## 实际请求报文

```json
{
  "pageNum": 1,
  "pageSize": 10,
  "condition": {
    "type": 1
  }
}
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842329950,
  "data": {
    "total": 1,
    "list": [
      {
        "id": 9,
        "userId": 10000010,
        "anchorId": 10000010,
        "anchorNickname": "testA",
        "content": "test",
        "visibleType": 0,
        "likeCount": 0,
        "commentCount": 0,
        "forwardCount": 0,
        "medias": [],
        "createTime": 1774510071720,
        "likeFlag": 0,
        "scaleType": 1,
        "autoSend": false,
        "status": 1
      }
    ],
    "pageNum": 1,
    "pageSize": 10,
    "size": 1,
    "startRow": 1,
    "endRow": 1,
    "pages": 1,
    "prePage": 0,
    "nextPage": 0,
    "isFirstPage": true,
    "isLastPage": true,
    "hasPreviousPage": false,
    "hasNextPage": true,
    "navigatePages": 8,
    "navigatepageNums": [1],
    "navigateFirstPage": 1,
    "navigateLastPage": 1
  }
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| total | int | 总记录数 |
| list | array | 动态列表 |
| pageNum | int | 当前页码 |
| pageSize | int | 每页条数 |
| pages | int | 总页数 |

### list动态字段

| 字段 | 类型 | 说明 |
|------|------|------|
| id | int | 动态ID |
| userId | int | 用户ID |
| anchorId | int | 主播ID |
| anchorNickname | string | 主播昵称 |
| content | string | 动态内容 |
| visibleType | int | 可见范围（0公开，1仅付费用户） |
| likeCount | int | 点赞数 |
| commentCount | int | 评论数 |
| forwardCount | int | 转发数 |
| medias | array | 媒体资源列表 |
| createTime | long | 创建时间戳 |
| likeFlag | int | 是否已点赞 |
| scaleType | int | 比例类型 |
| autoSend | bool | 是否自动发送 |
| status | int | 状态 |
