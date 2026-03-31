/// 新手礼包配置
class AuvRegisterRewardConfig {
  final int callCardNum;
  final int matchCardNum;
  final int chatCardNum;
  final double diamonds;

  AuvRegisterRewardConfig({
    required this.callCardNum,
    required this.matchCardNum,
    required this.chatCardNum,
    required this.diamonds,
  });

  factory AuvRegisterRewardConfig.fromJson(Map<String, dynamic> json) {
    return AuvRegisterRewardConfig(
      callCardNum: json['callCardNum'] ?? 0,
      matchCardNum: json['matchCardNum'] ?? 0,
      chatCardNum: json['chatCardNum'] ?? 0,
      diamonds: (json['diamonds'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'callCardNum': callCardNum,
        'matchCardNum': matchCardNum,
        'chatCardNum': chatCardNum,
        'diamonds': diamonds,
      };
}

/// 迁移目标 App 信息
class AuvMigrationInfo {
  final String title;
  final String logo;
  final String downloadUrl;

  AuvMigrationInfo({
    required this.title,
    required this.logo,
    required this.downloadUrl,
  });

  factory AuvMigrationInfo.fromJson(Map<String, dynamic> json) {
    return AuvMigrationInfo(
      title: json['title'] ?? '',
      logo: json['logo'] ?? '',
      downloadUrl: json['downloadUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'logo': logo,
        'downloadUrl': downloadUrl,
      };
}

/// 地区通话补贴配置
class AreaCallConfig {
  final String country;
  final int callCardProfitSeconds;
  final int callCardCoins;

  AreaCallConfig({
    required this.country,
    required this.callCardProfitSeconds,
    required this.callCardCoins,
  });

  factory AreaCallConfig.fromJson(Map<String, dynamic> json) {
    return AreaCallConfig(
      country: json['country'] ?? '',
      callCardProfitSeconds: json['callCardProfitSeconds'] ?? 0,
      callCardCoins: json['callCardCoins'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'country': country,
        'callCardProfitSeconds': callCardProfitSeconds,
        'callCardCoins': callCardCoins,
      };
}

/// 索要配置
class BegConfig {
  final int giftBegMaxCount;
  final int giftBegUserMaxCount;
  final int rechargeBegMaxCount;
  final int rechargeBegUserMaxCount;
  final double begRechargeCoins;

  BegConfig({
    required this.giftBegMaxCount,
    required this.giftBegUserMaxCount,
    required this.rechargeBegMaxCount,
    required this.rechargeBegUserMaxCount,
    required this.begRechargeCoins,
  });

  factory BegConfig.fromJson(Map<String, dynamic> json) {
    return BegConfig(
      giftBegMaxCount: json['giftBegMaxCount'] ?? 0,
      giftBegUserMaxCount: json['giftBegUserMaxCount'] ?? 0,
      rechargeBegMaxCount: json['rechargeBegMaxCount'] ?? 0,
      rechargeBegUserMaxCount: json['rechargeBegUserMaxCount'] ?? 0,
      begRechargeCoins: (json['begRechargeCoins'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'giftBegMaxCount': giftBegMaxCount,
        'giftBegUserMaxCount': giftBegUserMaxCount,
        'rechargeBegMaxCount': rechargeBegMaxCount,
        'rechargeBegUserMaxCount': rechargeBegUserMaxCount,
        'begRechargeCoins': begRechargeCoins,
      };
}

/// 主播私聊奖励配置
class ChatRewardConfig {
  final int chatIntervalMinute;
  final int userTimes;
  final int totalTimes;
  final int coins;

  ChatRewardConfig({
    required this.chatIntervalMinute,
    required this.userTimes,
    required this.totalTimes,
    required this.coins,
  });

  factory ChatRewardConfig.fromJson(Map<String, dynamic> json) {
    return ChatRewardConfig(
      chatIntervalMinute: json['chatIntervalMinute'] ?? 0,
      userTimes: json['userTimes'] ?? 0,
      totalTimes: json['totalTimes'] ?? 0,
      coins: json['coins'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'chatIntervalMinute': chatIntervalMinute,
        'userTimes': userTimes,
        'totalTimes': totalTimes,
        'coins': coins,
      };
}

/// 用户端应用配置
class AuvAppConfigUser {
  final String agoraAppId;
  final AuvRegisterRewardConfig? registerReward;
  final AuvRegisterRewardConfig? bindGoogleReward;
  final AuvRegisterRewardConfig? webSourceReward;
  final AuvMigrationInfo? migrationInfo;
  final double callCardDiamonds;
  final double matchCardDiamonds;
  final double chatCardDiamonds;
  final int callCardSeconds;
  final int matchCardSeconds;
  final int chatCardDays;
  final double callPrice;
  final double matchFirstDiamonds;
  final int coins2Diamonds;
  final int guestRegisterReward;
  final double giftRankTopDiamonds;
  final double privacyChatImgDiamonds;
  final double privacyChatVideoDiamonds;
  final double luckyGiftDiamonds;
  final int deregisterDelaySecond;
  final String? ok;
  final int msgLiveMinLevel;

  AuvAppConfigUser({
    required this.agoraAppId,
    this.registerReward,
    this.bindGoogleReward,
    this.webSourceReward,
    this.migrationInfo,
    required this.callCardDiamonds,
    required this.matchCardDiamonds,
    required this.chatCardDiamonds,
    required this.callCardSeconds,
    required this.matchCardSeconds,
    required this.chatCardDays,
    required this.callPrice,
    required this.matchFirstDiamonds,
    required this.coins2Diamonds,
    required this.guestRegisterReward,
    required this.giftRankTopDiamonds,
    required this.privacyChatImgDiamonds,
    required this.privacyChatVideoDiamonds,
    required this.luckyGiftDiamonds,
    required this.deregisterDelaySecond,
    this.ok,
    required this.msgLiveMinLevel,
  });

  factory AuvAppConfigUser.fromJson(Map<String, dynamic> json) {
    return AuvAppConfigUser(
      agoraAppId: json['agoraAppId'] ?? '',
      registerReward: json['registerReward'] != null
          ? AuvRegisterRewardConfig.fromJson(json['registerReward'])
          : null,
      bindGoogleReward: json['bindGoogleReward'] != null
          ? AuvRegisterRewardConfig.fromJson(json['bindGoogleReward'])
          : null,
      webSourceReward: json['webSourceReward'] != null
          ? AuvRegisterRewardConfig.fromJson(json['webSourceReward'])
          : null,
      migrationInfo: json['migrationInfo'] != null
          ? AuvMigrationInfo.fromJson(json['migrationInfo'])
          : null,
      callCardDiamonds: (json['callCardDiamonds'] ?? 0).toDouble(),
      matchCardDiamonds: (json['matchCardDiamonds'] ?? 0).toDouble(),
      chatCardDiamonds: (json['chatCardDiamonds'] ?? 0).toDouble(),
      callCardSeconds: json['callCardSeconds'] ?? 0,
      matchCardSeconds: json['matchCardSeconds'] ?? 0,
      chatCardDays: json['chatCardDays'] ?? 0,
      callPrice: (json['callPrice'] ?? 0).toDouble(),
      matchFirstDiamonds: (json['matchFirstDiamonds'] ?? 0).toDouble(),
      coins2Diamonds: json['coins2Diamonds'] ?? 0,
      guestRegisterReward: json['guestRegisterReward'] ?? 0,
      giftRankTopDiamonds: (json['giftRankTopDiamonds'] ?? 0).toDouble(),
      privacyChatImgDiamonds: (json['privacyChatImgDiamonds'] ?? 0).toDouble(),
      privacyChatVideoDiamonds: (json['privacyChatVideoDiamonds'] ?? 0).toDouble(),
      luckyGiftDiamonds: (json['luckyGiftDiamonds'] ?? 0).toDouble(),
      deregisterDelaySecond: json['deregisterDelaySecond'] ?? 0,
      ok: json['ok'],
      msgLiveMinLevel: json['msgLiveMinLevel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'agoraAppId': agoraAppId,
        if (registerReward != null) 'registerReward': registerReward!.toJson(),
        if (bindGoogleReward != null) 'bindGoogleReward': bindGoogleReward!.toJson(),
        if (webSourceReward != null) 'webSourceReward': webSourceReward!.toJson(),
        if (migrationInfo != null) 'migrationInfo': migrationInfo!.toJson(),
        'callCardDiamonds': callCardDiamonds,
        'matchCardDiamonds': matchCardDiamonds,
        'chatCardDiamonds': chatCardDiamonds,
        'callCardSeconds': callCardSeconds,
        'matchCardSeconds': matchCardSeconds,
        'chatCardDays': chatCardDays,
        'callPrice': callPrice,
        'matchFirstDiamonds': matchFirstDiamonds,
        'coins2Diamonds': coins2Diamonds,
        'guestRegisterReward': guestRegisterReward,
        'giftRankTopDiamonds': giftRankTopDiamonds,
        'privacyChatImgDiamonds': privacyChatImgDiamonds,
        'privacyChatVideoDiamonds': privacyChatVideoDiamonds,
        'luckyGiftDiamonds': luckyGiftDiamonds,
        'deregisterDelaySecond': deregisterDelaySecond,
        if (ok != null) 'ok': ok,
        'msgLiveMinLevel': msgLiveMinLevel,
      };
}

/// 主播端应用配置
class AuvAppConfigAnchor {
  final String agoraAppId;
  final int msgReplyMaxCount;
  final double privacyChatImgCoins;
  final double privacyChatVideoCoins;
  final int reportFlag;
  final AreaCallConfig? areaCall;
  final BegConfig? beg;
  final ChatRewardConfig? chatReward;
  final int deregisterDelaySecond;
  final int liveSwitch;
  final int liveFirstMinutes;

  AuvAppConfigAnchor({
    required this.agoraAppId,
    required this.msgReplyMaxCount,
    required this.privacyChatImgCoins,
    required this.privacyChatVideoCoins,
    required this.reportFlag,
    this.areaCall,
    this.beg,
    this.chatReward,
    required this.deregisterDelaySecond,
    required this.liveSwitch,
    required this.liveFirstMinutes,
  });

  factory AuvAppConfigAnchor.fromJson(Map<String, dynamic> json) {
    return AuvAppConfigAnchor(
      agoraAppId: json['agoraAppId'] ?? '',
      msgReplyMaxCount: json['msgReplyMaxCount'] ?? 0,
      privacyChatImgCoins: (json['privacyChatImgCoins'] ?? 0).toDouble(),
      privacyChatVideoCoins: (json['privacyChatVideoCoins'] ?? 0).toDouble(),
      reportFlag: json['reportFlag'] ?? 0,
      areaCall: json['areaCall'] != null
          ? AreaCallConfig.fromJson(json['areaCall'])
          : null,
      beg: json['beg'] != null ? BegConfig.fromJson(json['beg']) : null,
      chatReward: json['chatReward'] != null
          ? ChatRewardConfig.fromJson(json['chatReward'])
          : null,
      deregisterDelaySecond: json['deregisterDelaySecond'] ?? 0,
      liveSwitch: json['liveSwitch'] ?? 0,
      liveFirstMinutes: json['liveFirstMinutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'agoraAppId': agoraAppId,
        'msgReplyMaxCount': msgReplyMaxCount,
        'privacyChatImgCoins': privacyChatImgCoins,
        'privacyChatVideoCoins': privacyChatVideoCoins,
        'reportFlag': reportFlag,
        if (areaCall != null) 'areaCall': areaCall!.toJson(),
        if (beg != null) 'beg': beg!.toJson(),
        if (chatReward != null) 'chatReward': chatReward!.toJson(),
        'deregisterDelaySecond': deregisterDelaySecond,
        'liveSwitch': liveSwitch,
        'liveFirstMinutes': liveFirstMinutes,
      };

  bool get isLiveEnabled => liveSwitch == 1;
}
