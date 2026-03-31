/// 等级配置模型
class AuvLevelConfigResponse {
  /// 等级值
  final int? level;

  /// 等级起始值
  final int? begin;

  /// 等级结束值
  final int? end;

  /// 等级头像框
  final String? avatarFrame;

  /// 等级图标
  final String? icon;

  AuvLevelConfigResponse({
    this.level,
    this.begin,
    this.end,
    this.avatarFrame,
    this.icon,
  });

  factory AuvLevelConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvLevelConfigResponse();
    return AuvLevelConfigResponse(
      level: json['level'],
      begin: json['begin'],
      end: json['end'],
      avatarFrame: json['avatarFrame'] ?? json['avatar_frame'],
      icon: json['icon'],
    );
  }
}
