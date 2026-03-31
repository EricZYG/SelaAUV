/// 高级用户奖励信息模型
///
/// 获取高级用户弹窗接口返回的奖励信息
///
/// 字段说明:
/// - diamondNum: 钻石数量
/// - callCardNum: 通话卡数量
/// - matchCardNum: 匹配卡数量
/// - chatCardNum: 聊天卡数量
/// - couponNum: 优惠券数量
/// - goldNum: 金币数量
/// - dollarNum: 美元数量
class AuvAdvanceRewardVoResponse {
  /// 钻石数量
  final int? diamondNum;

  /// 通话卡数量
  final int? callCardNum;

  /// 匹配卡数量
  final int? matchCardNum;

  /// 聊天卡数量
  final int? chatCardNum;

  /// 优惠券数量
  final int? couponNum;

  /// 金币数量
  final int? goldNum;

  /// 美元数量
  final int? dollarNum;

  AuvAdvanceRewardVoResponse({
    this.diamondNum,
    this.callCardNum,
    this.matchCardNum,
    this.chatCardNum,
    this.couponNum,
    this.goldNum,
    this.dollarNum,
  });

  factory AuvAdvanceRewardVoResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAdvanceRewardVoResponse();
    return AuvAdvanceRewardVoResponse(
      diamondNum: json['diamondNum'],
      callCardNum: json['callCardNum'],
      matchCardNum: json['matchCardNum'],
      chatCardNum: json['chatCardNum'],
      couponNum: json['couponNum'],
      goldNum: json['goldNum'],
      dollarNum: json['dollarNum'],
    );
  }

  /// 是否有钻石奖励
  bool get hasDiamond => (diamondNum ?? 0) > 0;

  /// 是否有通话卡奖励
  bool get hasCallCard => (callCardNum ?? 0) > 0;

  /// 是否有匹配卡奖励
  bool get hasMatchCard => (matchCardNum ?? 0) > 0;

  /// 是否有聊天卡奖励
  bool get hasChatCard => (chatCardNum ?? 0) > 0;

  /// 是否有奖励
  bool get hasRewards =>
      hasDiamond || hasCallCard || hasMatchCard || hasChatCard;
}
