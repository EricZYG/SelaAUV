# 获取通话记录 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取通话记录 |
| 接口路径 | `/call/call/getCallRecordVoList` |
| 请求方式 | POST |
| 需要签名 | 否 |

## 请求参数

### Body参数

```json
{
  "condition": {
    "callTypes": [0, 1, 3, 4]
  },
  "pageNum": 1,
  "pageSize": 10
}
```

### 参数说明

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| condition | object | 否 | 查询条件 |
| condition.callTypes | array | 否 | 唤起方式列表 |
| condition.callType | int | 否 | 唤起方式，0.正常唤起，1.AIB唤起，2.匹配唤起，3.主播邀请，4.主播免费邀请，5.免费匹配 |
| condition.callFlag | int | 否 | 通话标志，0.未接，1.已接 |
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页条数 |

### 唤起方式说明

| 值 | 说明 |
|----|------|
| 0 | 正常唤起 |
| 1 | AIB唤起 |
| 2 | 匹配唤起 |
| 3 | 主播邀请 |
| 4 | 主播免费邀请 |
| 5 | 免费匹配 |

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
  "message": "Operation succeeded",
  "timestamp": 1700631384366,
  "data": {
    "total": 0,
    "list": [],
    "pageNum": 1,
    "pageSize": 10,
    "size": 0,
    "startRow": 0,
    "endRow": 0,
    "pages": 0,
    "prePage": 0,
    "nextPage": 0,
    "isFirstPage": true,
    "isLastPage": true,
    "hasPreviousPage": false,
    "hasNextPage": false,
    "navigatePages": 8,
    "navigatepageNums": [],
    "navigateFirstPage": 0,
    "navigateLastPage": 0
  }
}
```

## 响应字段说明

### data 对象

| 字段 | 类型 | 说明 |
|------|------|------|
| total | int | 总条数 |
| list | array | 通话记录列表 |
| pageNum | int | 当前页码 |
| pageSize | int | 每页条数 |
| pages | int | 总页数 |
| isFirstPage | bool | 是否第一页 |
| isLastPage | bool | 是否最后一页 |
| hasPreviousPage | bool | 是否有上一页 |
| hasNextPage | bool | 是否有下一页 |

### list 数组项

| 字段 | 类型 | 说明 |
|------|------|------|
| channelId | int | 频道id |
| peerUserId | int | 对方用户id |
| startAt | int | 开始计时时间 |
| endAt | int | 挂断时间，0表示未接通 |
| createdAt | int | 拨打时间 |
| callType | int | 唤起方式 |
| peerNickname | string | 对方昵称 |
| peerPortrait | string | 对方头像 |
| peerIsOnline | int | 对方是否在线 |
| channelStatus | int | 频道状态 |
| vipFlag | bool | 是否vip |
| level | int | 等级值 |

### 频道状态说明

| 值 | 说明 |
|----|------|
| 0 | 拨号中 |
| 1 | 已接通 |
| 2 | 被叫拒绝 |
| 3 | 主叫方取消 |
| 4 | 通话完成 |
| 5 | 异常结束 |
| 6 | 拨号超时 |
