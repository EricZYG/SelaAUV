/// 接口: /system/ai/getAiConfigs
/// 方法: GET
/// 状态: 成功
/// code: 0
/// message: 操作成功

/// 响应数据:
/// ```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1775465267921,
  "data": [
    {
      "configType": 1,
      "minDelay": 15,
      "typeDelay": 60,
      "idleDelay": 30,
      "idleReset": 20,
      "slideUnit": 2,
      "slideLimit": 10,
      "scanStay": 10,
      "scanDelay": 10,
      "scanLimit": 2,
      "scanReset": 30,
      "refuseUnit": 2,
      "refuseLimit": 5,
      "refuseReset": 300,
      "aivDailyLimit": 5,
      "aivTotalLimit": 15,
      "aivSwitch": 1
    },
    {
      "configType": 2,
      "minDelay": 15,
      "typeDelay": 30,
      "idleDelay": 10,
      "idleReset": 10,
      "slideUnit": 30,
      "slideLimit": 100,
      "scanStay": 10,
      "scanDelay": 15,
      "scanLimit": 2,
      "scanReset": 20,
      "refuseUnit": 20,
      "refuseLimit": 50,
      "refuseReset": 60,
      "aivDailyLimit": 2,
      "aivTotalLimit": 15,
      "aivSwitch": 0
    },
    {
      "configType": 3,
      "minDelay": 15,
      "typeDelay": 60,
      "idleDelay": 30,
      "idleReset": 20,
      "slideUnit": 2,
      "slideLimit": 2,
      "scanStay": 15,
      "scanDelay": 20,
      "scanLimit": 2,
      "scanReset": 30,
      "refuseUnit": 2,
      "refuseLimit": 8,
      "refuseReset": 300,
      "aivDailyLimit": 2,
      "aivTotalLimit": 50,
      "aivSwitch": 1
    }
  ]
}
/// ```
