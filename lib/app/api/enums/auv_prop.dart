/// 道具类型枚举
enum AuvPropType {
  videoCard(1, '视频卡'),
  diamondBoost(2, '钻石加成卡'),
  giftCard(3, '礼物卡'),
  chatCard(4, '聊天卡'),
  matchCard(5, '匹配卡'),
  avatarFrame(6, '头像框');

  final int value;
  final String label;

  const AuvPropType(this.value, this.label);

  static AuvPropType? fromValue(int value) {
    return AuvPropType.values.where((e) => e.value == value).firstOrNull;
  }
}
