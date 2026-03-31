/// 礼物秀类型枚举
enum AuvGiftShowType {
  /// 1v1动作
  oneVOne(1, '1v1动作'),

  /// 直播间动作
  liveRoom(2, '直播间动作');

  final int value;
  final String label;

  const AuvGiftShowType(this.value, this.label);

  static AuvGiftShowType? fromValue(int? value) {
    if (value == null) return null;
    return AuvGiftShowType.values.where((e) => e.value == value).firstOrNull;
  }
}
