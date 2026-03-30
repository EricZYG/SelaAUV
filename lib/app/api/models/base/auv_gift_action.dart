/// 礼物动作模型
///
/// 获取礼物动作列表接口返回的动作数据
///
/// 字段说明:
/// - actionId: 动作ID
/// - actionName: 动作名称
class AuvGiftActionResponse {
  /// 动作ID
  final int? actionId;

  /// 动作名称
  final String? actionName;

  AuvGiftActionResponse({
    this.actionId,
    this.actionName,
  });

  factory AuvGiftActionResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvGiftActionResponse();
    return AuvGiftActionResponse(
      actionId: json['actionId'] ?? json['action_id'],
      actionName: json['actionName'] ?? json['action_name'],
    );
  }
}

/// 动作类型枚举
enum AuvGiftActionType {
  /// 1v1动作
  oneVOne(1, '1v1动作'),

  /// 直播间动作
  liveRoom(2, '直播间动作');

  final int value;
  final String label;

  const AuvGiftActionType(this.value, this.label);

  static AuvGiftActionType? fromValue(int? value) {
    if (value == null) return null;
    return AuvGiftActionType.values.where((e) => e.value == value).firstOrNull;
  }
}
