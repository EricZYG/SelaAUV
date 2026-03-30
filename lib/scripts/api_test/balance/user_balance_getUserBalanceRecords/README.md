# 用户钻石明细 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 用户钻石明细 |
| 接口路径 | `/user/balance/getUserBalanceRecords` |
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

### Body参数

| 参数名 | 必选 | 类型 | 说明 |
|--------|------|------|------|
| pageNum | 是 | Integer | 页码 |
| pageSize | 是 | Integer | 每页数量 |
| condition | 是 | Object | 查询条件 |

### Condition条件

| 参数名 | 必选 | 类型 | 说明 |
|--------|------|------|------|
| action | 否 | Integer | 变动类型：1.收入，2.支出 |
| startTimes | 否 | Long | 开始时间毫秒时间戳 |
| endTimes | 否 | Long | 结束时间毫秒时间戳 |
| isGame | 否 | boolean | 是否查看游戏明细 |

## 实际请求报文

```json
{
  "condition": {
    "action": 2,
    "startTimes": 1631703224215,
    "endTimes": 1631703224215
  },
  "pageNum": 1,
  "pageSize": 10
}
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774844271711,
  "data": {
    "total": -1,
    "list": [],
    "pageNum": 1,
    "pageSize": 10,
    "size": 0,
    "startRow": 0,
    "endRow": 0,
    "pages": 1,
    "prePage": 0,
    "nextPage": 0,
    "isFirstPage": true,
    "isLastPage": true,
    "hasPreviousPage": false,
    "hasNextPage": false,
    "navigatePages": 8,
    "navigatepageNums": [1],
    "navigateFirstPage": 1,
    "navigateLastPage": 1
  }
}
```

## 响应字段说明

### 分页信息

| 字段 | 类型 | 说明 |
|------|------|------|
| total | long | 总记录数（-1表示未查询） |
| pageNum | int | 当前页码 |
| pageSize | int | 每页数量 |
| size | int | 当前页记录数 |
| pages | int | 总页数 |
| isFirstPage | bool | 是否第一页 |
| isLastPage | bool | 是否最后一页 |

### 明细记录 (list)

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | long | 用户ID |
| recordType | int | 消费代码类型 |
| recordTypeStr | string | 类型描述 |
| action | int | 变动类型：1.收入，2.支出 |
| createTimes | long | 时间戳 |
| value | long | 变动值（正数表示收入，负数表示支出） |

### BalanceRecordType 消费代码参考

| code | 说明 |
|------|------|
| 101 | 游戏充值 |
| 102 | 提现 |
| 201 | 充值 |
| 301 | 视频通话 |
| 302 | 语音通话 |
| 303 | 私信消息 |
| 304 | 礼物 |
| 305 | 游戏 |
| 401 | 任务奖励 |
| 402 | 签到奖励 |
| 403 | 邀请奖励 |
| 404 | 兑换 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
