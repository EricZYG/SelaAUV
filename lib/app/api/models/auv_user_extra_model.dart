/// 高级用户弹窗奖励VO（扩展版，包含美元）
class AuvAdvanceRewardVo {
  final int diamondNum;     // 钻石数量
  final int callCardNum;    // 通话卡片数量
  final int matchCardNum;   // 匹配卡片数量
  final int chatCardNum;    // 聊天卡片数量
  final int couponNum;      // 优惠券数量
  final int goldNum;        // 金币数量
  final int dollarNum;      // 美元金额

  AuvAdvanceRewardVo({
    this.diamondNum = 0,
    this.callCardNum = 0,
    this.matchCardNum = 0,
    this.chatCardNum = 0,
    this.couponNum = 0,
    this.goldNum = 0,
    this.dollarNum = 0,
  });

  factory AuvAdvanceRewardVo.fromJson(Map<String, dynamic> json) {
    return AuvAdvanceRewardVo(
      diamondNum: json['diamondNum'] ?? 0,
      callCardNum: json['callCardNum'] ?? 0,
      matchCardNum: json['matchCardNum'] ?? 0,
      chatCardNum: json['chatCardNum'] ?? 0,
      couponNum: json['couponNum'] ?? 0,
      goldNum: json['goldNum'] ?? 0,
      dollarNum: json['dollarNum'] ?? 0,
    );
  }

  /// 是否有奖励
  bool get hasReward =>
      diamondNum > 0 || callCardNum > 0 || matchCardNum > 0 ||
      chatCardNum > 0 || couponNum > 0 || goldNum > 0 || dollarNum > 0;
}

/// 高级用户弹窗详情
class AuvAdvanceDialogDetail {
  final AuvAdvanceRewardVo? rewardVo;    // 奖励信息
  final String? whatsappId;           // WhatsApp ID
  final int isAdvanceUser;            // 是否高级用户，0.否，1.是
  final int isReward;                 // 是否已领取奖励，0.否，1.是

  AuvAdvanceDialogDetail({
    this.rewardVo,
    this.whatsappId,
    this.isAdvanceUser = 0,
    this.isReward = 0,
  });

  factory AuvAdvanceDialogDetail.fromJson(Map<String, dynamic> json) {
    return AuvAdvanceDialogDetail(
      rewardVo: json['rewardVo'] != null
          ? AuvAdvanceRewardVo.fromJson(json['rewardVo'])
          : null,
      whatsappId: json['whatsappId'],
      isAdvanceUser: json['isAdvanceUser'] ?? 0,
      isReward: json['isReward'] ?? 0,
    );
  }

  /// 是否是高级用户
  bool get isAdvancedUser => isAdvanceUser == 1;

  /// 是否已领取奖励
  bool get hasClaimedReward => isReward == 1;

  /// 是否可以领取奖励
  bool get canClaimReward => isAdvancedUser && !hasClaimedReward;
}

/// 上传媒体DTO
class AuvUploadMediaDto {
  final String url;    // 媒体链接
  final int type;      // 类型：1.图片，2.视频

  AuvUploadMediaDto({
    required this.url,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'url': url,
    'type': type,
  };
}

/// 性别详情更新请求
class AuvSexDetailUpdate {
  final int sex;                     // 性别，1.男，2.女
  final String? portrait;            // 头像
  final String? nickname;            // 昵称
  final int? birthday;               // 出生日期（时间戳）
  final String? inviteCode;          // 公会邀请码
  final int? faceChecked;            // 是否已通过人脸比对，1.已通过
  final List<AuvUploadMediaDto>? mediaList; // 人脸媒体列表

  AuvSexDetailUpdate({
    required this.sex,
    this.portrait,
    this.nickname,
    this.birthday,
    this.inviteCode,
    this.faceChecked,
    this.mediaList,
  });

  Map<String, dynamic> toJson() => {
    'sex': sex,
    if (portrait != null) 'portrait': portrait,
    if (nickname != null) 'nickname': nickname,
    if (birthday != null) 'birthday': birthday,
    if (inviteCode != null) 'inviteCode': inviteCode,
    if (faceChecked != null) 'faceChecked': faceChecked,
    if (mediaList != null)
      'mediaList': mediaList!.map((e) => e.toJson()).toList(),
  };
}

/// 性别引导页更新结果
class AuvSexDetailResult {
  final int userAuth;  // 认证状态，0.男用户，1.待认证，2.已认证主播，3.认证失败，9.已认证女用户

  AuvSexDetailResult({required this.userAuth});

  factory AuvSexDetailResult.fromJson(Map<String, dynamic> json) {
    return AuvSexDetailResult(userAuth: json['userAuth'] ?? 0);
  }

  /// 是否是男用户
  bool get isMaleUser => userAuth == 0;

  /// 待认证状态
  bool get isPending => userAuth == 1;

  /// 已认证主播
  bool get isCertifiedAnchor => userAuth == 2;

  /// 认证失败
  bool get isFailed => userAuth == 3;

  /// 已认证女用户
  bool get isCertifiedFemale => userAuth == 9;
}

/// 奖励飘屏项
class AuvRewardItem {
  final int userId;           // 用户ID
  final String portrait;      // 头像
  final String nickname;      // 昵称
  final int rewardType;       // 奖励类型，1.任务，2.签到，3.游戏
  final int callCardNum;      // 视频卡数量
  final int matchCardNum;     // 匹配卡数量
  final int chatCardNum;      // 聊天卡数量
  final double diamonds;      // 钻石数

  AuvRewardItem({
    required this.userId,
    required this.portrait,
    required this.nickname,
    required this.rewardType,
    required this.callCardNum,
    required this.matchCardNum,
    required this.chatCardNum,
    required this.diamonds,
  });

  factory AuvRewardItem.fromJson(Map<String, dynamic> json) {
    return AuvRewardItem(
      userId: json['userId'] ?? 0,
      portrait: json['portrait'] ?? '',
      nickname: json['nickname'] ?? '',
      rewardType: json['rewardType'] ?? 1,
      callCardNum: json['callCardNum'] ?? 0,
      matchCardNum: json['matchCardNum'] ?? 0,
      chatCardNum: json['chatCardNum'] ?? 0,
      diamonds: (json['diamonds'] ?? 0).toDouble(),
    );
  }

  /// 奖励类型名称
  String get rewardTypeName {
    switch (rewardType) {
      case 1: return '任务';
      case 2: return '签到';
      case 3: return '游戏';
      default: return '未知';
    }
  }
}

/// 钻石排行项
class AuvDiamondRankingItem {
  final int userId;           // 用户ID
  final String username;      // 用于显示的UID
  final String nickname;      // 用户昵称
  final String portrait;      // 头像
  final bool vipFlag;         // 是否VIP
  final int level;            // 等级值
  final double diamonds;      // 钻石数

  AuvDiamondRankingItem({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.portrait,
    required this.vipFlag,
    required this.level,
    required this.diamonds,
  });

  factory AuvDiamondRankingItem.fromJson(Map<String, dynamic> json) {
    return AuvDiamondRankingItem(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      vipFlag: json['vipFlag'] ?? false,
      level: json['level'] ?? 0,
      diamonds: (json['diamonds'] ?? 0).toDouble(),
    );
  }
}
