import 'auv_user_model.dart';
import 'auv_user_media_model.dart';

/// 用户详情模型
class AuvUserExpandModel {
  final int userId;
  final String username;
  final String nickname;
  final String srcNickname;
  final String portrait;
  final int countryCode;
  final String countryPath;     // 国旗链接
  final String countryTitle;    // 国家名
  final int userAuth;           // 认证状态，0.男用户，1.待认证主播，2.已认证主播，3.认证失败主播，4.违规主播
  final int userStatus;         // 封禁状态，-1.注销，1.正常
  final int isOnline;           // 0.离线，1.在线，2.忙线
  final int disturbFlag;        // 勿扰标识，0.正常，1.勿扰
  final List<AuvUserMediaInfoVo> albumUrlList; // 相册和视频
  final List<AuvMomentMediaVo> momentMedias;   // 主播动态
  final int sex;                // 性别 1男 2女
  final int birthday;           // 出生日期（时间戳）
  final String language;        // 语言
  final String? manyLanguage;
  final List<String> tagList;
  final List<AuvGiftWallVo> wallVoList; // 礼物墙
  final int sendMsgPrice;       // 发消息私聊价格
  final int callPrice;          // 视频聊天价格
  final List<AuvUserPropVo> propVoList;   // 背包明细
  final bool sendMsgFlag;       // 是否免费聊天
  final int followFlag;         // 关注状态
  final int likeFlag;           // 1.未喜欢 2.已喜欢
  final bool faceFlag;          // 是否真人
  final bool vipFlag;           // 是否vip
  final String signature;       // 个人签名
  final String? onlineBegin;    // 每日在线开始时间 HH:mm
  final String? onlineEnd;      // 每日在线结束时间 HH:mm
  final int priceLevel;         // 等级值
  final AuvUserLevelConfig? levelConfig; // 等级配置
  final int totalRecharge;      // 总充值额（分）
  final bool unlockPermissionFlag; // 是否解锁权限
  final int unlockPermissionDiamonds; // 解锁所需钻石
  final int inLiveRoom;         // 是否在直播中，0.否，1.是
  final int roomId;             // 房间ID
  final int liveFirstSeconds;   // 首次扣费通话时长（秒）

  AuvUserExpandModel({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.srcNickname,
    required this.portrait,
    required this.countryCode,
    required this.countryPath,
    required this.countryTitle,
    required this.userAuth,
    required this.userStatus,
    required this.isOnline,
    required this.disturbFlag,
    required this.albumUrlList,
    required this.momentMedias,
    required this.sex,
    required this.birthday,
    required this.language,
    this.manyLanguage,
    required this.tagList,
    required this.wallVoList,
    required this.sendMsgPrice,
    required this.callPrice,
    required this.propVoList,
    required this.sendMsgFlag,
    required this.followFlag,
    required this.likeFlag,
    required this.faceFlag,
    required this.vipFlag,
    required this.signature,
    this.onlineBegin,
    this.onlineEnd,
    required this.priceLevel,
    this.levelConfig,
    required this.totalRecharge,
    required this.unlockPermissionFlag,
    required this.unlockPermissionDiamonds,
    required this.inLiveRoom,
    required this.roomId,
    required this.liveFirstSeconds,
  });

  factory AuvUserExpandModel.fromJson(Map<String, dynamic> json) {
    return AuvUserExpandModel(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      srcNickname: json['srcNickname'] ?? '',
      portrait: json['portrait'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      userAuth: json['userAuth'] ?? 0,
      userStatus: json['userStatus'] ?? 1,
      isOnline: json['isOnline'] ?? 0,
      disturbFlag: json['disturbFlag'] ?? 0,
      albumUrlList: (json['albumUrlList'] as List?)
              ?.map((e) => AuvUserMediaInfoVo.fromJson(e))
              .toList() ??
          [],
      momentMedias: (json['momentMedias'] as List?)
              ?.map((e) => AuvMomentMediaVo.fromJson(e))
              .toList() ??
          [],
      sex: json['sex'] ?? 0,
      birthday: json['birthday'] ?? 0,
      language: json['language'] ?? '',
      manyLanguage: json['manyLanguage'],
      tagList: List<String>.from(json['tagList'] ?? []),
      wallVoList: (json['wallVoList'] as List?)
              ?.map((e) => AuvGiftWallVo.fromJson(e))
              .toList() ??
          [],
      sendMsgPrice: json['sendMsgPrice'] ?? 0,
      callPrice: json['callPrice'] ?? 0,
      propVoList: (json['propVoList'] as List?)
              ?.map((e) => AuvUserPropVo.fromJson(e))
              .toList() ??
          [],
      sendMsgFlag: json['sendMsgFlag'] ?? false,
      followFlag: json['followFlag'] ?? 0,
      likeFlag: json['likeFlag'] ?? 1,
      faceFlag: json['faceFlag'] ?? false,
      vipFlag: json['vipFlag'] ?? false,
      signature: json['signature'] ?? '',
      onlineBegin: json['onlineBegin'],
      onlineEnd: json['onlineEnd'],
      priceLevel: json['priceLevel'] ?? 0,
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      totalRecharge: json['totalRecharge'] ?? 0,
      unlockPermissionFlag: json['unlockPermissionFlag'] ?? false,
      unlockPermissionDiamonds: json['unlockPermissionDiamonds'] ?? 0,
      inLiveRoom: json['inLiveRoom'] ?? 0,
      roomId: json['roomId'] ?? 0,
      liveFirstSeconds: json['liveFirstSeconds'] ?? 0,
    );
  }

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙碌
  bool get isUserBusy => isOnline == 2;

  /// 是否主播
  bool get isAnchor => userAuth >= 1 && userAuth <= 4;

  /// 是否已认证主播
  bool get isCertifiedAnchor => userAuth == 2;

  /// 是否好友
  bool get isFriend => followFlag == 3;

  /// 是否已关注
  bool get hasFollowed => followFlag == 2 || followFlag == 3;

  /// 是否已喜欢
  bool get hasLiked => likeFlag == 2;

  /// 是否在直播中
  bool get isLiveStreaming => inLiveRoom == 1;

  /// 是否正常用户
  bool get isNormal => userStatus == 1;

  /// 是否已注销
  bool get isDeleted => userStatus == -1;
}

/// 男用户详情V2
class AuvUserExpandV2Model {
  final int userId;              // 用户ID
  final String username;         // 用于显示的UID
  final String nickname;         // 昵称
  final String portrait;         // 头像
  final int countryCode;         // 国家
  final String countryPath;      // 国旗链接
  final String countryTitle;     // 国家名
  final int userAuth;            // 认证状态
  final int userStatus;          // 封禁状态，-1.注销，1.正常，2.封禁
  final int isOnline;            // 是否在线，0.离线，1.在线，2.忙线
  final int sex;                // 性别 1男 2女
  final int birthday;            // 出生日期
  final String language;         // 语言
  final String? manyLanguage;
  final String? languageName;
  final String? manyLanguageName;
  final String signature;        // 个性签名
  final int totalRecharge;       // 总充值额，单位美分
  final int isAdvanceUser;       // 是否是高级用户 0 否 1是
  final bool vipFlag;            // 是否vip
  final int followCount;         // 关注数量
  final int followedCount;       // 被关注数量
  final int likeMeCount;         // 喜欢我的数量
  final AuvUserLevelConfig? levelConfig; // 等级配置信息
  final List<String> tagList;    // 标签
  final List<AuvGiftWallVo>? wallVoList; // 礼物墙
  final List<AuvUserMediaInfoVo>? albumUrlList; // 相册

  AuvUserExpandV2Model({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.portrait,
    required this.countryCode,
    required this.countryPath,
    required this.countryTitle,
    required this.userAuth,
    required this.userStatus,
    required this.isOnline,
    required this.sex,
    required this.birthday,
    required this.language,
    this.manyLanguage,
    this.languageName,
    this.manyLanguageName,
    required this.signature,
    required this.totalRecharge,
    required this.isAdvanceUser,
    required this.vipFlag,
    required this.followCount,
    required this.followedCount,
    required this.likeMeCount,
    this.levelConfig,
    required this.tagList,
    this.wallVoList,
    this.albumUrlList,
  });

  factory AuvUserExpandV2Model.fromJson(Map<String, dynamic> json) {
    return AuvUserExpandV2Model(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      userAuth: json['userAuth'] ?? 0,
      userStatus: json['userStatus'] ?? 1,
      isOnline: json['isOnline'] ?? 0,
      sex: json['sex'] ?? 0,
      birthday: json['birthday'] ?? 0,
      language: json['language'] ?? '',
      manyLanguage: json['manyLanguage'],
      languageName: json['languageName'],
      manyLanguageName: json['manyLanguageName'],
      signature: json['signature'] ?? '',
      totalRecharge: json['totalRecharge'] ?? 0,
      isAdvanceUser: json['isAdvanceUser'] ?? 0,
      vipFlag: json['vipFlag'] ?? false,
      followCount: json['followCount'] ?? 0,
      followedCount: json['followedCount'] ?? 0,
      likeMeCount: json['likeMeCount'] ?? 0,
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      tagList: List<String>.from(json['tagList'] ?? []),
      wallVoList: (json['wallVoList'] as List?)
          ?.map((e) => AuvGiftWallVo.fromJson(e))
          .toList(),
      albumUrlList: (json['albumUrlList'] as List?)
          ?.map((e) => AuvUserMediaInfoVo.fromJson(e))
          .toList(),
    );
  }

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙碌
  bool get isUserBusy => isOnline == 2;

  /// 是否正常用户
  bool get isNormal => userStatus == 1;

  /// 是否已注销
  bool get isDeleted => userStatus == -1;

  /// 是否被封禁
  bool get isBanned => userStatus == 2;

  /// 是否高级用户
  bool get isAdvance => isAdvanceUser == 1;
}

/// 我的页面用户详情模型
/// 对应接口: /user/user/getUserDetail
class AuvMyPageUserModel {
  final int userId;
  final String username;
  final int countryCode;
  final int userAuth;
  final int isOnline;
  final String nickname;
  final String portrait;
  final int vipEndTime;
  final int totalRecharge;
  final int remainDiamonds;
  final String countryPath;
  final String countryTitle;
  final String countrySubCode;
  final int? followFlag;
  final int? likeFlag;
  final int? likeMeCount;
  final AuvUserLevelConfig? levelConfig;
  final int disturbFlag;
  final int birthday;
  final int registerRewardFlag;
  final int registerReportFlag;
  final int signFlag;
  final int vipSignFlag;
  final int boundGoogle;
  final int hasPassword;
  final int rechargeFlag;
  final int hasSplitOrder;
  final int hasPendingSplit;
  final int multiUser;
  final int todayUser;
  final String? signature;
  final bool faceFlag;
  final List<AuvUserPropVo> propVoList;
  final bool vipFlag;
  final int showGuild;
  final int notifyFlag;
  final int sexyTipFlag;
  final int sexyMomentFlag;
  final int isAdult;
  final int tagImgId;
  final int createdAt;
  final int firstPaidTime;
  final int sexSelected;
  final int userGuildFlag;
  final int remainCoins;
  final String currencyCode;
  final int rflag;

  AuvMyPageUserModel({
    required this.userId,
    required this.username,
    required this.countryCode,
    required this.userAuth,
    required this.isOnline,
    required this.nickname,
    required this.portrait,
    required this.vipEndTime,
    required this.totalRecharge,
    required this.remainDiamonds,
    required this.countryPath,
    required this.countryTitle,
    required this.countrySubCode,
    this.followFlag,
    this.likeFlag,
    this.likeMeCount,
    this.levelConfig,
    required this.disturbFlag,
    required this.birthday,
    required this.registerRewardFlag,
    required this.registerReportFlag,
    required this.signFlag,
    required this.vipSignFlag,
    required this.boundGoogle,
    required this.hasPassword,
    required this.rechargeFlag,
    required this.hasSplitOrder,
    required this.hasPendingSplit,
    required this.multiUser,
    required this.todayUser,
    this.signature,
    required this.faceFlag,
    required this.propVoList,
    required this.vipFlag,
    required this.showGuild,
    required this.notifyFlag,
    required this.sexyTipFlag,
    required this.sexyMomentFlag,
    required this.isAdult,
    required this.tagImgId,
    required this.createdAt,
    required this.firstPaidTime,
    required this.sexSelected,
    required this.userGuildFlag,
    required this.remainCoins,
    required this.currencyCode,
    required this.rflag,
  });

  factory AuvMyPageUserModel.fromJson(Map<String, dynamic> json) {
    return AuvMyPageUserModel(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      userAuth: json['userAuth'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      vipEndTime: json['vipEndTime'] ?? 0,
      totalRecharge: json['totalRecharge'] ?? 0,
      remainDiamonds: json['remainDiamonds'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      countrySubCode: json['countrySubCode'] ?? '',
      followFlag: json['followFlag'],
      likeFlag: json['likeFlag'],
      likeMeCount: json['likeMeCount'],
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      disturbFlag: json['disturbFlag'] ?? 0,
      birthday: json['birthday'] ?? 0,
      registerRewardFlag: json['registerRewardFlag'] ?? 0,
      registerReportFlag: json['registerReportFlag'] ?? 0,
      signFlag: json['signFlag'] ?? 0,
      vipSignFlag: json['vipSignFlag'] ?? 0,
      boundGoogle: json['boundGoogle'] ?? 0,
      hasPassword: json['hasPassword'] ?? 0,
      rechargeFlag: json['rechargeFlag'] ?? 0,
      hasSplitOrder: json['hasSplitOrder'] ?? 0,
      hasPendingSplit: json['hasPendingSplit'] ?? 0,
      multiUser: json['multiUser'] ?? 0,
      todayUser: json['todayUser'] ?? 0,
      signature: json['signature'],
      faceFlag: json['faceFlag'] ?? false,
      propVoList: (json['propVoList'] as List?)
          ?.map((e) => AuvUserPropVo.fromJson(e))
          .toList() ?? [],
      vipFlag: json['vipFlag'] ?? false,
      showGuild: json['showGuild'] ?? 0,
      notifyFlag: json['notifyFlag'] ?? 0,
      sexyTipFlag: json['sexyTipFlag'] ?? 0,
      sexyMomentFlag: json['sexyMomentFlag'] ?? 0,
      isAdult: json['isAdult'] ?? 0,
      tagImgId: json['tagImgId'] ?? 0,
      createdAt: json['createdAt'] ?? 0,
      firstPaidTime: json['firstPaidTime'] ?? 0,
      sexSelected: json['sexSelected'] ?? 0,
      userGuildFlag: json['userGuildFlag'] ?? 0,
      remainCoins: json['remainCoins'] ?? 0,
      currencyCode: json['currencyCode'] ?? 'USD',
      rflag: json['rflag'] ?? 0,
    );
  }

  /// 是否VIP
  bool get isVip => vipFlag;

  /// 是否已签到
  bool get hasSigned => signFlag == 1;

  /// 是否已设置密码
  bool get hasSetPassword => hasPassword == 1;

  /// 是否绑定Google
  bool get hasBoundGoogle => boundGoogle == 1;

  /// 是否真人
  bool get isRealPerson => faceFlag;

  /// 是否成年
  bool get isAdultUser => isAdult == 1;

  /// 获取VIP过期时间
  DateTime? get vipExpireDateTime {
    if (vipEndTime <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(vipEndTime);
  }

  /// VIP是否已过期
  bool get isVipExpired {
    if (vipEndTime <= 0) return true;
    return DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(vipEndTime));
  }

  /// 获取注册时间
  DateTime? get registerTime {
    if (createdAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt);
  }
}
