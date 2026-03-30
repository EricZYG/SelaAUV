# 获取普通礼物列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取普通礼物列表 |
| 接口路径 | `/user/gift/getGiftList` |
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

无

## 实际请求报文

```
GET /user/gift/getGiftList
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1700202784130,
  "data": {
    "total": 1,
    "list": [
      {
        "gid": 1001,
        "name": "玫瑰花",
        "diamonds": 10000,
        "coins": null,
        "giftType": 1,
        "icon": null,
        "animEffectUrl": null,
        "md5": null
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
    "hasNextPage": false,
    "navigatePages": 8,
    "navigatepageNums": [1],
    "navigateFirstPage": 1,
    "navigateLastPage": 1
  }
}
```

## 响应字段说明

### data

| 字段 | 类型 | 说明 |
|------|------|------|
| total | int | 总记录数 |
| list | List | 礼物列表 |
| pageNum | int | 当前页码 |
| pageSize | int | 每页数量 |
| pages | int | 总页数 |

### list (数组元素)

| 字段 | 类型 | 说明 |
|------|------|------|
| gid | long | 礼物ID |
| name | string | 礼物名称 |
| diamonds | long | 钻石价格（小数点后两位） |
| coins | long | 金币价格（小数点后两位） |
| giftType | int | 礼物类型：1.普通礼物，2.VIP礼物 |
| icon | string | 图标URL |
| animEffectUrl | string | 特效URL |
| md5 | string | 资源MD5 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
