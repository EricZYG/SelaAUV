import 'auv_user_model.dart';

/// 用户媒体信息（相册/视频）
class AuvUserMediaInfoVo {
  final int userId;
  final String value;           // 资源链接
  final String? videoCover;      // 视频封面

  AuvUserMediaInfoVo({
    required this.userId,
    required this.value,
    this.videoCover,
  });

  factory AuvUserMediaInfoVo.fromJson(Map<String, dynamic> json) {
    return AuvUserMediaInfoVo(
      userId: json['userId'] ?? 0,
      value: json['value'] ?? '',
      videoCover: json['videoCover'],
    );
  }

  /// 是否视频
  bool get isVideo => videoCover != null && videoCover!.isNotEmpty;
}

/// 主播动态媒体
class AuvMomentMediaVo {
  final int mediaId;       // 资源id
  final int mediaType;     // 资源类型，1.图片，3.视频
  final int visibleType;   // 可见范围，0.公开，1.仅付费用户
  final String mediaUrl;   // 资源链接
  final String? videoCover; // 视频封面

  AuvMomentMediaVo({
    required this.mediaId,
    required this.mediaType,
    required this.visibleType,
    required this.mediaUrl,
    this.videoCover,
  });

  factory AuvMomentMediaVo.fromJson(Map<String, dynamic> json) {
    return AuvMomentMediaVo(
      mediaId: json['mediaId'] ?? 0,
      mediaType: json['mediaType'] ?? 1,
      visibleType: json['visibleType'] ?? 0,
      mediaUrl: json['mediaUrl'] ?? '',
      videoCover: json['videoCover'],
    );
  }

  bool get isVideo => mediaType == 3;
  bool get isPublic => visibleType == 0;
  bool get isPaidOnly => visibleType == 1;
}

/// 礼物墙
class AuvGiftWallVo {
  final int gid;
  final String name;            // 礼物名称
  final int diamonds;          // 钻石价格
  final String icon;           // 图标
  final int receiveNum;         // 收到的总数
  final int sendNum;            // 送出的总数
  final int topOneUserId;       // top1用户id
  final String topOneNickname;  // top1用户昵称
  final String topOnePortrait;  // top1用户头像
  final bool topOneVipFlag;     // 是否vip
  final int currDiffNum;        // 距top1相差数量

  AuvGiftWallVo({
    required this.gid,
    required this.name,
    required this.diamonds,
    required this.icon,
    required this.receiveNum,
    required this.sendNum,
    required this.topOneUserId,
    required this.topOneNickname,
    required this.topOnePortrait,
    required this.topOneVipFlag,
    required this.currDiffNum,
  });

  factory AuvGiftWallVo.fromJson(Map<String, dynamic> json) {
    return AuvGiftWallVo(
      gid: json['gid'] ?? 0,
      name: json['name'] ?? '',
      diamonds: json['diamonds'] ?? 0,
      icon: json['icon'] ?? '',
      receiveNum: json['receiveNum'] ?? 0,
      sendNum: json['sendNum'] ?? 0,
      topOneUserId: json['topOneUserId'] ?? 0,
      topOneNickname: json['topOneNickname'] ?? '',
      topOnePortrait: json['topOnePortrait'] ?? '',
      topOneVipFlag: json['topOneVipFlag'] ?? false,
      currDiffNum: json['currDiffNum'] ?? 0,
    );
  }
}

/// 用户道具（背包）
class AuvUserPropVo {
  final int userId;        // 用户id
  final int propType;      // 道具类型，1.视频卡，2.钻石加成卡，3.礼物卡，4.聊天卡，5.匹配卡，6.头像框
  final int propValue;     // 视频卡时长(毫秒)/钻石加成/礼物id
  final int propNum;       // 数量
  final String? name;      // 礼物名称
  final String? icon;      // 礼物图标
  final String? animEffectUrl; // 礼物特效

  AuvUserPropVo({
    required this.userId,
    required this.propType,
    required this.propValue,
    required this.propNum,
    this.name,
    this.icon,
    this.animEffectUrl,
  });

  factory AuvUserPropVo.fromJson(Map<String, dynamic> json) {
    return AuvUserPropVo(
      userId: json['userId'] ?? 0,
      propType: json['propType'] ?? 1,
      propValue: json['propValue'] ?? 0,
      propNum: json['propNum'] ?? 0,
      name: json['name'],
      icon: json['icon'],
      animEffectUrl: json['animEffectUrl'],
    );
  }
}
