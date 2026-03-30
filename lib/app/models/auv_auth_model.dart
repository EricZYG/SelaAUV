/// 登录请求模型
class AuvLoginRequest {
  final String email;
  final String password;

  AuvLoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

/// 登录响应模型
class AuvLoginResponse {
  final String token;
  final String refreshToken;
  final AuvUserModel user;
  
  /// 以下字段用于游客登录
  final String? userId;
  final String? username;
  final String? appChannel;
  final int? deregisterFlag;
  final int? deregisterTime;
  final String? authorization;

  AuvLoginResponse({
    required this.token,
    required this.refreshToken,
    required this.user,
    this.userId,
    this.username,
    this.appChannel,
    this.deregisterFlag,
    this.deregisterTime,
    this.authorization,
  });

  factory AuvLoginResponse.fromJson(Map<String, dynamic> json) {
    return AuvLoginResponse(
      token: json['token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      user: AuvUserModel.fromJson(json['user'] ?? {}),
      userId: json['userId']?.toString() ?? json['user_id']?.toString(),
      username: json['username'],
      appChannel: json['appChannel'],
      deregisterFlag: json['deregisterFlag'],
      deregisterTime: json['deregisterTime'],
      authorization: json['authorization'],
    );
  }
}

/// Google 登录请求模型
class AuvGoogleLoginRequest {
  final String idToken;
  final String? email;
  final String? name;

  AuvGoogleLoginRequest({
    required this.idToken,
    this.email,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_token': idToken,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
    };
  }
}

/// 游客登录请求模型 (新版)
/// 
/// 用于 /user/login/guest 接口
class AuvGuestLoginRequest {
  /// 加密后的密码（必填）
  final String password;
  
  /// 是否限制广告id获取，0.未限制，1.限制获取（可选）
  final int? aidLimit;
  
  /// 广告id（可选）
  final String? aid;
  
  /// 是否使用了vpn，0.未使用，1.使用了（可选）
  final int? useVpn;

  AuvGuestLoginRequest({
    required this.password,
    this.aidLimit,
    this.aid,
    this.useVpn,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      if (aidLimit != null) 'aidLimit': aidLimit,
      if (aid != null) 'aid': aid,
      if (useVpn != null) 'useVpn': useVpn,
    };
  }
}

/// 游客登录请求模型 (旧版，兼容)
/// 
/// 用于 /auth/visitor 接口
class AuvVisitorLoginRequest {
  final String deviceId;

  AuvVisitorLoginRequest({required this.deviceId});

  Map<String, dynamic> toJson() {
    return {'device_id': deviceId};
  }
}

/// 广告归因模型
class AuvAdFlagModel {
  final String network;         // 归因渠道名称（必填）
  final String? campaign;        // 推广活动名称
  final String? clickLabel;      // 安装被标记的点击标签
  final String? trackerToken;    // 设备当前归因跟踪链接的跟踪码
  final String? trackerName;     // 设备当前归因跟踪链接的名称
  final String? adgroup;         // 设备当前归因广告组的名称
  final String? creative;        // 设备当前归因素材的名称
  final String? adid;            // 设备的唯一 Adjust ID
  final String? costType;        // 推广活动定价模型 (如 cpi)
  final String? costAmount;      // 安装成本
  final String? costCurrency;    // 成本相关的货币代码

  AuvAdFlagModel({
    required this.network,
    this.campaign,
    this.clickLabel,
    this.trackerToken,
    this.trackerName,
    this.adgroup,
    this.creative,
    this.adid,
    this.costType,
    this.costAmount,
    this.costCurrency,
  });

  Map<String, dynamic> toJson() {
    return {
      'network': network,
      if (campaign != null) 'campaign': campaign,
      if (clickLabel != null) 'clickLabel': clickLabel,
      if (trackerToken != null) 'trackerToken': trackerToken,
      if (trackerName != null) 'trackerName': trackerName,
      if (adgroup != null) 'adgroup': adgroup,
      if (creative != null) 'creative': creative,
      if (adid != null) 'adid': adid,
      if (costType != null) 'costType': costType,
      if (costAmount != null) 'costAmount': costAmount,
      if (costCurrency != null) 'costCurrency': costCurrency,
    };
  }
}

/// 用户信息模型
class AuvUserModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final int coins;
  final bool isVip;
  final DateTime? vipExpireTime;
  final DateTime createdAt;

  AuvUserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.coins,
    required this.isVip,
    this.vipExpireTime,
    required this.createdAt,
  });

  factory AuvUserModel.fromJson(Map<String, dynamic> json) {
    return AuvUserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      coins: json['coins'] ?? 0,
      isVip: json['is_vip'] ?? false,
      vipExpireTime: json['vip_expire_time'] != null
          ? DateTime.parse(json['vip_expire_time'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'coins': coins,
      'is_vip': isVip,
      'vip_expire_time': vipExpireTime?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
