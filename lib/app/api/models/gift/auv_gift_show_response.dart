/// 礼物秀模型
///
/// 获取自己的礼物秀列表接口返回的数据
///
/// 字段说明:
/// - showId: 主键id
/// - gid: 礼物ID
/// - actionId: 动作id
/// - giftName: 礼物名称
/// - giftIcon: 礼物图标
/// - actionName: 动作名称
class AuvGiftShowResponse {
  /// 主键id
  final int? showId;

  /// 礼物ID
  final int? gid;

  /// 动作id
  final int? actionId;

  /// 礼物名称
  final String? giftName;

  /// 礼物图标
  final String? giftIcon;

  /// 动作名称
  final String? actionName;

  AuvGiftShowResponse({
    this.showId,
    this.gid,
    this.actionId,
    this.giftName,
    this.giftIcon,
    this.actionName,
  });

  factory AuvGiftShowResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvGiftShowResponse();
    return AuvGiftShowResponse(
      showId: json['showId'],
      gid: json['gid'],
      actionId: json['actionId'],
      giftName: json['giftName'],
      giftIcon: json['giftIcon'],
      actionName: json['actionName'],
    );
  }
}

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
