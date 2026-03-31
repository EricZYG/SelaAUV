/// 送礼榜单项模型
///
/// 获取送礼榜单接口返回的数据
///
/// 字段说明:
/// - gid: 礼物ID
/// - senderId: 发送方ID
/// - receiverId: 接收方ID
/// - quantity: 礼物数量
/// - diamonds: 礼物价值钻石数（小数点后两位）
/// - time: 送礼时间
/// - senderNickname: 发送方昵称
/// - receiverNickname: 接收方昵称
/// - senderPortrait: 发送方头像
/// - receiverPortrait: 接收方头像
/// - icon: 礼物图标
class AuvGiftRankItemResponse {
  /// 礼物ID
  final int? gid;

  /// 发送方ID
  final int? senderId;

  /// 接收方ID
  final int? receiverId;

  /// 礼物数量
  final int? quantity;

  /// 礼物价值钻石数（小数点后两位）
  final double? diamonds;

  /// 送礼时间
  final int? time;

  /// 发送方昵称
  final String? senderNickname;

  /// 接收方昵称
  final String? receiverNickname;

  /// 发送方头像
  final String? senderPortrait;

  /// 接收方头像
  final String? receiverPortrait;

  /// 礼物图标
  final String? icon;

  AuvGiftRankItemResponse({
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
      gid: json['gid'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      quantity: json['quantity'],
      diamonds: (json['diamonds'] as num?)?.toDouble(),
      time: json['time'],
      senderNickname: json['senderNickname'],
      receiverNickname: json['receiverNickname'],
      senderPortrait: json['senderPortrait'],
      receiverPortrait: json['receiverPortrait'],
      icon: json['icon'],
    );
  }
}
