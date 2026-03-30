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

| 参数名 | 必选 | 类型 | 说明 |
|--------|------|------|------|
| type | 是 | int | 类型：1.充值中心，2.快捷弹窗，3.充值VIP |

## 实际请求报文

```
GET /p/product/getProducts?type=1
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774844633828,
  "data": [
    {
      "productId": 1825479644239925250,
      "productCode": "sela499",
      "price": 499,
      "diamonds": 800000,
      "bonus": 10000,
      "vipDays": 1,
      "callCardNum": 3,
      "matchCardNum": 4,
      "chatCardNum": 5,
      "productType": 2,
      "discountType": 4,
      "discount": 10,
      "productOrder": 1,
      "vipUnitPrice": 499,
      "currencyPrice": 499,
      "currencyCode": "USD",
      "splits": [
        { "splitDay": 1, "diamonds": 100000, "bonus": 0, "vipDays": 0, "callCardNum": 0, "matchCardNum": 0, "chatCardNum": 0 },
        { "splitDay": 2, "diamonds": 200000, "bonus": 0, "vipDays": 0, "callCardNum": 0, "matchCardNum": 0, "chatCardNum": 0 },
        { "splitDay": 3, "diamonds": 500000, "bonus": 0, "vipDays": 0, "callCardNum": 0, "matchCardNum": 0, "chatCardNum": 0 }
      ],
      "ppp": [
        { "ppId": 1, "ppType": 1, "ccType": null, "ccName": "Google", "uploadUsd": 0, "supportCoupon": 0, "discountFlag": 0, "ppOrder": 1, "browserOpen": 0, "currencyPrice": 499, "currencyCode": "USD" },
        { "ppId": 1972914931478720514, "ppType": 19, "ccType": "card", "ccName": "Credit Card_pdd", "uploadUsd": 0, "supportCoupon": 0, "discountFlag": 1, "ppOrder": 2, "browserOpen": 0, "currencyPrice": 499, "currencyCode": "USD" },
        { "ppId": 1980186127223963650, "ppType": 22, "ccType": "card", "ccName": "Credit Card_pdd2", "uploadUsd": 0, "supportCoupon": 0, "discountFlag": 1, "ppOrder": 2, "browserOpen": 0, "currencyPrice": 499, "currencyCode": "USD" }
      ]
    }
  ]
}
```

## 响应字段说明

### 商品信息 (data)

| 字段 | 类型 | 说明 |
|------|------|------|
| productId | long | 商品id |
| productCode | string | 商品编码 |
| price | int | 美元价格（单位：分） |
| diamonds | int | 钻石数（小数点后两位） |
| bonus | int | 赠送钻石数（小数点后两位） |
| vipDays | int | VIP天数 |
| callCardNum | int | 视频卡数量 |
| matchCardNum | int | 匹配卡数量 |
| chatCardNum | int | 聊天卡数量 |
| productType | int | 商品类型：1.普通商品，2.折扣商品，3.VIP商品 |
| discountType | int | 折扣类型：1.首充折扣，2.单次折扣，3.限时折扣，4.分次领取 |
| discount | int | 折扣（10表示优惠10%） |
| productOrder | int | 商品排序 |
| vipUnitPrice | int | VIP每天当地货币价格（单位：分） |
| currencyPrice | int | 当地货币价格（单位：分） |
| currencyCode | string | 货币编码 |
| splits | array | 分次列表 |
| ppp | array | 支付渠道列表 |

### 分次信息 (splits)

| 字段 | 类型 | 说明 |
|------|------|------|
| splitDay | int | 第几天 |
| diamonds | int | 钻石数（小数点后两位） |
| bonus | int | 赠送钻石数（小数点后两位） |
| vipDays | int | VIP天数 |
| callCardNum | int | 视频卡数量 |
| matchCardNum | int | 匹配卡数量 |
| chatCardNum | int | 聊天卡数量 |

### 支付渠道 (ppp)

| 字段 | 类型 | 说明 |
|------|------|------|
| ppId | long | 支付渠道id |
| ppType | int | 支付类型 |
| ccType | string | 支付渠道编码 |
| ccName | string | 支付渠道名称 |
| nationalFlagPath | string | 图标URL |
| uploadUsd | int | 是否上报美元价格：0.上报当地货币，1.上报美元价格 |
| supportCoupon | int | 是否支持优惠券 |
| discountFlag | int | 是否显示优惠标签：0.不显示，1.显示 |
| ppOrder | int | 支付渠道排序 |
| browserOpen | int | 是否浏览器打开支付链接：0.否，1.是 |
| currencyPrice | int | 当地货币价格（单位：分） |
| currencyCode | string | 货币编码 |
| diamonds | int | 钻石数（emma新版本才有） |
| vipDays | int | VIP天数（emma新版本才有） |
| callCardNum | int | 视频卡数量（emma新版本才有） |
| matchCardNum | int | 匹配卡数量（emma新版本才有） |
| chatCardNum | int | 聊天卡数量（emma新版本才有） |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
