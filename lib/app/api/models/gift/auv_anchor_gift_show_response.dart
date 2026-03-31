/// 主播礼物秀模型
///
/// 获取对方的礼物秀列表接口返回的数据
///
/// 字段说明:
/// - gid: 礼物ID
/// - actionId: 动作id
/// - giftName: 礼物名称
/// - giftIcon: 礼物图标
/// - animEffectUrl: 礼物特效
/// - diamonds: 钻石价格，小数点后两位
/// - coins: 金币价格，小数点后两位
/// - actionName: 动作名称
class AuvAnchorGiftShowResponse {
  /// 礼物ID
  final int? gid;

  /// 动作id
  final int? actionId;

  /// 礼物名称
  final String? giftName;

  /// 礼物图标
  final String? giftIcon;

  /// 礼物特效
  final String? animEffectUrl;

  /// 钻石价格，小数点后两位
  final int? diamonds;

  /// 金币价格，小数点后两位
  final int? coins;

  /// 动作名称
  final String? actionName;

  AuvAnchorGiftShowResponse({
    this.gid,
    this.actionId,
    this.giftName,
    this.giftIcon,
    this.animEffectUrl,
    this.diamonds,
    this.coins,
    this.actionName,
  });

  factory AuvAnchorGiftShowResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAnchorGiftShowResponse();
    return AuvAnchorGiftShowResponse(
      gid: json['gid'],
      actionId: json['actionId'],
      giftName: json['giftName'],
      giftIcon: json['giftIcon'],
      animEffectUrl: json['animEffectUrl'],
      diamonds: json['diamonds'],
      coins: json['coins'],
      actionName: json['actionName'],
    );
  }
}
