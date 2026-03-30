/// 礼物发送结果模型
/// 
/// 送礼操作返回的结果信息
/// 
/// 字段说明:
/// - diamonds: 本次消耗钻石数
/// - balance: 剩余余额
/// - orderNo: 订单号
/// - message: 提示信息
class AuvGiftSendResultResponse {
  /// 本次消耗钻石数
  final int? diamonds;
  
  /// 剩余余额
  final int? balance;
  
  /// 订单号
  final String? orderNo;
  
  /// 提示信息
  final String? message;

  AuvGiftSendResultResponse({
    this.diamonds,
    this.balance,
    this.orderNo,
    this.message,
  });

  factory AuvGiftSendResultResponse.fromJson(Map<String, dynamic> json) {
    return AuvGiftSendResultResponse(
      diamonds: json['diamonds'],
      balance: json['balance'],
      orderNo: json['order_no'] ?? json['orderNo'],
      message: json['message'],
    );
  }
}