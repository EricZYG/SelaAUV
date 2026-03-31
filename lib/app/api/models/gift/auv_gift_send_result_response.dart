/// 礼物发送结果模型
/// 
/// 送礼操作返回的结果信息
/// 
/// 字段说明:
/// - gid: 礼物id
/// - deposit: 剩余钻石
/// - becomeTopOne: 是否从非top1变成了top1
class AuvGiftSendResultResponse {
  /// 礼物id
  final int? gid;

  /// 剩余钻石
  final int? deposit;

  /// 是否从非top1变成了top1
  final int? becomeTopOne;

  AuvGiftSendResultResponse({
    this.gid,
    this.deposit,
    this.becomeTopOne,
  });

  factory AuvGiftSendResultResponse.fromJson(Map<String, dynamic> json) {
    return AuvGiftSendResultResponse(
      gid: json['gid'],
      deposit: json['deposit'],
      becomeTopOne: json['becomeTopOne'],
    );
  }
}