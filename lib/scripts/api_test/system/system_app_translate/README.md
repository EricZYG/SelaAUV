# 获取翻译文案V2 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取翻译文案V2 |
| 接口路径 | `/system/app/getTranslatesV2` |
| 请求方式 | GET |
| 需要签名 | 否 |
| 说明 | 获取翻译文案版本号和JSON文件下载地址 |

## 请求头

```
Accept: */*
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
authorization: DSTEST-eyJhbGciOiJIUzUxMiJ9...
content-type: application/json; charset=utf-8
device-id: d89793035d98c48f-Xiaomi
user-agent: sela,3.0.8,android Mi Note 3,9,sela100,40
user-language: en
```

## 实际响应报文

```json
{
  "code": 0,
  "message": "Operation succeeded",
  "timestamp": 1694858983538,
  "data": {
    "version": 1694858983538,
    "url": "https://wss3.selalive.com/translate/sela100/en1694858983538.json"
  }
}
```

## 重要字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| version | int | 翻译文案版本号（时间戳），用于判断是否需要更新 |
| url | string | 翻译JSON文件的下载地址 |

## 翻译JSON文件格式

下载URL返回的JSON文件格式为**数组格式**：

```json
[
  {"configKey": "selaAccept", "configValue": "Accept"},
  {"configKey": "selaAccount", "configValue": "Account"},
  {"configKey": "login.title", "configValue": "Log in"},
  {"configKey": "home.tab.chat", "configValue": "Chat"}
]
```

JSON解析规则：
- 数组格式: `[{configKey, configValue}, ...]` → `translations[configKey] = configValue`
- 同时支持嵌套Map格式兼容（备用）
