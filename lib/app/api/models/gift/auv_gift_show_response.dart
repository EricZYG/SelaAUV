/// 礼物秀模型
///
/// 获取自己的礼物秀列表接口返回的数据
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
