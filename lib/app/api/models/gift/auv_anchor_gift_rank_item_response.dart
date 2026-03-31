/// 主播礼物榜单项模型
///
/// 客户端获取主播礼物榜单接口返回的数据
///
/// 字段说明:
/// - gid: 礼物ID
/// - icon: 礼物图标
/// - quantity: 礼物数量
/// - userId: 用户id
/// - nickname: 用户昵称
/// - portrait: 用户头像
/// - vipFlag: 是否vip
/// - level: 用户等级
class AuvAnchorGiftRankItemResponse {
  /// 礼物ID
  final int? gid;

  /// 礼物图标
  final String? icon;

  /// 礼物数量
  final int? quantity;

  /// 用户id
  final int? userId;

  /// 用户昵称
  final String? nickname;

  /// 用户头像
  final String? portrait;

  /// 是否vip
  final bool? vipFlag;

  /// 用户等级
  final int? level;

  AuvAnchorGiftRankItemResponse({
    this.gid,
    this.icon,
    this.quantity,
    this.userId,
    this.nickname,
    this.portrait,
    this.vipFlag,
    this.level,
  });

  factory AuvAnchorGiftRankItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAnchorGiftRankItemResponse();
    return AuvAnchorGiftRankItemResponse(
      gid: json['gid'],
      icon: json['icon'],
      quantity: json['quantity'],
      userId: json['userId'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      vipFlag: json['vipFlag'],
      level: json['level'],
    );
  }
}
