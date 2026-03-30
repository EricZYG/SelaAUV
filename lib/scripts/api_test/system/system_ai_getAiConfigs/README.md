# 获取AI配置 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取AI配置 |
| 接口路径 | `/system/ai/getAiConfigs` |
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

## 实际请求报文

```
GET /system/ai/getAiConfigs
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1700632391285,
  "data": [
    {
      "configType": 1,
      "minDelay": 1,
      "typeDelay": 1,
      "idleDelay": 1,
      "idleReset": 1,
      "slideUnit": 1,
      "slideLimit": 1,
      "scanStay": 1,
      "scanDelay": 1,
      "scanLimit": 1,
      "scanReset": 1,
      "refuseUnit": 1,
      "refuseLimit": 1,
      "refuseReset": 1,
      "aivDailyLimit": 1,
      "aivTotalLimit": 1,
      "aivSwitch": 1
    }
  ]
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| configType | int | 类型，1.未付费用户，2.付费有接听能力，3.付费无接听能力 |
| minDelay | int | AI最小间隔，秒数 |
| typeDelay | int | 类型变更后首次aib间隔，秒数 |
| idleDelay | int | 无操作触发aib：aib间隔，秒数 |
| idleReset | int | 无操作触发aib：重新触发条件，秒数 |
| slideUnit | int | 滑动列表触发aib：滑动列表次数 |
| slideLimit | int | 滑动列表触发aib：当日次数 |
| scanStay | int | 连续看主播触发aib：停留时间，秒数 |
| scanDelay | int | 连续看主播触发aib：aib触发时间，秒数 |
| scanLimit | int | 连续看主播触发aib：进入主页次数 |
| scanReset | int | 连续看主播触发aib：重新触发条件，秒数 |
| refuseUnit | int | 挂断屏蔽aib：连续挂断次数 |
| refuseLimit | int | 挂断屏蔽aib：总挂断次数 |
| refuseReset | int | 挂断屏蔽aib：屏蔽时间，秒数 |
| aivDailyLimit | int | 每天触发aiv次数 |
| aivTotalLimit | int | 累计触发aiv次数 |
| aivSwitch | int | aiv开关，0.关闭，1.开启 |
