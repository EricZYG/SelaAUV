# 主播首页获取用户列表 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 主播首页获取用户列表 |
| 接口路径 | `/user/user/getUsers` |
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
| pageNum | 是 | Integer | 第几页 |
| pageSize | 是 | Integer | 每页几条 |
| condition | 是 | Object | 查询条件 |

### Condition条件

| 参数名 | 必选 | 类型 | 说明 |
|--------|------|------|------|
| countryCode | 否 | Integer | 国家编码 |

## 实际请求报文

```json
{
  "pageNum": 1,
  "pageSize": 10,
  "condition": {
    "countryCode": 840
  }
}
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": "1701054487480",
  "data": {
    "list": [
      {
        "userId": 10000389,
        "username": "10000389",
        "countryCode": 840,
        "userAuth": 0,
        "isOnline": 1,
        "disturbFlag": 0,
        "nickname": "hlkbk",
        "portrait": "https://wss3.taleshownet.com/users/common/portraits/default4.png",
        "vipEndTime": 0,
        "remainDiamonds": 0,
        "countryPath": "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/test/0/country/47962e125f11835be9b955d99cc5b495.webp",
        "countryTitle": "America",
        "countrySubCode": "US",
        "followFlag": 1,
        "likeFlag": 1,
        "likeMeCount": 0,
        "levelConfig": {
          "level": 1,
          "begin": 1,
          "end": 1,
          "avatarFrame": "https://wss3.taleshownet.com/users/common/portraits/default4.png",
          "icon": "https://wss3.taleshownet.com/users/common/portraits/default4.png"
        }
      }
    ],
    "pageNum": 1,
    "pageSize": 10,
    "total": "2",
    "hasNextPage": false
  }
}
```

## 响应字段说明

### 分页信息

| 字段 | 类型 | 说明 |
|------|------|------|
| pageNum | int | 当前页码 |
| pageSize | int | 每页数量 |
| total | string | 总记录数 |
| hasNextPage | bool | 是否有下一页 |

### 用户信息 (list)

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | long | 用户ID |
| username | string | 用于显示的UID |
| countryCode | int | 国家编码 |
| userAuth | int | 认证状态：0.男用户，1.待认证主播，2.已认证主播，3.认证失败主播，4.违规主播 |
| isOnline | int | 是否在线：0.离线，1.在线，2.忙线 |
| nickname | string | 用户昵称 |
| portrait | string | 头像URL |
| vipEndTime | long | VIP结束时间 |
| remainDiamonds | int | 剩余钻石（小数点后两位） |
| countryPath | string | 国旗链接 |
| countryTitle | string | 国家名 |
| followFlag | int | 关注状态：0.未知，1.未关注，2.已关注，3.好友 |
| likeFlag | int | 喜欢状态：0.未知，1.未喜欢，2.已喜欢 |
| likeMeCount | int | 喜欢我的数量 |
| levelConfig | object | 等级配置信息 |

### 等级配置 (levelConfig)

| 字段 | 类型 | 说明 |
|------|------|------|
| exp | long | 经验值 |
| level | int | 等级值 |
| begin | int | 最小等级值 |
| end | int | 最大等级值 |
| avatarFrame | string | 头像框URL |
| icon | string | 等级图标URL |
| userIcon | string | 用户图标 |

## 响应码说明

| code | 说明 |
|------|------|
| 0 | 操作成功 |
| 非0 | 操作失败，查看message |
