/// 应用配置 - 礼包奖励模型
///
/// 新手礼包 / 绑定谷歌礼包 / Web引导下载礼包 共用此模型
///
/// 字段说明:
/// - callCardNum: 视频卡数量
/// - matchCardNum: 匹配卡数量
/// - chatCardNum: 聊天卡数量
/// - diamonds: 钻石数，小数点后两位
class AuvAppConfigRewardResponse {
  /// 视频卡数量
  final int? callCardNum;

  /// 匹配卡数量
  final int? matchCardNum;

  /// 聊天卡数量
  final int? chatCardNum;

  /// 钻石数，小数点后两位
  final double? diamonds;

  AuvAppConfigRewardResponse({
    this.callCardNum,
    this.matchCardNum,
    this.chatCardNum,
    this.diamonds,
  });

  factory AuvAppConfigRewardResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAppConfigRewardResponse();
    return AuvAppConfigRewardResponse(
      callCardNum: json['callCardNum'],
      matchCardNum: json['matchCardNum'],
      chatCardNum: json['chatCardNum'],
      diamonds: _parseDouble(json['diamonds']),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}