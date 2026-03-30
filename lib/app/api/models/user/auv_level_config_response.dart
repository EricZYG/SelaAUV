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

/// 等级区间配置模型
class AuvLevelInfoConfigResponse {
  /// 等级配置ID
  final int? id;

  /// 等级标题
  final String? title;

  /// 等级数值
  final int? level;

  /// >=等级值起始
  final int? begin;

  /// <等级结束值
  final int? end;

  /// 头像框
  final String? avatarFrame;

  /// 等级图标
  final String? icon;

  /// 用户图标(主播端配置)
  final String? userIcon;

  /// 用户类型
  final int? userType;

  /// 创建时间
  final int? createdAt;

  AuvLevelInfoConfigResponse({
    this.id,
    this.title,
    this.level,
    this.begin,
    this.end,
    this.avatarFrame,
    this.icon,
    this.userIcon,
    this.userType,
    this.createdAt,
  });

  factory AuvLevelInfoConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvLevelInfoConfigResponse();
    return AuvLevelInfoConfigResponse(
      id: json['id'],
      title: json['title'],
      level: json['level'],
      begin: json['begin'],
      end: json['end'],
      avatarFrame: json['avatarFrame'] ?? json['avatar_frame'],
      icon: json['icon'],
      userIcon: json['userIcon'] ?? json['user_icon'],
      userType: json['userType'],
      createdAt: json['createdAt'],
    );
  }
}

/// 等级区间详情响应数据模型
class AuvLevelInfoDataResponse {
  /// 等级配置列表
  final List<AuvLevelInfoConfigResponse>? configs;

  /// 当前总经验值
  final int? total;

  AuvLevelInfoDataResponse({
    this.configs,
    this.total,
  });

  factory AuvLevelInfoDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvLevelInfoDataResponse();
    return AuvLevelInfoDataResponse(
      configs: (json['configs'] as List<dynamic>?)
          ?.map((e) => AuvLevelInfoConfigResponse.fromJson(e))
          .toList(),
      total: json['total'],
    );
  }
}