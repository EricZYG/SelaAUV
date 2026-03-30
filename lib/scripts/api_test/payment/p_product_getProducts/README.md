# 获取商品列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取商品列表 |
| 接口路径 | `/p/product/getProducts` |
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
| type | 是 | int | 商品类型：1.充值中心，2.快捷弹窗，3.充值VIP |

## 实际请求报文

```
GET /p/product/getProducts?type=1
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774842338396,
  "data": [
    {
      "productType": 1,
      "list": [
        {
          "id": 101,
          "productId": "com.sela.diamonds.60",
          "name": "60钻石",
          "price": 0.99,
          "nationalFlagPath": "https://wss3.vipcallco.com/users/test/0/pay/891a4d4f0a576e2d5369f51008ca8fdd.png",
          "uploadUsd": 0,
          "supportCoupon": 0,
          "discountFlag": 1,
          "ppOrder": 2,
          "browserOpen": 0,
          "currencyPrice": 799,
          "currencyCode": "USD",
          "diamonds": 0,
          "vipDays": 0,
          "callCardNum": 0,
          "matchCardNum": 0,
          "chatCardNum": 0
        }
      ]
    }
  ]
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| productType | int | 商品类型 |
| list | array | 商品列表 |

### list商品字段

| 字段 | 类型 | 说明 |
|------|------|------|
| id | int | 商品ID |
| productId | string | 商品标识 |
| name | string | 商品名称 |
| price | double | 价格 |
| nationalFlagPath | string | 国旗图标 |
| currencyPrice | int | 本地货币价格（分） |
| currencyCode | string | 货币代码 |
| discountFlag | int | 折扣标志 |
| diamonds | int | 赠送钻石数 |
| vipDays | int | VIP天数 |
| callCardNum | int | 通话卡数量 |
| matchCardNum | int | 匹配卡数量 |
| chatCardNum | int | 聊天卡数量 |
