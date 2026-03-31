import '../enums/auv_anchor.dart';

/// AIV主播模型
/// 用于获取AI虚拟主播信息
class AivAnchorModel {
  final int anchorUserId;  // 主播的用户id
  final int videoId;       // 视频id
  final String videoUrl;   // 虚拟视频链接
  final int voiceFlag;     // 声音标识，0.消音，1.播放声音
  final int rateFlag;      // 是否让用户评分，0.否，1.是

  AivAnchorModel({
    required this.anchorUserId,
    required this.videoId,
    required this.videoUrl,
    required this.voiceFlag,
    required this.rateFlag,
  });

  factory AivAnchorModel.fromJson(Map<String, dynamic> json) {
    return AivAnchorModel(
      anchorUserId: json['anchorUserId'] ?? 0,
      videoId: json['videoId'] ?? 0,
      videoUrl: json['videoUrl'] ?? '',
      voiceFlag: json['voiceFlag'] ?? 1,
      rateFlag: json['rateFlag'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anchorUserId': anchorUserId,
      'videoId': videoId,
      'videoUrl': videoUrl,
      'voiceFlag': voiceFlag,
      'rateFlag': rateFlag,
    };
  }

  /// 是否播放声音
  bool get hasVoice => voiceFlag == 1;

  /// 是否需要评分
  bool get needsRate => rateFlag == 1;
}

/// 主播录制视频配置模型
class AuvAnchorVideoConfigModel {
  final int videoFlag;    // 是否录制视频，0.否，1.是
  final int videoSeconds; // 录制视频时长，秒数

  AuvAnchorVideoConfigModel({
    required this.videoFlag,
    required this.videoSeconds,
  });

  factory AuvAnchorVideoConfigModel.fromJson(Map<String, dynamic> json) {
    return AuvAnchorVideoConfigModel(
      videoFlag: json['videoFlag'] ?? 0,
      videoSeconds: json['videoSeconds'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoFlag': videoFlag,
      'videoSeconds': videoSeconds,
    };
  }

  /// 是否录制视频
  bool get isRecording => videoFlag == 1;
}

/// 主播个人相册和视频项模型
class AuvAnchorAlbumVideoVo {
  final int id;           // 主键id
  final int userId;       // 用户ID
  final String value;     // 照片或视频地址
  final String? videoCover; // 视频封面地址
  final int status;       // 审核状态，0.待审核，1.审核通过，2.审核失败
  final int fingerPrint;  // 图片hash值

  AuvAnchorAlbumVideoVo({
    required this.id,
    required this.userId,
    required this.value,
    this.videoCover,
    required this.status,
    required this.fingerPrint,
  });

  factory AuvAnchorAlbumVideoVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorAlbumVideoVo(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      value: json['value'] ?? '',
      videoCover: json['videoCover'],
      status: json['status'] ?? 0,
      fingerPrint: json['fingerPrint'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'value': value,
      'videoCover': videoCover,
      'status': status,
      'fingerPrint': fingerPrint,
    };
  }

  /// 是否待审核
  bool get isPending => status == 0;

  /// 是否审核通过
  bool get isApproved => status == 1;

  /// 是否审核失败
  bool get isRejected => status == 2;

  /// 是否是视频
  bool get isVideo => videoCover != null && videoCover!.isNotEmpty;
}

/// 匹配主播响应模型
class AuvTryGetMatchAnchorVo {
  final int anchorUserId;      // 主播id
  final int? type;             // 0 真实主播 1 虚拟视频
  final int videoId;          // 视频id
  final int voiceFlag;        // 声音标识，0.消音，1.播放声音
  final int rateFlag;         // 是否让用户评分，0.否，1.是
  final String? url;          // 视频链接地址
  final String username;       // 用于显示的UID
  final int countryCode;       // 国家编码
  final int isOnline;          // 是否在线，0.离线，1.在线，2.忙线
  final String nickname;       // 用户昵称
  final String portrait;       // 头像
  final int sex;               // 性别 1男 2女
  final int? birthday;         // 出生日期
  final String? countryPath;   // 国旗链接
  final String? countryTitle;  // 国家名
  final int followFlag;        // 1 未关注 2已关注 3好友
  final int callPrice;         // 视频聊天价格

  AuvTryGetMatchAnchorVo({
    required this.anchorUserId,
    this.type,
    required this.videoId,
    required this.voiceFlag,
    required this.rateFlag,
    this.url,
    required this.username,
    required this.countryCode,
    required this.isOnline,
    required this.nickname,
    required this.portrait,
    required this.sex,
    this.birthday,
    this.countryPath,
    this.countryTitle,
    required this.followFlag,
    required this.callPrice,
  });

  factory AuvTryGetMatchAnchorVo.fromJson(Map<String, dynamic> json) {
    return AuvTryGetMatchAnchorVo(
      anchorUserId: json['anchorUserId'] ?? 0,
      type: json['type'],
      videoId: json['videoId'] ?? 0,
      voiceFlag: json['voiceFlag'] ?? 1,
      rateFlag: json['rateFlag'] ?? 0,
      url: json['url'],
      username: json['username'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      sex: json['sex'] ?? 0,
      birthday: json['birthday'],
      countryPath: json['countryPath'],
      countryTitle: json['countryTitle'],
      followFlag: json['followFlag'] ?? 1,
      callPrice: json['callPrice'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anchorUserId': anchorUserId,
      'type': type,
      'videoId': videoId,
      'voiceFlag': voiceFlag,
      'rateFlag': rateFlag,
      'url': url,
      'username': username,
      'countryCode': countryCode,
      'isOnline': isOnline,
      'nickname': nickname,
      'portrait': portrait,
      'sex': sex,
      'birthday': birthday,
      'countryPath': countryPath,
      'countryTitle': countryTitle,
      'followFlag': followFlag,
      'callPrice': callPrice,
    };
  }

  /// 是否真实主播
  bool get isRealAnchor => type == 0;

  /// 是否虚拟视频
  bool get isVirtualVideo => type == 1;

  /// 是否在线
  bool get online => isOnline == 1;

  /// 是否忙线
  bool get busy => isOnline == 2;

  /// 是否未关注
  bool get isNotFollowed => followFlag == 1;

  /// 是否已关注
  bool get isFollowed => followFlag == 2;

  /// 是否好友
  bool get isFriend => followFlag == 3;

  /// 是否播放声音
  bool get hasVoice => voiceFlag == 1;

  /// 是否需要评分
  bool get needsRate => rateFlag == 1;
}

/// 主播聊天图片模型
class AuvAnchorChatImgVo {
  final int id;              // 主键id
  final int userId;           // 用户ID
  final int sourceId;         // 待替换id
  final String value;         // 照片或视频地址
  final String? blurValue;    // 模糊图片
  final String? videoCover;   // 资源类型为视频时的封面地址
  final int videoSeconds;     // 视频时长，单位秒
  final int scaleType;        // 尺度，1.正常尺度，2.大尺度
  final int status;           // 审核状态，0.待审核，1.审核通过，2.审核失败
  final int sortWeight;       // 排序权重
  final int fingerPrint;      // 图片hash值

  AuvAnchorChatImgVo({
    required this.id,
    required this.userId,
    required this.sourceId,
    required this.value,
    this.blurValue,
    this.videoCover,
    required this.videoSeconds,
    required this.scaleType,
    required this.status,
    required this.sortWeight,
    required this.fingerPrint,
  });

  factory AuvAnchorChatImgVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorChatImgVo(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      sourceId: json['sourceId'] ?? 0,
      value: json['value'] ?? '',
      blurValue: json['blurValue'],
      videoCover: json['videoCover'],
      videoSeconds: json['videoSeconds'] ?? 0,
      scaleType: json['scaleType'] ?? 1,
      status: json['status'] ?? 0,
      sortWeight: json['sortWeight'] ?? 0,
      fingerPrint: json['fingerPrint'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'sourceId': sourceId,
      'value': value,
      'blurValue': blurValue,
      'videoCover': videoCover,
      'videoSeconds': videoSeconds,
      'scaleType': scaleType,
      'status': status,
      'sortWeight': sortWeight,
      'fingerPrint': fingerPrint,
    };
  }

  /// 是否视频
  bool get isVideo => videoCover != null && videoCover!.isNotEmpty;

  /// 是否大尺度
  bool get isLargeScale => scaleType == 2;

  /// 是否正常尺度
  bool get isNormalScale => scaleType == 1;

  /// 审核通过
  bool get approved => status == 1;

  /// 审核失败
  bool get rejected => status == 2;

  /// 待审核
  bool get pending => status == 0;
}

/// 调整聊天图片顺序模型
class AuvUpdateAnchorChatImgSortVo {
  final String id;     // 图片id
  final int sortWeight; // 排序权重

  AuvUpdateAnchorChatImgSortVo({
    required this.id,
    required this.sortWeight,
  });

  factory AuvUpdateAnchorChatImgSortVo.fromJson(Map<String, dynamic> json) {
    return AuvUpdateAnchorChatImgSortVo(
      id: json['id']?.toString() ?? '',
      sortWeight: json['sortWeight'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sortWeight': sortWeight,
    };
  }
}

/// 收益排行榜项模型
class AuvAnchorRankingVo {
  final int userId;       // 用户ID
  final String username;  // 用于显示的UID
  final String nickname;  // 用户昵称
  final String portrait;  // 头像
  final int coins;        // 金币数

  AuvAnchorRankingVo({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.portrait,
    required this.coins,
  });

  factory AuvAnchorRankingVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorRankingVo(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      coins: json['coins'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'nickname': nickname,
      'portrait': portrait,
      'coins': coins,
    };
  }
}

/// 主播端设备信息模型
class AuvAnchorDeviceInfoVo {
  final String cpuModel;    // cpu型号
  final int cpuCores;       // cpu核心数
  final int cpuHz;          // cpu最大频率，单位Hz
  final int memory;        // 运行内存，单位byte
  final int storage;        // 存储总内存，单位byte
  final int cpuLevel;       // 本地cpu评判等级
  final int memoryLevel;    // 本地运行内存评判等级
  final int isEmulator;     // 设备是否虚拟机，0.否，1.是
  final int isRoot;         // 设备是否root，0.否，1.是

  AuvAnchorDeviceInfoVo({
    required this.cpuModel,
    required this.cpuCores,
    required this.cpuHz,
    required this.memory,
    required this.storage,
    required this.cpuLevel,
    required this.memoryLevel,
    this.isEmulator = 0,
    this.isRoot = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'cpuModel': cpuModel,
      'cpuCores': cpuCores,
      'cpuHz': cpuHz,
      'memory': memory,
      'storage': storage,
      'cpuLevel': cpuLevel,
      'memoryLevel': memoryLevel,
      'isEmulator': isEmulator,
      'isRoot': isRoot,
    };
  }
}

/// 主播代理邀请主播项模型
class AuvInviteAnchorItemVo {
  final int anchorId;       // 主播id
  final String nickname;    // 昵称
  final String portrait;   // 头像
  final int userAuth;      // 认证状态：1.待认证主播，2.已认证主播，3.认证失败主播
  final int? authTime;     // 审核时间
  final String? message;   // 审核不通过原因

  AuvInviteAnchorItemVo({
    required this.anchorId,
    required this.nickname,
    required this.portrait,
    required this.userAuth,
    this.authTime,
    this.message,
  });

  factory AuvInviteAnchorItemVo.fromJson(Map<String, dynamic> json) {
    return AuvInviteAnchorItemVo(
      anchorId: json['anchorId'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      userAuth: json['userAuth'] ?? 0,
      authTime: json['authTime'],
      message: json['message'],
    );
  }

  /// 是否待认证
  bool get isPendingAuth => userAuth == 1;

  /// 是否已认证
  bool get isAuthenticated => userAuth == 2;

  /// 是否认证失败
  bool get isAuthFailed => userAuth == 3;
}

/// 主播代理入驻进度信息模型
class AuvAnchorGuildProgressVo {
  final int progress;      // 完成入驻进度的数量
  final int total;          // 总完成数量
  final String inviteUrl;   // 分享链接
  final List<AuvInviteAnchorItemVo> list;  // 邀请主播列表

  AuvAnchorGuildProgressVo({
    required this.progress,
    required this.total,
    required this.inviteUrl,
    required this.list,
  });

  factory AuvAnchorGuildProgressVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorGuildProgressVo(
      progress: json['progress'] ?? 0,
      total: json['total'] ?? 0,
      inviteUrl: json['inviteUrl'] ?? '',
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => AuvInviteAnchorItemVo.fromJson(e))
              .toList() ??
          [],
    );
  }

  /// 是否全部完成
  bool get isCompleted => progress >= total;
}

/// 主播雷达图数据模型
class AuvAnchorRadarChartVo {
  final int userId;                     // 主播id
  final int callAvgDuration;            // 平均通话时长，单位毫秒数
  final double callAvgDurationOverRate; // 平均通话时长超过百分之多少主播
  final int coins;                      // 总收益，小数点后两位
  final double coinsOverRate;           // 总收益超过百分之多少主播
  final int callCount;                  // 通话数
  final double callCountOverRate;       // 通话数超过百分之多少主播
  final double callRate;                // 接通率
  final double callRateOverRate;        // 接通率超过百分之多少主播
  final double callEffectRate;          // 有效接听率
  final double callEffectRateOverRate; // 有效接听率超过百分之多少主播
  final double callContinueRate;        // 通话续时率
  final double callContinueRateOverRate; // 通话续时率超过百分之多少主播

  AuvAnchorRadarChartVo({
    required this.userId,
    required this.callAvgDuration,
    required this.callAvgDurationOverRate,
    required this.coins,
    required this.coinsOverRate,
    required this.callCount,
    required this.callCountOverRate,
    required this.callRate,
    required this.callRateOverRate,
    required this.callEffectRate,
    required this.callEffectRateOverRate,
    required this.callContinueRate,
    required this.callContinueRateOverRate,
  });

  factory AuvAnchorRadarChartVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorRadarChartVo(
      userId: json['userId'] ?? 0,
      callAvgDuration: json['callAvgDuration'] ?? 0,
      callAvgDurationOverRate: (json['callAvgDurationOverRate'] ?? 0).toDouble(),
      coins: json['coins'] ?? 0,
      coinsOverRate: (json['coinsOverRate'] ?? 0).toDouble(),
      callCount: json['callCount'] ?? 0,
      callCountOverRate: (json['callCountOverRate'] ?? 0).toDouble(),
      callRate: (json['callRate'] ?? 0).toDouble(),
      callRateOverRate: (json['callRateOverRate'] ?? 0).toDouble(),
      callEffectRate: (json['callEffectRate'] ?? 0).toDouble(),
      callEffectRateOverRate: (json['callEffectRateOverRate'] ?? 0).toDouble(),
      callContinueRate: (json['callContinueRate'] ?? 0).toDouble(),
      callContinueRateOverRate: (json['callContinueRateOverRate'] ?? 0).toDouble(),
    );
  }

  /// 平均通话时长（秒）
  double get callAvgDurationSeconds => callAvgDuration / 1000;
}

/// 主播匹配限制信息模型
class AuvAnchorMatchLimitVo {
  final int totalCount;      // 匹配次数上限
  final int leftCount;       // 匹配剩余次数
  final int leftSeconds;     // 匹配限制重置倒计时（秒）
  final int aivTotalCount;   // AIV匹配次数上限
  final int aivLeftCount;    // AIV匹配剩余次数
  final int aivLeftSeconds;  // AIV匹配限制重置倒计时（秒）

  AuvAnchorMatchLimitVo({
    required this.totalCount,
    required this.leftCount,
    required this.leftSeconds,
    required this.aivTotalCount,
    required this.aivLeftCount,
    required this.aivLeftSeconds,
  });

  factory AuvAnchorMatchLimitVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorMatchLimitVo(
      totalCount: json['totalCount'] ?? 0,
      leftCount: json['leftCount'] ?? 0,
      leftSeconds: json['leftSeconds'] ?? 0,
      aivTotalCount: json['aivTotalCount'] ?? 0,
      aivLeftCount: json['aivLeftCount'] ?? 0,
      aivLeftSeconds: json['aivLeftSeconds'] ?? 0,
    );
  }

  /// 是否还有匹配次数
  bool get hasMatchLeft => leftCount > 0;

  /// 是否还有AIV匹配次数
  bool get hasAivMatchLeft => aivLeftCount > 0;

  /// 剩余时间格式化（分:秒）
  String get leftTimeFormatted {
    final minutes = leftSeconds ~/ 60;
    final seconds = leftSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// AIV剩余时间格式化（分:秒）
  String get aivLeftTimeFormatted {
    final minutes = aivLeftSeconds ~/ 60;
    final seconds = aivLeftSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

/// 标签推荐主播项模型
class AuvTagRecommendAnchorVo {
  final int userId;           // 用户ID
  final String username;      // 用户名
  final int countryCode;      // 国家编码
  final int userAuth;         // 认证状态
  final int isOnline;         // 是否在线：0.离线，1.在线，2.忙线
  final int disturbFlag;      // 勿扰标识：0.关闭，1.开启
  final String nickname;      // 昵称
  final String portrait;      // 头像
  final int? birthday;        // 出生日期
  final String? cover;        // 封面
  final String? videoUrl;    // 视频地址
  final String? videoCoverUrl; // 视频封面地址
  final int callPrice;        // 通话价格
  final String? countryPath;  // 国旗链接
  final String? countryTitle; // 国家名
  final String? manyLanguage; // 多语言
  final String? manyLanguageName; // 多语言名称
  final int followFlag;        // 关注标识：1.未关注，2.已关注，3.好友
  final int newAnchor;         // 新主播标识：0.否，1.是

  AuvTagRecommendAnchorVo({
    required this.userId,
    required this.username,
    required this.countryCode,
    required this.userAuth,
    required this.isOnline,
    required this.disturbFlag,
    required this.nickname,
    required this.portrait,
    this.birthday,
    this.cover,
    this.videoUrl,
    this.videoCoverUrl,
    required this.callPrice,
    this.countryPath,
    this.countryTitle,
    this.manyLanguage,
    this.manyLanguageName,
    required this.followFlag,
    required this.newAnchor,
  });

  factory AuvTagRecommendAnchorVo.fromJson(Map<String, dynamic> json) {
    return AuvTagRecommendAnchorVo(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      userAuth: json['userAuth'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      disturbFlag: json['disturbFlag'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      birthday: json['birthday'],
      cover: json['cover'],
      videoUrl: json['videoUrl'],
      videoCoverUrl: json['videoCoverUrl'],
      callPrice: json['callPrice'] ?? 0,
      countryPath: json['countryPath'],
      countryTitle: json['countryTitle'],
      manyLanguage: json['manyLanguage'],
      manyLanguageName: json['manyLanguageName'],
      followFlag: json['followFlag'] ?? 1,
      newAnchor: json['newAnchor'] ?? 0,
    );
  }

  /// 是否在线
  bool get isOnlineStatus => isOnline == 1;

  /// 是否忙线
  bool get isBusy => isOnline == 2;

  /// 是否勿扰
  bool get isDisturb => disturbFlag == 1;

  /// 是否未关注
  bool get isNotFollowed => followFlag == 1;

  /// 是否已关注
  bool get isFollowed => followFlag == 2;

  /// 是否好友
  bool get isFriend => followFlag == 3;

  /// 是否新主播
  bool get isNewAnchor => newAnchor == 1;
}

/// 一键打招呼主播项模型
class AuvQuickGreetAnchorVo {
  final int anchorUserId;  // 主播id
  final String nickname;    // 昵称
  final String portrait;   // 头像

  AuvQuickGreetAnchorVo({
    required this.anchorUserId,
    required this.nickname,
    required this.portrait,
  });

  factory AuvQuickGreetAnchorVo.fromJson(Map<String, dynamic> json) {
    return AuvQuickGreetAnchorVo(
      anchorUserId: json['anchorUserId'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anchorUserId': anchorUserId,
      'nickname': nickname,
      'portrait': portrait,
    };
  }
}

/// 一键打招呼结果项模型
class AuvQuickGreetResultVo {
  final int anchorUserId;  // 主播id
  final String content;    // 发送内容

  AuvQuickGreetResultVo({
    required this.anchorUserId,
    required this.content,
  });

  factory AuvQuickGreetResultVo.fromJson(Map<String, dynamic> json) {
    return AuvQuickGreetResultVo(
      anchorUserId: json['anchorUserId'] ?? 0,
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anchorUserId': anchorUserId,
      'content': content,
    };
  }
}

/// 主播私密聊天图片模型
class AuvAnchorPrivacyChatImgVo {
  final int id;              // 主键id
  final int userId;           // 用户ID
  final int sourceId;        // 待替换id
  final String value;         // 照片或视频地址
  final String? blurValue;   // 模糊图片
  final String? videoCover;   // 资源类型为视频时的封面地址
  final int videoSeconds;    // 视频时长，单位秒
  final int status;          // 审核状态，0.待审核，1.审核通过，2.审核失败
  final int sortWeight;      // 排序权重
  final int fingerPrint;     // 图片hash值

  AuvAnchorPrivacyChatImgVo({
    required this.id,
    required this.userId,
    required this.sourceId,
    required this.value,
    this.blurValue,
    this.videoCover,
    required this.videoSeconds,
    required this.status,
    required this.sortWeight,
    required this.fingerPrint,
  });

  factory AuvAnchorPrivacyChatImgVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorPrivacyChatImgVo(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      sourceId: json['sourceId'] ?? 0,
      value: json['value'] ?? '',
      blurValue: json['blurValue'],
      videoCover: json['videoCover'],
      videoSeconds: json['videoSeconds'] ?? 0,
      status: json['status'] ?? 0,
      sortWeight: json['sortWeight'] ?? 0,
      fingerPrint: json['fingerPrint'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'sourceId': sourceId,
      'value': value,
      'blurValue': blurValue,
      'videoCover': videoCover,
      'videoSeconds': videoSeconds,
      'status': status,
      'sortWeight': sortWeight,
      'fingerPrint': fingerPrint,
    };
  }

  /// 是否视频
  bool get isVideo => videoCover != null && videoCover!.isNotEmpty;

  /// 审核通过
  bool get approved => status == 1;

  /// 审核失败
  bool get rejected => status == 2;

  /// 待审核
  bool get pending => status == 0;
}

/// 私密聊天图片解锁记录项模型
class AuvPrivacyChatImgUnlockVo {
  final int mediaId;           // 图片id
  final int mediaUserId;       // 主播id
  final String imageUrl;        // 图片/视频封面链接
  final String? videoUrl;      // 视频链接
  final int videoSeconds;       // 视频时长，单位秒
  final int isOnline;           // 是否在线，0.离线，1.在线，2.忙线
  final String nickname;        // 昵称
  final String portrait;        // 头像
  final int birthday;          // 出生日期
  final String manyLanguage;    // 多语言
  final String manyLanguageName; // 语言显示名

  AuvPrivacyChatImgUnlockVo({
    required this.mediaId,
    required this.mediaUserId,
    required this.imageUrl,
    this.videoUrl,
    required this.videoSeconds,
    required this.isOnline,
    required this.nickname,
    required this.portrait,
    required this.birthday,
    required this.manyLanguage,
    required this.manyLanguageName,
  });

  factory AuvPrivacyChatImgUnlockVo.fromJson(Map<String, dynamic> json) {
    return AuvPrivacyChatImgUnlockVo(
      mediaId: json['mediaId'] ?? 0,
      mediaUserId: json['mediaUserId'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      videoUrl: json['videoUrl'],
      videoSeconds: json['videoSeconds'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      birthday: json['birthday'] ?? 0,
      manyLanguage: json['manyLanguage'] ?? '',
      manyLanguageName: json['manyLanguageName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mediaId': mediaId,
      'mediaUserId': mediaUserId,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'videoSeconds': videoSeconds,
      'isOnline': isOnline,
      'nickname': nickname,
      'portrait': portrait,
      'birthday': birthday,
      'manyLanguage': manyLanguage,
      'manyLanguageName': manyLanguageName,
    };
  }

  /// 是否视频
  bool get isVideo => videoUrl != null && videoUrl!.isNotEmpty;

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙碌
  bool get isUserBusy => isOnline == 2;
}

/// 私密聊天图片解锁记录分页模型
class AuvPrivacyChatImgUnlockPageVo {
  final int total;            // 总条数
  final List<AuvPrivacyChatImgUnlockVo> list; // 列表数据
  final int pageNum;           // 当前页码
  final int pageSize;          // 每页条数
  final int size;              // 当前页条数
  final int pages;             // 总页数
  final bool isFirstPage;      // 是否第一页
  final bool isLastPage;       // 是否最后一页
  final bool hasPreviousPage;  // 是否有上一页
  final bool hasNextPage;      // 是否有下一页

  AuvPrivacyChatImgUnlockPageVo({
    required this.total,
    required this.list,
    required this.pageNum,
    required this.pageSize,
    required this.size,
    required this.pages,
    required this.isFirstPage,
    required this.isLastPage,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory AuvPrivacyChatImgUnlockPageVo.fromJson(Map<String, dynamic> json) {
    final listData = json['list'] ?? [];
    return AuvPrivacyChatImgUnlockPageVo(
      total: json['total'] ?? 0,
      list: (listData as List)
          .map((e) => AuvPrivacyChatImgUnlockVo.fromJson(e))
          .toList(),
      pageNum: json['pageNum'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      size: json['size'] ?? 0,
      pages: json['pages'] ?? 1,
      isFirstPage: json['isFirstPage'] ?? true,
      isLastPage: json['isLastPage'] ?? true,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      hasNextPage: json['hasNextPage'] ?? false,
    );
  }

  bool get isEmpty => list.isEmpty;
}

/// 屏幕匹配主播筛选条件
class AuvScreenMatchAnchorFilter {
  final int? sex;           // 性别，1男，2女
  final int? minAge;        // 最小年龄
  final int? maxAge;        // 最大年龄
  final int? anchorStyle;   // 主播风格，1.展示型，2.聊天型，3.随意型
  final int? areaCode;      // 地区编码

  AuvScreenMatchAnchorFilter({
    this.sex,
    this.minAge,
    this.maxAge,
    this.anchorStyle,
    this.areaCode,
  });

  Map<String, dynamic> toJson() {
    return {
      if (sex != null) 'sex': sex,
      if (minAge != null) 'minAge': minAge,
      if (maxAge != null) 'maxAge': maxAge,
      if (anchorStyle != null) 'anchorStyle': anchorStyle,
      if (areaCode != null) 'areaCode': areaCode,
    };
  }
}

/// 主播风格枚举
enum AuvAnchorStyle {
  display(1),   // 展示型
  chatting(2),   // 聊天型
  casual(3);    // 随意型

  final int value;
  const AuvAnchorStyle(this.value);
}

/// 性别枚举
enum AuvSex {
  male(1),   // 男
  female(2); // 女

  final int value;
  const AuvSex(this.value);
}

/// 批量匹配主播筛选条件
class AuvBatchMatchAnchorFilter {
  final int size;  // 匹配数量（区间1～10）
  final int? type; // 匹配类型，0 真实主播，1 虚拟视频

  AuvBatchMatchAnchorFilter({
    required this.size,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      if (type != null) 'type': type,
    };
  }
}

/// 匹配类型枚举
enum AuvMatchAnchorType {
  real(0),   // 真实主播
  virtual(1); // 虚拟视频

  final int value;
  const AuvMatchAnchorType(this.value);
}

/// 主播认证流程信息V2
class AuvAnchorAuthV2Vo {
  final int stepNum;         // 即将提交的认证步骤，1.基本信息，2.头像，3.人脸认证，4.相册和签名
  final String? portrait;     // 头像链接，stepNum=3的时候会返回上一步提交的头像
  final String? authMessage;  // 认证失败回复内容
  final int pendingType;      // 待认证类型，1.多账号，2.其他

  AuvAnchorAuthV2Vo({
    required this.stepNum,
    this.portrait,
    this.authMessage,
    required this.pendingType,
  });

  factory AuvAnchorAuthV2Vo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorAuthV2Vo(
      stepNum: json['stepNum'] ?? 1,
      portrait: json['portrait'],
      authMessage: json['authMessage'],
      pendingType: json['pendingType'] ?? 0,
    );
  }

  /// 是否基本信息步骤
  bool get isBasicInfo => stepNum == 1;

  /// 是否头像步骤
  bool get isPortrait => stepNum == 2;

  /// 是否人脸认证步骤
  bool get isFaceAuth => stepNum == 3;

  /// 是否相册和签名步骤
  bool get isAlbumAndSignature => stepNum == 4;

  /// 待认证类型-多账号
  bool get isMultiAccount => pendingType == 1;

  /// 待认证类型-其他
  bool get isOther => pendingType == 2;

  /// 是否有失败消息
  bool get hasAuthMessage => authMessage != null && authMessage!.isNotEmpty;
}

/// 上传媒体DTO
class AuvUploadMediaDto {
  final String value;           // 媒体链接
  final String? videoCover;     // 视频封面

  AuvUploadMediaDto({
    required this.value,
    this.videoCover,
  });

  factory AuvUploadMediaDto.fromJson(Map<String, dynamic> json) {
    return AuvUploadMediaDto(
      value: json['value'] ?? '',
      videoCover: json['videoCover'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      if (videoCover != null) 'videoCover': videoCover,
    };
  }
}

/// 提交审核资料请求V2
class AuvSaveAnchorAuthV2Request {
  final String? nickname;           // 昵称，第一步传
  final int? birthday;             // 生日，时间戳，第一步传
  final String? inviteCode;         // 公会邀请码，第一步传
  final int? systemGuildFlag;      // 是否绑定到系统公会，0.否，1.是，第一步传
  final int? isFemale;             // 是否女性，0.否，1.是
  final int? isRoot;               // 设备是否root，0.否，1.是
  final int? isLivingFace;         // 是否是活人，0.否，1.是
  final List<AuvUploadMediaDto>? mediaList; // 认证媒体，step2=头像，step3=人脸，step4=3张图片
  final String? signature;          // 个人签名，第四步传
  final int stepNum;               // 当前提交的认证步骤，1-4

  AuvSaveAnchorAuthV2Request({
    this.nickname,
    this.birthday,
    this.inviteCode,
    this.systemGuildFlag,
    this.isFemale,
    this.isRoot,
    this.isLivingFace,
    this.mediaList,
    this.signature,
    required this.stepNum,
  });

  Map<String, dynamic> toJson() {
    return {
      if (nickname != null) 'nickname': nickname,
      if (birthday != null) 'birthday': birthday,
      if (inviteCode != null) 'inviteCode': inviteCode,
      if (systemGuildFlag != null) 'systemGuildFlag': systemGuildFlag,
      if (isFemale != null) 'isFemale': isFemale,
      if (isRoot != null) 'isRoot': isRoot,
      if (isLivingFace != null) 'isLivingFace': isLivingFace,
      if (mediaList != null) 'mediaList': mediaList!.map((e) => e.toJson()).toList(),
      if (signature != null) 'signature': signature,
      'stepNum': stepNum,
    };
  }
}

/// 提交审核资料响应V2
class AuvSaveAnchorAuthV2Response {
  final int userId;           // 用户ID
  final int userAuth;          // 认证状态，1.待认证主播，2.已认证主播，3.认证失败主播
  final int stepNum;           // 下一步的认证步骤，1-4
  final int pendingType;      // 待认证类型，1.多账号，2.其他

  AuvSaveAnchorAuthV2Response({
    required this.userId,
    required this.userAuth,
    required this.stepNum,
    required this.pendingType,
  });

  factory AuvSaveAnchorAuthV2Response.fromJson(Map<String, dynamic> json) {
    return AuvSaveAnchorAuthV2Response(
      userId: json['userId'] ?? 0,
      userAuth: json['userAuth'] ?? 1,
      stepNum: json['stepNum'] ?? 1,
      pendingType: json['pendingType'] ?? 0,
    );
  }

  /// 是否待认证
  bool get isPending => userAuth == 1;

  /// 是否已认证
  bool get isApproved => userAuth == 2;

  /// 是否认证失败
  bool get isRejected => userAuth == 3;

  /// 是否完成认证
  bool get isCompleted => stepNum == 0 || isApproved;
}

/// 星级配置
class AuvAnchorLevelConfig {
  final int level;     // 等级值
  final double begin;  // 金币数起始值

  AuvAnchorLevelConfig({
    required this.level,
    required this.begin,
  });

  factory AuvAnchorLevelConfig.fromJson(Map<String, dynamic> json) {
    return AuvAnchorLevelConfig(
      level: json['level'] ?? 0,
      begin: (json['begin'] ?? 0).toDouble(),
    );
  }
}

/// 主播星级数据V2
class AuvAnchorLevelV2Vo {
  final int priceLevel;              // 星级
  final int incomePriceLevel;        // 根据收益计算的星级
  final int rewardFlag;              // 是否奖励星级，0.否，1.是
  final int rewardDays;              // 奖励星级生效天数
  final int rewardLeftSeconds;       // 奖励星级生效剩余秒数
  final double nextLevelCoins;       // 升级到下一星级需要的金币数
  final double levelRangeCoins;      // 当前星级范围的金币数
  final double latestCoins;          // 近7日金币数
  final List<AuvAnchorLevelConfig> levels; // 星级配置列表

  AuvAnchorLevelV2Vo({
    required this.priceLevel,
    required this.incomePriceLevel,
    required this.rewardFlag,
    required this.rewardDays,
    required this.rewardLeftSeconds,
    required this.nextLevelCoins,
    required this.levelRangeCoins,
    required this.latestCoins,
    required this.levels,
  });

  factory AuvAnchorLevelV2Vo.fromJson(Map<String, dynamic> json) {
    final levelsData = json['levels'] as List<dynamic>? ?? [];
    return AuvAnchorLevelV2Vo(
      priceLevel: json['priceLevel'] ?? 0,
      incomePriceLevel: json['incomePriceLevel'] ?? 0,
      rewardFlag: json['rewardFlag'] ?? 0,
      rewardDays: json['rewardDays'] ?? 0,
      rewardLeftSeconds: json['rewardLeftSeconds'] ?? 0,
      nextLevelCoins: (json['nextLevelCoins'] ?? 0).toDouble(),
      levelRangeCoins: (json['levelRangeCoins'] ?? 0).toDouble(),
      latestCoins: (json['latestCoins'] ?? 0).toDouble(),
      levels: levelsData.map((e) => AuvAnchorLevelConfig.fromJson(e)).toList(),
    );
  }

  /// 是否有奖励星级
  bool get hasReward => rewardFlag == 1;

  /// 实际显示星级（优先显示奖励星级）
  int get displayLevel => hasReward ? incomePriceLevel : priceLevel;

  /// 进度百分比
  double get progressPercent {
    if (nextLevelCoins <= 0) return 0;
    return (latestCoins / nextLevelCoins).clamp(0.0, 1.0);
  }
}

/// 主播免费视频数据
class AuvFreeVideoVo {
  final int anchorUserId;   // 主播的用户id
  final int videoId;        // 视频id
  final String? videoUrl;   // 虚拟视频链接，isFree=1时返回
  final int isFree;         // 是否可看虚拟视频，0.不能看，1.能看
  final int callable;       // 是否可打真实通话，0.不能打，1.能打

  AuvFreeVideoVo({
    required this.anchorUserId,
    required this.videoId,
    this.videoUrl,
    required this.isFree,
    required this.callable,
  });

  factory AuvFreeVideoVo.fromJson(Map<String, dynamic> json) {
    return AuvFreeVideoVo(
      anchorUserId: json['anchorUserId'] ?? 0,
      videoId: json['videoId'] ?? 0,
      videoUrl: json['videoUrl'],
      isFree: json['isFree'] ?? 0,
      callable: json['callable'] ?? 0,
    );
  }

  /// 是否可看虚拟视频
  bool get canWatchVirtualVideo => isFree == 1;

  /// 是否可打真实通话
  bool get canCall => callable == 1;

  /// 是否可以操作（看视频或打电话）
  bool get canOperate => canWatchVirtualVideo || canCall;
}

/// 多账号主播信息
class AuvMultiAnchorVo {
  final int userId;        // 用户ID
  final String username;   // 用于显示的UID
  final int userAuth;      // 认证状态，1.待认证主播，2.已认证主播，3.认证失败主播，4.违规主播
  final String nickname;   // 昵称
  final String? portrait;  // 头像
  final String? email;     // 邮箱

  AuvMultiAnchorVo({
    required this.userId,
    required this.username,
    required this.userAuth,
    required this.nickname,
    this.portrait,
    this.email,
  });

  factory AuvMultiAnchorVo.fromJson(Map<String, dynamic> json) {
    return AuvMultiAnchorVo(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      userAuth: json['userAuth'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'],
      email: json['email'],
    );
  }

  /// 认证状态描述
  String get authStatusText {
    switch (userAuth) {
      case 1: return '待认证主播';
      case 2: return '已认证主播';
      case 3: return '认证失败主播';
      case 4: return '违规主播';
      default: return '未知状态';
    }
  }

  /// 是否待认证
  bool get isPending => userAuth == 1;

  /// 是否已认证
  bool get isApproved => userAuth == 2;

  /// 是否认证失败
  bool get isRejected => userAuth == 3;

  /// 是否违规
  bool get isViolated => userAuth == 4;
}

/// 公会登录信息模型
class AuvGuildLoginInfo {
  final int joinStatus;     // 入驻工会状态，0.不能入驻，1.无公会可入驻，2.有公会入驻中，3.有公会已入驻
  final String? inviteCode; // 邀请码
  final String? shareUrl;  // 分享链接
  final String? loginUrl;  // 工会登录地址
  final String? loginToken; // 工会登录token

  AuvGuildLoginInfo({
    required this.joinStatus,
    this.inviteCode,
    this.shareUrl,
    this.loginUrl,
    this.loginToken,
  });

  factory AuvGuildLoginInfo.fromJson(Map<String, dynamic> json) {
    return AuvGuildLoginInfo(
      joinStatus: json['joinStatus'] ?? 0,
      inviteCode: json['inviteCode'],
      shareUrl: json['shareUrl'],
      loginUrl: json['loginUrl'],
      loginToken: json['loginToken'],
    );
  }

  /// 是否不能入驻
  bool get cannotJoin => joinStatus == 0;

  /// 是否无公会可入驻
  bool get noGuild => joinStatus == 1;

  /// 是否有公会入驻中
  bool get isJoining => joinStatus == 2;

  /// 是否有公会已入驻
  bool get isJoined => joinStatus == 3;

  /// 是否会传邀请信息和登录信息
  bool get hasInviteInfo => joinStatus == 3;
}

/// 主播曝光度数据模型
class AuvAnchorExposureModel {
  final int matchLevel;      // 匹配等级，1.极低，2.一般，3.良好，4.优秀，5.顶级
  final double matchScore;   // 匹配通话得分
  final int matchCallCount;  // 本周匹配通话数
  final double matchCallCountOverRate; // 本周匹配通话数超过百分之多少主播
  final int matchCallCoins;  // 本周匹配收益，小数点后两位
  final double matchCallCoinsOverRate; // 本周匹配收益超过百分之多少主播
  final double nci;          // 普通通话得分
  final int normalCallCount; // 本周普通通话数
  final double normalCallCountOverRate; // 本周普通通话数超过百分之多少主播
  final int normalCallDuration; // 本周普通通话时长，单位毫秒数
  final double normalCallDurationOverRate; // 本周普通通话时长超过百分之多少主播
  final String? helpVideoUrl; // 提升曝光度的视频链接

  AuvAnchorExposureModel({
    required this.matchLevel,
    required this.matchScore,
    required this.matchCallCount,
    required this.matchCallCountOverRate,
    required this.matchCallCoins,
    required this.matchCallCoinsOverRate,
    required this.nci,
    required this.normalCallCount,
    required this.normalCallCountOverRate,
    required this.normalCallDuration,
    required this.normalCallDurationOverRate,
    this.helpVideoUrl,
  });

  factory AuvAnchorExposureModel.fromJson(Map<String, dynamic> json) {
    return AuvAnchorExposureModel(
      matchLevel: json['matchLevel'] ?? 1,
      matchScore: (json['matchScore'] ?? 0).toDouble(),
      matchCallCount: json['matchCallCount'] ?? 0,
      matchCallCountOverRate: (json['matchCallCountOverRate'] ?? 0).toDouble(),
      matchCallCoins: json['matchCallCoins'] ?? 0,
      matchCallCoinsOverRate: (json['matchCallCoinsOverRate'] ?? 0).toDouble(),
      nci: (json['nci'] ?? 0).toDouble(),
      normalCallCount: json['normalCallCount'] ?? 0,
      normalCallCountOverRate: (json['normalCallCountOverRate'] ?? 0).toDouble(),
      normalCallDuration: json['normalCallDuration'] ?? 0,
      normalCallDurationOverRate: (json['normalCallDurationOverRate'] ?? 0).toDouble(),
      helpVideoUrl: json['helpVideoUrl'],
    );
  }

  /// 匹配等级描述
  String get matchLevelText {
    switch (matchLevel) {
      case 1: return '极低';
      case 2: return '一般';
      case 3: return '良好';
      case 4: return '优秀';
      case 5: return '顶级';
      default: return '未知';
    }
  }

  /// 匹配通话时长（秒）
  int get normalCallDurationSeconds => normalCallDuration ~/ 1000;

  /// 匹配通话时长（分:秒）
  String get normalCallDurationFormatted {
    final seconds = normalCallDurationSeconds;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// 匹配收益（转换为实际金币数）
  double get matchCallCoinsValue => matchCallCoins / 100;
}

/// 免费匹配主播模型
class AuvFreeMatchAnchorModel {
  final int anchorUserId;  // 主播id
  final int countryCode;   // 国家代码
  final String nickname;   // 昵称
  final String? portrait;  // 头像
  final String? countryPath; // 国旗链接
  final String? countryTitle; // 国家名

  AuvFreeMatchAnchorModel({
    required this.anchorUserId,
    required this.countryCode,
    required this.nickname,
    this.portrait,
    this.countryPath,
    this.countryTitle,
  });

  factory AuvFreeMatchAnchorModel.fromJson(Map<String, dynamic> json) {
    return AuvFreeMatchAnchorModel(
      anchorUserId: json['anchorUserId'] ?? 0,
      countryCode: json['countryCode'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'],
      countryPath: json['countryPath'],
      countryTitle: json['countryTitle'],
    );
  }
}

/// 试播进度明细模型
class AuvTrialProgressDetailModel {
  final String title;  // 描述
  final int flag;       // 完成标识，0.未完成，1.已完成，2.失败

  AuvTrialProgressDetailModel({
    required this.title,
    required this.flag,
  });

  factory AuvTrialProgressDetailModel.fromJson(Map<String, dynamic> json) {
    return AuvTrialProgressDetailModel(
      title: json['title'] ?? '',
      flag: json['flag'] ?? 0,
    );
  }

  /// 是否未完成
  bool get isPending => flag == 0;

  /// 是否已完成
  bool get isCompleted => flag == 1;

  /// 是否失败
  bool get isFailed => flag == 2;
}

/// 主播试播进度模型
class AuvAnchorTrialProgressModel {
  final String? helpVideoUrl;   // 提升曝光度的视频链接
  final int videoFlag;          // 试播视频观看完成标识，0.未完成，1.已完成
  final int examFlag;           // 试播答题完成标识，0.未完成，1.已完成
  final int detailFlag;         // 进度明细完成标识，0.未完成，1.已完成
  final int rewardCoins;        // 试播通过后奖励的金币数，小数点后两位
  final List<AuvTrialProgressDetailModel> details; // 进度明细列表

  AuvAnchorTrialProgressModel({
    this.helpVideoUrl,
    required this.videoFlag,
    required this.examFlag,
    required this.detailFlag,
    required this.rewardCoins,
    required this.details,
  });

  factory AuvAnchorTrialProgressModel.fromJson(Map<String, dynamic> json) {
    return AuvAnchorTrialProgressModel(
      helpVideoUrl: json['helpVideoUrl'],
      videoFlag: json['videoFlag'] ?? 0,
      examFlag: json['examFlag'] ?? 0,
      detailFlag: json['detailFlag'] ?? 0,
      rewardCoins: json['rewardCoins'] ?? 0,
      details: (json['details'] as List?)
              ?.map((e) => AuvTrialProgressDetailModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  /// 试播视频是否已完成
  bool get isVideoCompleted => videoFlag == 1;

  /// 试播答题是否已完成
  bool get isExamCompleted => examFlag == 1;

  /// 进度明细是否已完成
  bool get isDetailsCompleted => detailFlag == 1;

  /// 奖励金币实际值
  double get rewardCoinsValue => rewardCoins / 100;

  /// 试播是否全部完成
  bool get isAllCompleted => isVideoCompleted && isExamCompleted && isDetailsCompleted;
}

/// 主播详情V2
class AuvAnchorExpandV2Model {
  final int userId;
  final String username;
  final String nickname;
  final String portrait;
  final int countryCode;
  final String countryPath;
  final String countryTitle;
  final int userAuth;
  final int userStatus;
  final int isOnline;
  final int sex;
  final String? signature;
  final String? language;

  AuvAnchorExpandV2Model({
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
    this.signature,
    this.language,
  });

  factory AuvAnchorExpandV2Model.fromJson(Map<String, dynamic> json) {
    return AuvAnchorExpandV2Model(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      userAuth: json['userAuth'] ?? 0,
      userStatus: json['userStatus'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      sex: json['sex'] ?? 0,
      signature: json['signature'],
      language: json['language'],
    );
  }
}

/// 主播聊天媒体项
class AuvAnchorChatMediaItem {
  final String? url;
  final int type; // 1: 图片, 2: 视频
  final String? cover;

  AuvAnchorChatMediaItem({
    this.url,
    required this.type,
    this.cover,
  });

  Map<String, dynamic> toJson() => {
        'url': url,
        'type': type,
        'cover': cover,
      };
}

/// 发布动态奖励
class AuvMomentRewardVo {
  final int rewardCoins;
  final int leftTimes;

  AuvMomentRewardVo({
    required this.rewardCoins,
    required this.leftTimes,
  });

  factory AuvMomentRewardVo.fromJson(Map<String, dynamic> json) {
    return AuvMomentRewardVo(
      rewardCoins: json['rewardCoins'] ?? 0,
      leftTimes: json['leftTimes'] ?? 0,
    );
  }
}

/// 解锁私密聊天视频结果
class AuvUnlockPrivacyChatVideoVo {
  final String videoUrl;
  final int diamonds;

  AuvUnlockPrivacyChatVideoVo({
    required this.videoUrl,
    required this.diamonds,
  });

  factory AuvUnlockPrivacyChatVideoVo.fromJson(Map<String, dynamic> json) {
    return AuvUnlockPrivacyChatVideoVo(
      videoUrl: json['videoUrl'] ?? '',
      diamonds: json['diamonds'] ?? 0,
    );
  }
}

/// 高风险类型
enum AuvAnchorFKType {
  privateContent(1, '私密内容'),
  sexualContent(2, '色情内容'),
  violentContent(3, '暴力内容'),
  politicalContent(4, '政治内容'),
  otherContent(5, '其他违规');

  final int value;
  final String desc;
  const AuvAnchorFKType(this.value, this.desc);
}

/// 主播视频价格配置
class AuvAnchorVideoPriceConfigVo {
  final int level;
  final int price;
  final String? description;

  AuvAnchorVideoPriceConfigVo({
    required this.level,
    required this.price,
    this.description,
  });

  factory AuvAnchorVideoPriceConfigVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorVideoPriceConfigVo(
      level: json['level'] ?? 0,
      price: json['price'] ?? 0,
      description: json['description'],
    );
  }
}
