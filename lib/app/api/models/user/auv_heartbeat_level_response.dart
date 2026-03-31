/// 心动等级相关响应模型
class AuvHeartbeatLevelGiftInfoResponse {
  final int gid;
  final String name;
  final String icon;

  AuvHeartbeatLevelGiftInfoResponse({
    required this.gid,
    required this.name,
    required this.icon,
  });

  factory AuvHeartbeatLevelGiftInfoResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatLevelGiftInfoResponse(
        gid: 0,
        name: '',
        icon: '',
      );
    }
    return AuvHeartbeatLevelGiftInfoResponse(
      gid: json['gid'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gid': gid,
      'name': name,
      'icon': icon,
    };
  }
}

/// 心动等级表情包信息
class AuvHeartbeatStickerPackageResponse {
  /// 名称
  final String name;

  /// 图标
  final String icon;

  AuvHeartbeatStickerPackageResponse({
    required this.name,
    required this.icon,
  });

  factory AuvHeartbeatStickerPackageResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatStickerPackageResponse(
        name: '',
        icon: '',
      );
    }
    return AuvHeartbeatStickerPackageResponse(
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
    };
  }
}

class AuvHeartbeatLevelPermissionResponse {
  final String permission;

  AuvHeartbeatLevelPermissionResponse({
    required this.permission,
  });

  factory AuvHeartbeatLevelPermissionResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatLevelPermissionResponse(permission: '');
    }
    return AuvHeartbeatLevelPermissionResponse(
      permission: json['permission'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permission': permission,
    };
  }
}

/// 心动等级配置项
class AuvHeartbeatLevelConfigResponse {
  final int level;
  final int begin;
  final int end;
  final String modalFrame;
  final String icon;
  final AuvHeartbeatStickerPackageResponse? stickerPackage;
  final AuvHeartbeatLevelGiftInfoResponse? giftInfo;
  final List<AuvHeartbeatLevelPermissionResponse> permissions;

  AuvHeartbeatLevelConfigResponse({
    required this.level,
    required this.begin,
    required this.end,
    required this.modalFrame,
    required this.icon,
    this.stickerPackage,
    this.giftInfo,
    required this.permissions,
  });

  factory AuvHeartbeatLevelConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatLevelConfigResponse(
        level: 0,
        begin: 0,
        end: 0,
        modalFrame: '',
        icon: '',
        stickerPackage: null,
        giftInfo: null,
        permissions: [],
      );
    }
    return AuvHeartbeatLevelConfigResponse(
      level: json['level'] as int? ?? 0,
      begin: json['begin'] as int? ?? 0,
      end: json['end'] as int? ?? 0,
      modalFrame: json['modalFrame'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      stickerPackage: json['stickerPackage'] != null
          ? AuvHeartbeatStickerPackageResponse.fromJson(json['stickerPackage'] as Map<String, dynamic>)
          : null,
      giftInfo: json['giftInfo'] != null
          ? AuvHeartbeatLevelGiftInfoResponse.fromJson(json['giftInfo'] as Map<String, dynamic>)
          : null,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => AuvHeartbeatLevelPermissionResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'begin': begin,
      'end': end,
      'modalFrame': modalFrame,
      'icon': icon,
      if (stickerPackage != null) 'stickerPackage': stickerPackage!.toJson(),
      if (giftInfo != null) 'giftInfo': giftInfo!.toJson(),
      'permissions': permissions.map((e) => e.toJson()).toList(),
    };
  }
}

/// 心动等级配置响应（不包含用户特定信息）
class AuvHeartbeatConfigResponse {
  /// 礼物比例，礼物价值钻石数/heartbeatGiftRate = 心动值
  final int heartbeatGiftRate;

  /// 等级配置列表
  final List<AuvHeartbeatLevelConfigResponse> configs;

  AuvHeartbeatConfigResponse({
    required this.heartbeatGiftRate,
    required this.configs,
  });

  factory AuvHeartbeatConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatConfigResponse(
        heartbeatGiftRate: 0,
        configs: [],
      );
    }
    return AuvHeartbeatConfigResponse(
      heartbeatGiftRate: json['heartbeatGiftRate'] as int? ?? 0,
      configs: (json['configs'] as List<dynamic>?)
              ?.map((e) => AuvHeartbeatLevelConfigResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heartbeatGiftRate': heartbeatGiftRate,
      'configs': configs.map((e) => e.toJson()).toList(),
    };
  }
}

/// 心动等级区间详情响应数据模型
class AuvHeartbeatLevelInfoDataResponse {
  /// 当前心动值（x100，客户端显示需除以100）
  final int total;

  /// 心动等级
  final int level;

  /// 是否在线
  final int isOnline;

  /// 创建时间
  final int createdAt;

  /// 礼物比例，礼物价值钻石数/heartbeatGiftRate = 心动值
  final int heartbeatGiftRate;

  /// 对方用户ID
  final int otherUserId;

  /// 对方头像
  final String otherUserAvatar;

  /// 对方昵称
  final String otherUserNickname;

  /// 等级配置列表
  final List<AuvHeartbeatLevelConfigResponse> configs;

  AuvHeartbeatLevelInfoDataResponse({
    required this.total,
    required this.level,
    required this.isOnline,
    required this.createdAt,
    required this.heartbeatGiftRate,
    required this.otherUserId,
    required this.otherUserAvatar,
    required this.otherUserNickname,
    required this.configs,
  });

  factory AuvHeartbeatLevelInfoDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatLevelInfoDataResponse(
        total: 0,
        level: 0,
        isOnline: 0,
        createdAt: 0,
        heartbeatGiftRate: 0,
        otherUserId: 0,
        otherUserAvatar: '',
        otherUserNickname: '',
        configs: [],
      );
    }
    return AuvHeartbeatLevelInfoDataResponse(
      total: json['total'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      isOnline: json['isOnline'] as int? ?? 0,
      createdAt: json['createdAt'] as int? ?? 0,
      heartbeatGiftRate: json['heartbeatGiftRate'] as int? ?? 0,
      otherUserId: json['otherUserId'] as int? ?? 0,
      otherUserAvatar: json['otherUserAvatar'] as String? ?? '',
      otherUserNickname: json['otherUserNickname'] as String? ?? '',
      configs: (json['configs'] as List<dynamic>?)
              ?.map((e) => AuvHeartbeatLevelConfigResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'level': level,
      'isOnline': isOnline,
      'createdAt': createdAt,
      'heartbeatGiftRate': heartbeatGiftRate,
      'otherUserId': otherUserId,
      'otherUserAvatar': otherUserAvatar,
      'otherUserNickname': otherUserNickname,
      'configs': configs.map((e) => e.toJson()).toList(),
    };
  }
}
