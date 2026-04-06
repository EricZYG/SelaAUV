/// 签到奖励类型枚举
/// 对应后台 SigInRewardType
/// 
/// 请使用 auv_sign_in_reward_type.dart 中的 AuvSignInRewardType
export 'auv_sign_in_reward_type.dart';

import 'auv_sign_in_reward_type.dart';

/// 签到每日奖励项响应模型
/// 
/// 对应签到奖励列表中的单个奖励项
class AuvSignInDailySubVo {
  /// 奖品id
  final int id;

  /// 奖品名称
  final String name;

  /// 奖品图标
  final String? icon;

  /// 国家编码
  final int countryCode;

  /// 签到奖品类型
  /// - 1.钻石
  /// - 2.视频卡
  /// - 3.匹配卡
  /// - 4.聊天卡
  final int rewardType;

  /// 奖品数量
  final int rewardValue;

  /// 签到天数
  final int signDay;

  AuvSignInDailySubVo({
    required this.id,
    required this.name,
    this.icon,
    required this.countryCode,
    required this.rewardType,
    required this.rewardValue,
    required this.signDay,
  });

  factory AuvSignInDailySubVo.fromJson(Map<String, dynamic> json) {
    return AuvSignInDailySubVo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'],
      countryCode: json['countryCode'] ?? 0,
      rewardType: json['rewardType'] ?? 0,
      rewardValue: json['rewardValue'] ?? 0,
      signDay: json['signDay'] ?? 0,
    );
  }

  /// 获取奖励类型枚举
  AuvSignInRewardType? get rewardTypeEnum => AuvSignInRewardType.fromValue(rewardType);

  /// 奖励类型描述
  String get rewardTypeDesc {
    switch (rewardType) {
      case 1:
        return '钻石';
      case 2:
        return '视频卡';
      case 3:
        return '匹配卡';
      case 4:
        return '聊天卡';
      default:
        return '未知';
    }
  }

  /// 奖励描述（包含数量）
  String get rewardDesc {
    switch (rewardType) {
      case 1:
        return '钻石 $rewardValue';
      case 2:
        return '视频卡 x$rewardValue';
      case 3:
        return '匹配卡 x$rewardValue';
      case 4:
        return '聊天卡 x$rewardValue';
      default:
        return '$name x$rewardValue';
    }
  }
}

/// 签到数据响应模型
/// 
/// 对应接口: /user/sign/getSignInVo
/// 
/// 获取每日签到的相关信息和奖励列表
class AuvSignInVoResponse {
  /// 此刻待签到的天数
  /// - =7 时 表示前6天全签到了 前6天置灰
  /// - =0 时 表示7天全部签了 全部置灰
  final int signDay;

  /// 此刻是否需要签到
  /// - true 需要签到
  /// - false 不需要签到
  final bool signFlag;

  /// 下一次倒计时时间
  final int nexTimes;

  /// 奖励列表
  final List<AuvSignInDailySubVo> rewardList;

  AuvSignInVoResponse({
    required this.signDay,
    required this.signFlag,
    required this.nexTimes,
    required this.rewardList,
  });

  factory AuvSignInVoResponse.fromJson(Map<String, dynamic> json) {
    return AuvSignInVoResponse(
      signDay: json['signDay'] ?? 0,
      signFlag: json['signFlag'] ?? false,
      nexTimes: json['nexTimes'] ?? 0,
      rewardList: (json['rewardList'] as List?)
              ?.map((e) => AuvSignInDailySubVo.fromJson(e))
              .toList() ??
          [],
    );
  }

  /// 是否需要签到
  bool get needsSignIn => signFlag;

  /// 是否全部签完（7天全签）
  bool get isAllSigned => signDay == 0;

  /// 是否首日待签
  bool get isFirstDayPending => signDay == 7;

  /// 获取第N天的奖励
  AuvSignInDailySubVo? getRewardForDay(int day) {
    return rewardList.where((r) => r.signDay == day).firstOrNull;
  }

  /// 获取奖励总览描述
  String get rewardSummary {
    final diamondCount = rewardList.where((r) => r.rewardType == 1).fold(0, (sum, r) => sum + r.rewardValue);
    final callCardCount = rewardList.where((r) => r.rewardType == 2).fold(0, (sum, r) => sum + r.rewardValue);
    final matchCardCount = rewardList.where((r) => r.rewardType == 3).fold(0, (sum, r) => sum + r.rewardValue);
    final chatCardCount = rewardList.where((r) => r.rewardType == 4).fold(0, (sum, r) => sum + r.rewardValue);

    final parts = <String>[];
    if (diamondCount > 0) parts.add('钻石 $diamondCount');
    if (callCardCount > 0) parts.add('视频卡 $callCardCount');
    if (matchCardCount > 0) parts.add('匹配卡 $matchCardCount');
    if (chatCardCount > 0) parts.add('聊天卡 $chatCardCount');

    return parts.isEmpty ? '无奖励' : parts.join(' | ');
  }
}
