/// 用户简要信息模型
///
/// 获取对方简要信息接口返回的数据
library;

import 'auv_level_config_response.dart';

/// 字段说明:
/// - userId: 用户ID
/// - username: 用于显示的UID
/// - nickname: 用户昵称
/// - srcNickname: 原昵称
/// - portrait: 头像
/// - isOnline: 是否在线，0.离线，1.在线，2.忙线
/// - vipEndTime: vip结束时间
/// - levelConfig: 等级信息
/// - totalRecharge: 总充值额，分
/// - isAdvanceUser: 是否是高级用户 0 否 1是
/// - sendMsgPrice: 发消息扣除钻石数，小数点后两位
/// - sendMsgFlag: 发消息是否免费，true 表示免费聊天 false 表示需要付费扣钻
/// - followFlag: 是否关注 0双方都未关注 1我未关注&对方已回关 2我已关注&对方未回关 3好友
class AuvUserSimpleResponse {
  /// 用户ID
  final int? userId;

  /// 用于显示的UID
  final String? username;

  /// 用户昵称
  final String? nickname;

  /// 原昵称
  final String? srcNickname;

  /// 头像
  final String? portrait;

  /// 是否在线，0.离线，1.在线，2.忙线
  final int? isOnline;

  /// vip结束时间
  final int? vipEndTime;

  /// 等级信���
  final AuvLevelConfigResponse? levelConfig;

  /// 总充值额，分
  final int? totalRecharge;

  /// 是否是高级用户 0 否 1是
  final int? isAdvanceUser;

  /// 发消息扣除钻石数，小数点后两位
  final int? sendMsgPrice;

  /// 发消息是否免费，true 表示免费聊天 false 表示需要付费扣钻
  final bool? sendMsgFlag;

  /// 是否关注
  /// 0.双方都未关注
  /// 1.我未关注&对方已回关
  /// 2.我已关注&对方未回关
  /// 3.好友
  final int? followFlag;

  AuvUserSimpleResponse({
    this.userId,
    this.username,
    this.nickname,
    this.srcNickname,
    this.portrait,
    this.isOnline,
    this.vipEndTime,
    this.levelConfig,
    this.totalRecharge,
    this.isAdvanceUser,
    this.sendMsgPrice,
    this.sendMsgFlag,
    this.followFlag,
  });

  factory AuvUserSimpleResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvUserSimpleResponse();
    return AuvUserSimpleResponse(
      userId: json['userId'],
      username: json['username'],
      nickname: json['nickname'],
      srcNickname: json['srcNickname'],
      portrait: json['portrait'],
      isOnline: json['isOnline'],
      vipEndTime: json['vipEndTime'],
      levelConfig: json['levelConfig'] != null
          ? AuvLevelConfigResponse.fromJson(json['levelConfig'])
          : null,
      totalRecharge: json['totalRecharge'],
      isAdvanceUser: json['isAdvanceUser'],
      sendMsgPrice: json['sendMsgPrice'],
      sendMsgFlag: json['sendMsgFlag'],
      followFlag: json['followFlag'],
    );
  }

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否VIP用户
  bool get isVip {
    if (vipEndTime == null || vipEndTime == 0) return false;
    return vipEndTime! > DateTime.now().millisecondsSinceEpoch;
  }

  /// 是否高级用户
  bool get isAdvance => isAdvanceUser == 1;

  /// 是否好友
  bool get isFriend => followFlag == 3;

  /// 是否关注对方
  bool get isFollowing => followFlag == 2 || followFlag == 3;

  /// 获取在线状态描述
  String get onlineStatusDesc {
    switch (isOnline) {
      case 0:
        return '离线';
      case 1:
        return '在线';
      case 2:
        return '忙线';
      default:
        return '未知';
    }
  }

  /// 获取关注状态描述
  String get followFlagDesc {
    switch (followFlag) {
      case 0:
        return '互未关注';
      case 1:
        return '已回关';
      case 2:
        return '已关注';
      case 3:
        return '好友';
      default:
        return '未知';
    }
  }
}