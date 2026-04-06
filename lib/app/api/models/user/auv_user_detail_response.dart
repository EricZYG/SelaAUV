import 'package:slea_auv/app/api/models/auv_user_media_model.dart';
import 'package:slea_auv/app/api/models/auv_user_model.dart';

/// 我的页面用户详情响应模型
///
/// 对应接口: /user/user/getUserDetail
///
/// 获取当前登录用户的详细信息，包含金币余额、VIP状态、道具背包等
class AuvUserDetailResponse {
  /// 用户ID
  final int userId;

  /// 用于显示的UID
  final String username;

  /// 国家编码
  final int countryCode;

  /// 国旗链接
  final String countryPath;

  /// 国家名
  final String countryTitle;

  /// 国家子编码 ISO 3166-2
  final String countrySubCode;

  /// 认证状态
  /// - 0.男用户
  /// - 1.待认证主播
  /// - 2.已认证主播
  /// - 3.认证失败主播
  /// - 4.违规主播
  final int userAuth;

  /// 是否在线
  /// - 0.离线
  /// - 1.在线
  /// - 2.忙线
  final int isOnline;

  /// 勿扰标识
  /// - 0.正常
  /// - 1.勿扰
  final int disturbFlag;

  /// 用户昵称
  final String nickname;

  /// 头像
  final String portrait;

  /// VIP结束时间（毫秒时间戳）
  final int vipEndTime;

  /// 充值总金额（美分）
  final int totalRecharge;

  /// 剩余钻石
  final int remainDiamonds;

  /// 用户等级
  final int userLevel;

  /// 生日（毫秒时间戳）
  final int birthday;

  /// 是否审核模式
  /// - 0.否
  /// - 1.是
  final int rflag;

  /// 是否送了新人礼包
  /// - 0.否
  /// - 1.是
  final int registerRewardFlag;

  /// 是否已签到
  /// - 0.否
  /// - 1.是
  final int signFlag;

  /// VIP特权是否已领取
  /// - 0.否
  /// - 1.是
  final int vipSignFlag;

  /// 是否已绑定Google
  /// - 0.否
  /// - 1.是
  final int boundGoogle;

  /// 是否已设置过密码
  /// - 0.否
  /// - 1.是
  final int hasPassword;

  /// 设备是否已充值（不算VIP充值）
  /// - 0.否
  /// - 1.是
  final int rechargeFlag;

  /// 是否多账号
  /// - 0.否
  /// - 1.是
  final int multiUser;

  /// 是否是今日注册的账号
  /// - 0.否
  /// - 1.是
  final int todayUser;

  /// 是否有待领取的分次优惠订单
  /// - 0.否
  /// - 1.是
  final int hasSplitOrder;

  /// 分次优惠当天是否可领取
  /// - 0.否
  /// - 1.是
  final int hasPendingSplit;

  /// 是否真人
  /// - false.否
  /// - true.是
  final bool faceFlag;

  /// 是否展示新手引导
  /// - 0.不展示
  /// - 1.展示
  final int showGuild;

  /// 推送开关
  /// - 0.关闭
  /// - 1.开启
  final int notifyFlag;

  /// 敏感提示开关
  /// - 0.关闭
  /// - 1.开启
  final int sexyTipFlag;

  /// 敏感动态展示开关
  /// - 0.关闭
  /// - 1.开启
  final int sexyMomentFlag;

  /// 是否满18岁
  /// - 0.否
  /// - 1.是
  final int isAdult;

  /// 是否已上报注册事件
  /// - 0.否
  /// - 1.是
  final int registerReportFlag;

  /// 注册时间（毫秒时间戳）
  final int createdAt;

  /// 首次付费时间（毫秒时间戳）
  final int firstPaidTime;

  /// 是否设置过性别
  /// - 0.否
  /// - 1.是
  final int sexSelected;

  /// 用户是否已转工会
  /// - 0.否
  /// - 1.是
  final int userGuildFlag;

  /// 剩余金币
  final int remainCoins;

  /// 货币编码
  final String currencyCode;

  /// 等级配置
  final AuvUserLevelConfig? levelConfig;

  /// 背包道具列表
  final List<AuvUserPropVo> propVoList;

  /// 【遗漏】VIP标识
  final bool vipFlag;

  /// 【遗漏】个人签名
  final String signature;

  AuvUserDetailResponse({
    required this.userId,
    required this.username,
    required this.countryCode,
    required this.countryPath,
    required this.countryTitle,
    required this.countrySubCode,
    required this.userAuth,
    required this.isOnline,
    required this.disturbFlag,
    required this.nickname,
    required this.portrait,
    required this.vipEndTime,
    required this.totalRecharge,
    required this.remainDiamonds,
    required this.userLevel,
    required this.birthday,
    required this.rflag,
    required this.registerRewardFlag,
    required this.signFlag,
    required this.vipSignFlag,
    required this.boundGoogle,
    required this.hasPassword,
    required this.rechargeFlag,
    required this.multiUser,
    required this.todayUser,
    required this.hasSplitOrder,
    required this.hasPendingSplit,
    required this.faceFlag,
    required this.showGuild,
    required this.notifyFlag,
    required this.sexyTipFlag,
    required this.sexyMomentFlag,
    required this.isAdult,
    required this.registerReportFlag,
    required this.createdAt,
    required this.firstPaidTime,
    required this.sexSelected,
    required this.userGuildFlag,
    required this.remainCoins,
    required this.currencyCode,
    this.levelConfig,
    required this.propVoList,
    this.vipFlag = false,
    this.signature = '',
  });

  factory AuvUserDetailResponse.fromJson(Map<String, dynamic> json) {
    return AuvUserDetailResponse(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      countrySubCode: json['countrySubCode'] ?? '',
      userAuth: json['userAuth'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      disturbFlag: json['disturbFlag'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      vipEndTime: json['vipEndTime'] ?? 0,
      totalRecharge: json['totalRecharge'] ?? 0,
      remainDiamonds: json['remainDiamonds'] ?? 0,
      userLevel: json['userLevel'] ?? 0,
      birthday: json['birthday'] ?? 0,
      rflag: json['rflag'] ?? 0,
      registerRewardFlag: json['registerRewardFlag'] ?? 0,
      signFlag: json['signFlag'] ?? 0,
      vipSignFlag: json['vipSignFlag'] ?? 0,
      boundGoogle: json['boundGoogle'] ?? 0,
      hasPassword: json['hasPassword'] ?? 0,
      rechargeFlag: json['rechargeFlag'] ?? 0,
      multiUser: json['multiUser'] ?? 0,
      todayUser: json['todayUser'] ?? 0,
      hasSplitOrder: json['hasSplitOrder'] ?? 0,
      hasPendingSplit: json['hasPendingSplit'] ?? 0,
      faceFlag: json['faceFlag'] ?? false,
      showGuild: json['showGuild'] ?? 0,
      notifyFlag: json['notifyFlag'] ?? 0,
      sexyTipFlag: json['sexyTipFlag'] ?? 0,
      sexyMomentFlag: json['sexyMomentFlag'] ?? 0,
      isAdult: json['isAdult'] ?? 0,
      registerReportFlag: json['registerReportFlag'] ?? 0,
      createdAt: json['createdAt'] ?? 0,
      firstPaidTime: json['firstPaidTime'] ?? 0,
      sexSelected: json['sexSelected'] ?? 0,
      userGuildFlag: json['userGuildFlag'] ?? 0,
      remainCoins: json['remainCoins'] ?? 0,
      currencyCode: json['currencyCode'] ?? 'USD',
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      propVoList: (json['propVoList'] as List?)
              ?.map((e) => AuvUserPropVo.fromJson(e))
              .toList() ??
          [],
      vipFlag: json['vipFlag'] ?? false,
      signature: json['signature'] ?? '',
    );
  }

  /// 是否VIP
  bool get isVip => vipEndTime > 0 && DateTime.now().millisecondsSinceEpoch < vipEndTime;

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

  /// 是否在线
  bool get isOnlineUser => isOnline == 1;

  /// 是否审核模式
  bool get isReviewMode => rflag == 1;

  /// 是否今日注册
  bool get isTodayRegistered => todayUser == 1;

  /// 是否多账号
  bool get isMultiUser => multiUser == 1;

  /// 是否已转工会
  bool get hasJoinedGuild => userGuildFlag == 1;

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

  /// 获取生日
  DateTime? get birthdayDateTime {
    if (birthday <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(birthday);
  }

  /// 是否男用户
  bool get isMaleUser => userAuth == 0;

  /// 是否待认证主播
  bool get isPendingAnchor => userAuth == 1;

  /// 是否已认证主播
  bool get isCertifiedAnchor => userAuth == 2;

  /// 是否认证失败主播
  bool get isFailedAnchor => userAuth == 3;

  /// 是否违规主播
  bool get isViolatedAnchor => userAuth == 4;

  /// 是否主播（待认证、已认证、认证失败、违规都算主播）
  bool get isAnchor => userAuth >= 1 && userAuth <= 4;

  /// 根据 propType 获取道具数量
  /// [propType] 道具类型：1.视频卡，2.钻石加成卡，3.礼物卡，4.聊天卡，5.匹配卡，6.头像框
  int getPropCount(int propType) {
    final prop = propVoList.firstWhere(
      (p) => p.propType == propType,
      orElse: () => AuvUserPropVo(
        userId: 0,
        propType: propType,
        propValue: 0,
        propNum: 0,
      ),
    );
    return prop.propNum;
  }
}
