# 获取违规处罚配置 API

## 接口信息

| 项目 | 内容 |
|------|------|
| 接口名称 | 获取违规处罚配置 |
| 接口路径 | `/call/violate/getConfig` |
| 请求方式 | GET |
| 需要签名 | 是 |
| 登录要求 | 需要登录 |

## 请求参数

无

## 实际响应报文

```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1774846175444,
  "data": {
    "preFlag": 1,
    "postFlag": 1,
    "preRemind": 1,
    "postRemind": 1,
    "preDelayCount": 1,
    "postDelayCount": 1,
    "preDelaySeconds": 1,
    "postDelaySeconds": 20,
    "preTotalSeconds": 60,
    "remindCount": 1,
    "warnCount": 1,
    "banCount": 1,
    "banType": 7,
    "banMinutes": 5,
    "resetDays": 1,
    "violateCount": 0,
    "banReason": null,
    "authDelaySeconds": null,
    "cancelAuthReason": null
  }
}
```

## 响应字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| preFlag | int | 高频开关，0.关闭，1.打开 |
| postFlag | int | 低频开关，0.关闭，1.打开 |
| preRemind | int | 高频提醒开关，0.关闭，1.打开 |
| postRemind | int | 低频提醒开关，0.关闭，1.打开 |
| preDelayCount | int | 高频通话间隔数量 |
| postDelayCount | int | 低频通话间隔数量 |
| preDelaySeconds | int | 高频检测间隔秒数 |
| postDelaySeconds | int | 低频检测间隔秒数 |
| preTotalSeconds | int | 高频检测秒数 |
| remindCount | int | 提醒次数 |
| warnCount | int | 警告次数 |
| banCount | int | 封禁次数 |
| banType | int | 封禁类型 |
| banMinutes | int | 封禁分钟数 |
| resetDays | int | 违规重置天数 |
| violateCount | int | 今日违规次数 |
| banReason | string? | 封禁理由 |
| authDelaySeconds | int? | 重新认证间隔秒数 |
| cancelAuthReason | string? | 取消认证理由 |
