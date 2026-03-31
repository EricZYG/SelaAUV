/// 用户等级配置
class AuvUserLevelConfig {
  final int? id;
  final String? title;
  final int? exp;
  final int level;
  final int begin;
  final int end;
  final String? avatarFrame;  // 等级头像框
  final String? icon;          // 等级icon
  final String? userIcon;     // 用户头像框
  final int userType;
  final int createdAt;

  AuvUserLevelConfig({
    this.id,
    this.title,
    this.exp,
    required this.level,
    required this.begin,
    required this.end,
    this.avatarFrame,
    this.icon,
    this.userIcon,
    this.userType = 0,
    this.createdAt = 0,
  });

  factory AuvUserLevelConfig.fromJson(Map<String, dynamic> json) {
    return AuvUserLevelConfig(
      id: json['id'],
      title: json['title'],
      exp: json['exp'],
      level: json['level'] ?? 0,
      begin: json['begin'] ?? 0,
      end: json['end'] ?? 0,
      avatarFrame: json['avatarFrame'] ?? json['avatar_frame'],
      icon: json['icon'],
      userIcon: json['userIcon'],
      userType: json['userType'] ?? 0,
      createdAt: json['createdAt'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (exp != null) 'exp': exp,
      'level': level,
      'begin': begin,
      'end': end,
      if (avatarFrame != null) 'avatarFrame': avatarFrame,
      if (icon != null) 'icon': icon,
      if (userIcon != null) 'userIcon': userIcon,
      'userType': userType,
      'createdAt': createdAt,
    };
  }
}

/// 对方简要信息模型
class AuvUserSimpleModel {
  final int userId;
  final String username;       // 用于显示的UID
  final String nickname;      // 用户昵称
  final String srcNickname;   // 原昵称
  final String portrait;      // 头像
  final int isOnline;         // 是否在线，0.离线，1.在线，2.忙线
  final int vipEndTime;       // VIP结束时间
  final AuvUserLevelConfig? levelConfig;  // 等级信息
  final int totalRecharge;    // 总充值额（分）
  final int isAdvanceUser;     // 是否高级用户 0 否 1 是
  final int sendMsgPrice;     // 发消息扣除钻石数（小数点后两位）
  final bool sendMsgFlag;     // 发消息是否免费
  final int followFlag;       // 关注状态 0.未关注 1.对方已回关 2.已关注 3.好友

  AuvUserSimpleModel({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.srcNickname,
    required this.portrait,
    required this.isOnline,
    required this.vipEndTime,
    this.levelConfig,
    required this.totalRecharge,
    required this.isAdvanceUser,
    required this.sendMsgPrice,
    required this.sendMsgFlag,
    required this.followFlag,
  });

  factory AuvUserSimpleModel.fromJson(Map<String, dynamic> json) {
    return AuvUserSimpleModel(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      srcNickname: json['srcNickname'] ?? '',
      portrait: json['portrait'] ?? '',
      isOnline: json['isOnline'] ?? 0,
      vipEndTime: json['vipEndTime'] ?? 0,
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      totalRecharge: json['totalRecharge'] ?? 0,
      isAdvanceUser: json['isAdvanceUser'] ?? 0,
      sendMsgPrice: json['sendMsgPrice'] ?? 0,
      sendMsgFlag: json['sendMsgFlag'] ?? false,
      followFlag: json['followFlag'] ?? 0,
    );
  }

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙碌
  bool get isUserBusy => isOnline == 2;

  /// 是否好友
  bool get isFriend => followFlag == 3;

  /// 是否已关注对方
  bool get hasFollowed => followFlag == 2 || followFlag == 3;
}

/// 用户在线状态
/// 用于批量查询用户在线状态
class AuvUserOnlineStatus {
  final int userId;      // 用户ID
  final int isOnline;    // 是否在线，0.离线，1.在线，2.忙线
  final int inScreen;    // 是否在屏幕中，0.否，1.是

  AuvUserOnlineStatus({
    required this.userId,
    required this.isOnline,
    required this.inScreen,
  });

  factory AuvUserOnlineStatus.fromJson(Map<String, dynamic> json) {
    return AuvUserOnlineStatus(
      userId: json['userId'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      inScreen: json['inScreen'] ?? 0,
    );
  }

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙碌
  bool get isUserBusy => isOnline == 2;

  /// 是否离线
  bool get isOffline => isOnline == 0;

  /// 是否在屏幕中
  bool get isInScreen => inScreen == 1;
}

/// 随机头像项
class AuvPortraitItem {
  final int userId;    // 用户id
  final String portrait; // 头像

  AuvPortraitItem({
    required this.userId,
    required this.portrait,
  });

  factory AuvPortraitItem.fromJson(Map<String, dynamic> json) {
    return AuvPortraitItem(
      userId: json['userId'] ?? 0,
      portrait: json['portrait'] ?? '',
    );
  }
}

/// 用户资料完整性检查
/// 
/// 用于检查用户是否填写了必要的个人资料
/// 
/// 对应接口: GET /user/user/checkUserDetail
/// 
/// 响应示例:
/// ```json
/// {
///   "userId": 10208982,
///   "hasSignature": 0,
///   "hasTag": 0
/// }
/// ```
class AuvUserCheckDetail {
  /// 用户ID
  /// 类型: long
  /// 说明: 用户的唯一标识符
  final int userId;

  /// 是否有签名
  /// 类型: int
  /// 说明: 0.否，1.是
  /// 用于判断用户是否设置了个人签名
  final int hasSignature;

  /// 是否有标签
  /// 类型: int
  /// 说明: 0.否，1.是
  /// 用于判断用户是否设置了个人标签
  final int hasTag;

  AuvUserCheckDetail({
    required this.userId,
    required this.hasSignature,
    required this.hasTag,
  });

  /// 是否有签名
  bool get hasSetSignature => hasSignature == 1;

  /// 是否有标签
  bool get hasSetTag => hasTag == 1;

  /// 是否缺少资料（用于引导完善）
  /// 说明: 签名或标签任一缺失即返回true
  bool get isProfileIncomplete => !hasSetSignature || !hasSetTag;

  /// 是否资料完整
  bool get isProfileComplete => hasSetSignature && hasSetTag;

  /// 缺少的项目列表
  List<String> get missingItems {
    final items = <String>[];
    if (!hasSetSignature) items.add('签名');
    if (!hasSetTag) items.add('标签');
    return items;
  }

  /// 获取完整性百分比
  int get completenessPercent {
    int count = 0;
    if (hasSetSignature) count++;
    if (hasSetTag) count++;
    return (count / 2 * 100).round();
  }

  factory AuvUserCheckDetail.fromJson(Map<String, dynamic> json) {
    return AuvUserCheckDetail(
      userId: json['userId'] ?? 0,
      hasSignature: json['hasSignature'] ?? 0,
      hasTag: json['hasTag'] ?? 0,
    );
  }
}

// ==================== 子模块导出 ====================
// 请使用以下导入语句:
// export 'auv_auth_model.dart';       // 登录/注册相关 (AuvUserModel, AuvLoginRequest, AuvLoginResponse, etc.)
// export 'auv_user_media_model.dart'; // 用户媒体信息 (AuvUserMediaInfoVo, AuvMomentMediaVo, AuvGiftWallVo, AuvUserPropVo)
// export 'auv_user_profile_model.dart'; // 用户资料扩展 (AuvUserExpandModel, AuvUserExpandV2Model, AuvMyPageUserModel)
// export 'auv_user_list_model.dart'; // 用户列表 (AuvUserListItem, AuvUserListResponse, AuvFKUserItem)
// export 'auv_moment_model.dart';    // 动态相关 (AuvMomentNoticeItem, AuvUserMomentItem, etc.)
// export 'auv_comment_model.dart';    // 评论相关 (AuvCommentItem, AuvCommentReply)
// export 'auv_feedback_model.dart';   // 举报/反馈 (AuvFeedbackRequest, etc.)
// export 'auv_user_extra_model.dart';  // 用户扩展 (AuvAdvanceRewardVo, etc.)
