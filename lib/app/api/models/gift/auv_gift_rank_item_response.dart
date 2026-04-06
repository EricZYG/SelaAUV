/// 送礼榜单项模型
///
/// 获取送礼榜单接口返回的数据
class AuvGiftRankItemResponse {
  /// 【遗漏】送礼记录ID
  final int? recordId;

  /// 礼物ID
  final int? gid;

  /// 发送方ID
  final int? senderId;

  /// 接收方ID
  final int? receiverId;

  /// 礼物数量
  final int? quantity;

  /// 礼物价值钻石数（小数点后两位）
  final int? diamonds;

  /// 送礼时间
  final int? time;

  /// 【遗漏】发送方昵称
  final String? senderNickname;

  /// 【遗漏】接收方昵称
  final String? receiverNickname;

  /// 【遗漏】发送方头像
  final String? senderPortrait;

  /// 【遗漏】接收方头像
  final String? receiverPortrait;

  /// 礼物图标
  final String? icon;

  AuvGiftRankItemResponse({
    this.recordId,
    this.gid,
    this.senderId,
    this.receiverId,
    this.quantity,
    this.diamonds,
    this.time,
    this.senderNickname,
    this.receiverNickname,
    this.senderPortrait,
    this.receiverPortrait,
    this.icon,
  });

  factory AuvGiftRankItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvGiftRankItemResponse();
    return AuvGiftRankItemResponse(
      recordId: json['recordId'],
      gid: json['gid'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      quantity: json['quantity'],
      diamonds: json['diamonds'],
      time: json['time'],
      senderNickname: json['senderNickname'],
      receiverNickname: json['receiverNickname'],
      senderPortrait: json['senderPortrait'],
      receiverPortrait: json['receiverPortrait'],
      icon: json['icon'],
    );
  }

  /// 获取送礼时间
  DateTime? get giftTime {
    if (time == null || time == 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(time!);
  }
}
