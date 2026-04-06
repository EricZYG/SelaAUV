/// 签到奖励类型枚举
/// 
/// 对应后台 SigInRewardType
enum AuvSignInRewardType {
  /// 钻石
  diamond(1),

  /// 视频卡
  callCard(2),

  /// 匹配卡
  matchCard(3),

  /// 聊天卡
  chatCard(4);

  final int value;
  const AuvSignInRewardType(this.value);

  static AuvSignInRewardType? fromValue(int value) {
    return AuvSignInRewardType.values.where((e) => e.value == value).firstOrNull;
  }

  /// 类型描述
  String get desc {
    switch (this) {
      case AuvSignInRewardType.diamond:
        return '钻石';
      case AuvSignInRewardType.callCard:
        return '视频卡';
      case AuvSignInRewardType.matchCard:
        return '匹配卡';
      case AuvSignInRewardType.chatCard:
        return '聊天卡';
    }
  }
}
