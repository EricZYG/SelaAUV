/// 接口: /system/bank/getPayoutChannels
library;

// API response data

/// 方法: GET
/// 状态: 成功
/// code: 0
/// message: 操作成功

/// 响应数据:
/// ```json
{
  "code": 0,
  "message": "操作成功",
  "timestamp": 1775465268656,
  "data": [
    {
      "payId": 1740299275442601985,
      "payoutType": 1,
      "channelType": "BankTransfer",
      "channelName": "BankTransfer",
      "nationalFlagPath": "https://wss3.vipcallco.com/users/test/0/payout/3c98422f95225d4032919b8e6684c1bf.png"
    },
    {
      "payId": 1959931541792161794,
      "payoutType": 3,
      "channelType": "Tron",
      "channelName": "USDT-Tron",
      "nationalFlagPath": "https://wss3.vipcallco.com/users/test/0/payout/66b0359b0a7eaa487b22e1729504e3bb.png"
    },
    {
      "payId": 1800500783786024962,
      "payoutType": 2,
      "channelType": "USDT",
      "channelName": "USDT",
      "nationalFlagPath": "https://wss3.vipcallco.com/users/test/0/payout/376e14a5eae2386b2ed27fdc1aae07c6.jpeg"
    }
  ]
}
/// ```
