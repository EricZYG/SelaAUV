# 获取订单列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取订单列表 |
| 接口路径 | `/p/order/getOrderList` |
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
| pageNum | 是 | int | 第几页 |
| pageSize | 是 | int | 每页几条 |
| condition | 否 | object | 查询条件 |

## condition条件参数

| 参数名 | 类型 | 说明 |
|--------|------|------|
| productType | int | 商品类型：1.普通，2.折扣，3.vip |
| orderStatus | int | 订单状态：0.待支付，1.已支付，2.已退款，3.已关闭 |

## 实际请求报文

```json
{
  "pageNum": 1,
  "pageSize": 10
}
```

## 实际响应报文

```json
{
  "code": 1001,
  "message": "系统错误",
  "timestamp": 1774842345606,
  "data": null
}
```

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 成功 |
| 1001 | 系统错误 |
| 1006 | 参数错误 |

## 说明

此接口返回系统错误，可能是后端处理逻辑问题。
