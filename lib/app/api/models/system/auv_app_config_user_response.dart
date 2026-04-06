import 'auv_app_config_reward_response.dart';
import 'auv_app_config_migration_response.dart';
import 'auv_app_config_face_verify_response.dart';
import 'auv_app_config_chat_translate_response.dart';

/// 获取应用配置 - 完整版响应模型
///
/// GET /system/app/getConfig
///
/// 可登录可不登录，登录返回数据可能有变化
///
/// 包含声网配置、礼包配置、道具价格、隐私聊天价格等全部字段
///
/// 字段说明:
/// - agoraAppId: 声网appId
/// - registerReward: 新手礼包配置
/// - bindGoogleReward: 绑定谷歌账号礼包配置
/// - webSourceReward: web引导下载App礼包配置（可能为空）
/// - migrationInfo: 迁移目标app（可能为空）
/// - callCardDiamonds: 视频卡价值
/// - matchCardDiamonds: 匹配卡价值
/// - chatCardDiamonds: 聊天卡价值
/// - callCardSeconds: 视频卡可用秒数
/// - matchCardSeconds: 匹配卡可用秒数
/// - chatCardDays: 聊天卡可用天数
/// - callPrice: 主播每分钟通话最低钻石数
/// - matchFirstDiamonds: 匹配/aib首次消费钻石数
/// - coins2Diamonds: 金币兑换钻石比例
/// - guestRegisterReward: 游客送新手礼包开关，0=关闭，1=开启
/// - giftRankTopDiamonds: 送礼榜单置顶钻石数
/// - privacyChatImgDiamonds: 解锁私密聊天图片钻石数
/// - privacyChatVideoDiamonds: 解锁私密聊天视频钻石数
/// - luckyGiftDiamonds: 送幸运礼物扣除的钻石数
/// - deregisterDelaySecond: 注销延迟时间（秒）
/// - ok: 下单签名密钥
/// - msgLiveMinLevel: 直播间只有等级大于等于x级的用户才能发送消息
/// - appLogo: 应用图标地址
/// - gameNotification: 游戏通知配置，格式 "min,interval,count"
/// - pddDialogDisplay: pdd弹窗配置，格式 "a,b,c,d,e,f"
/// - pddDialogDisplay1: pdd弹窗配置1，格式 "a,b,c,d,e,f"
/// - pddDialogDisplay2: pdd弹窗配置2，格式 "a,b,c,d,e,f"
/// - isMustInputInviteCode: 是否强制填写邀请码，flase=否，true=是
/// - versionUpdate: 版本更新配置，格式 "minVersion,maxVersion"
/// - sayHiTime: 打招呼时间配置，格式 "total,interval"，单位秒
/// - liveUrl: 直播间URL地址
/// - matchFreeCallState: 匹配免费通话状态，1=开启
/// - inviteRewardUrl: 邀请奖励页面URL
/// - liveAutoGame: 直播间自动游戏开关，1=开启
/// - freeUserShowPrice: 免费用户显示价格，0=免费
/// - aiHelpUrl: AI帮助页面URL
/// - homeSwitchCountry: 首页切换国家开关，0=关闭
/// - proVersionUrl: 专业版下载URL
/// - supportAgentCountry: 支持代聊的国家代码列表，逗号分隔
/// - videoChatFaceVerifyConfig: 视频通话人脸验证配置（JSON字符串）
/// - chatTranslateConfig: 聊天翻译配置（JSON字符串）
class AuvAppConfigUserResponse {
  /// 声网appId
  final String? agoraAppId;

  /// 新手礼包配置
  final AuvAppConfigRewardResponse? registerReward;

  /// 绑定谷歌账号礼包配置
  final AuvAppConfigRewardResponse? bindGoogleReward;

  /// web引导下载App礼包配置（可能为空）
  final AuvAppConfigRewardResponse? webSourceReward;

  /// 迁移目标app（可能为空）
  final AuvAppConfigMigrationResponse? migrationInfo;

  /// 视频卡价值，小数点后两位
  final double? callCardDiamonds;

  /// 匹配卡价值，小数点后两位
  final double? matchCardDiamonds;

  /// 聊天卡价值，小数点后两位
  final double? chatCardDiamonds;

  /// 视频卡可用秒数
  final int? callCardSeconds;

  /// 匹配卡可用秒数
  final int? matchCardSeconds;

  /// 聊天卡可用天数
  final int? chatCardDays;

  /// 主播每分钟通话最低钻石数，小数点后两位
  final double? callPrice;

  /// 匹配/aib首次消费钻石数，小数点后两位
  final double? matchFirstDiamonds;

  /// 金币兑换钻石比例，10表示1金币:10钻石
  final int? coins2Diamonds;

  /// 游客送新手礼包开关，0=关闭，1=开启
  final int? guestRegisterReward;

  /// 送礼榜单置顶钻石数，小数点后两位
  final double? giftRankTopDiamonds;

  /// 解锁私密聊天图片钻石数，小数点后两位
  final double? privacyChatImgDiamonds;

  /// 解锁私密聊天视频钻石数，小数点后两位
  final double? privacyChatVideoDiamonds;

  /// 送幸运礼物扣除的钻石数，小数点后两位
  final double? luckyGiftDiamonds;

  /// 注销延迟时间（秒）
  final int? deregisterDelaySecond;

  /// 下单签名密钥
  final String? ok;

  /// 直播间只有等级大于等于x级的用户才能发送消息
  final int? msgLiveMinLevel;

  /// 应用图标地址
  final String? appLogo;

  /// 游戏通知配置，格式 "min,interval,count"
  final String? gameNotification;

  ///note pdd弹窗配置，格式 "a,b,c,d,e,f"
  final String? pddDialogDisplay;

  ///note pdd弹窗配置1，格式 "a,b,c,d,e,f"
  final String? pddDialogDisplay1;

  ///note  pdd弹窗配置2，格式 "a,b,c,d,e,f"
  final String? pddDialogDisplay2;

  /// 是否强制填写邀请码，flase=否，true=是
  final String? isMustInputInviteCode;

  /// 版本更新配置，格式 "minVersion,maxVersion"
  final String? versionUpdate;

  /// 打招呼时间配置，格式 "total,interval"，单位秒  180,60
  final String? sayHiTime;

  /// 直播间URL地址
  final String? liveUrl;

  /// 匹配免费通话状态，1=开启
  final String? matchFreeCallState;

  /// 邀请奖励页面URL
  final String? inviteRewardUrl;

  /// 直播间自动游戏开关，1=开启
  final String? liveAutoGame;

  /// 免费用户显示价格，0=免费
  final String? freeUserShowPrice;

  /// AI帮助页面URL
  final String? aiHelpUrl;

  ///note 首页切换国家开关，0=关闭
  final String? homeSwitchCountry;

  /// 专业版下载URL
  final String? proVersionUrl;

  /// note 支持代聊的国家代码列表，逗号分隔
  final String? supportAgentCountry;

  /// note 视频通话人脸验证配置（JSON字符串）
  final String? videoChatFaceVerifyConfig;

  /// note 聊天翻译配置（JSON字符串）
  final String? chatTranslateConfig;

  /// 视频通话人脸验证配置（解析后的对象）
  AuvAppConfigFaceVerifyResponse? get videoChatFaceVerify =>
      AuvAppConfigFaceVerifyResponse.fromJsonString(videoChatFaceVerifyConfig);

  /// 聊天翻译配置（解析后的对象）
  AuvAppConfigChatTranslateResponse? get chatTranslate =>
      AuvAppConfigChatTranslateResponse.fromJsonString(chatTranslateConfig);

  AuvAppConfigUserResponse({
    this.agoraAppId,
    this.registerReward,
    this.bindGoogleReward,
    this.webSourceReward,
    this.migrationInfo,
    this.callCardDiamonds,
    this.matchCardDiamonds,
    this.chatCardDiamonds,
    this.callCardSeconds,
    this.matchCardSeconds,
    this.chatCardDays,
    this.callPrice,
    this.matchFirstDiamonds,
    this.coins2Diamonds,
    this.guestRegisterReward,
    this.giftRankTopDiamonds,
    this.privacyChatImgDiamonds,
    this.privacyChatVideoDiamonds,
    this.luckyGiftDiamonds,
    this.deregisterDelaySecond,
    this.ok,
    this.msgLiveMinLevel,
    this.appLogo,
    this.gameNotification,
    this.pddDialogDisplay,
    this.pddDialogDisplay1,
    this.pddDialogDisplay2,
    this.isMustInputInviteCode,
    this.versionUpdate,
    this.sayHiTime,
    this.liveUrl,
    this.matchFreeCallState,
    this.inviteRewardUrl,
    this.liveAutoGame,
    this.freeUserShowPrice,
    this.aiHelpUrl,
    this.homeSwitchCountry,
    this.proVersionUrl,
    this.supportAgentCountry,
    this.videoChatFaceVerifyConfig,
    this.chatTranslateConfig,
  });

  factory AuvAppConfigUserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAppConfigUserResponse();
    return AuvAppConfigUserResponse(
      agoraAppId: json['agoraAppId'],
      registerReward: AuvAppConfigRewardResponse.fromJson(json['registerReward']),
      bindGoogleReward: AuvAppConfigRewardResponse.fromJson(json['bindGoogleReward']),
      webSourceReward: AuvAppConfigRewardResponse.fromJson(json['webSourceReward']),
      migrationInfo: AuvAppConfigMigrationResponse.fromJson(json['migrationInfo']),
      callCardDiamonds: _parseDouble(json['callCardDiamonds']),
      matchCardDiamonds: _parseDouble(json['matchCardDiamonds']),
      chatCardDiamonds: _parseDouble(json['chatCardDiamonds']),
      callCardSeconds: json['callCardSeconds'],
      matchCardSeconds: json['matchCardSeconds'],
      chatCardDays: json['chatCardDays'],
      callPrice: _parseDouble(json['callPrice']),
      matchFirstDiamonds: _parseDouble(json['matchFirstDiamonds']),
      coins2Diamonds: json['coins2Diamonds'],
      guestRegisterReward: json['guestRegisterReward'],
      giftRankTopDiamonds: _parseDouble(json['giftRankTopDiamonds']),
      privacyChatImgDiamonds: _parseDouble(json['privacyChatImgDiamonds']),
      privacyChatVideoDiamonds: _parseDouble(json['privacyChatVideoDiamonds']),
      luckyGiftDiamonds: _parseDouble(json['luckyGiftDiamonds']),
      deregisterDelaySecond: json['deregisterDelaySecond'],
      ok: json['ok'],
      msgLiveMinLevel: json['msgLiveMinLevel'],
      appLogo: json['appLogo'],
      gameNotification: json['gameNotification'],
      pddDialogDisplay: json['pddDialogDisplay'],
      pddDialogDisplay1: json['pddDialogDisplay1'],
      pddDialogDisplay2: json['pddDialogDisplay2'],
      isMustInputInviteCode: json['isMustInputInviteCode'],
      versionUpdate: json['versionUpdate'],
      sayHiTime: json['sayHiTime'],
      liveUrl: json['liveUrl'],
      matchFreeCallState: json['matchFreeCallState'],
      inviteRewardUrl: json['inviteRewardUrl'],
      liveAutoGame: json['liveAutoGame'],
      freeUserShowPrice: json['freeUserShowPrice'],
      aiHelpUrl: json['aiHelpUrl'],
      homeSwitchCountry: json['homeSwitchCountry'],
      proVersionUrl: json['proVersionUrl'],
      supportAgentCountry: json['supportAgentCountry'],
      videoChatFaceVerifyConfig: json['videoChatFaceVerifyConfig'],
      chatTranslateConfig: json['chatTranslateConfig'],
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
