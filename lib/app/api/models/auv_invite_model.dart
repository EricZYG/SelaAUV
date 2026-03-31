import '../enums/auv_invite.dart';

/// 邀请奖励类型
enum AuvInviteRewardType {
  register(1),  // 注册奖励
  recharge(2);  // 充值奖励

  final int value;
  const AuvInviteRewardType(this.value);

  static AuvInviteRewardType fromValue(int value) {
    return AuvInviteRewardType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvInviteRewardType.register,
    );
  }

  String get displayName {
    switch (this) {
      case AuvInviteRewardType.register:
        return '注册奖励';
      case AuvInviteRewardType.recharge:
        return '充值奖励';
    }
  }
}

/// 邀请用户记录项
class AuvInviteUserItem {
  final int inviteeUserId;          // 被邀请用户ID
  final String nickname;            // 昵称
  final String portrait;            // 头像URL
  final int createdAt;             // 创建时间戳
  final AuvInviteRewardType type;     // 奖励类型
  final int reward;                // 奖励钻石数（实际值 x100）

  AuvInviteUserItem({
    required this.inviteeUserId,
    required this.nickname,
    required this.portrait,
    required this.createdAt,
    required this.type,
    required this.reward,
  });

  factory AuvInviteUserItem.fromJson(Map<String, dynamic> json) {
    return AuvInviteUserItem(
      inviteeUserId: json['inviteeUserId'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      createdAt: json['createdAt'] ?? 0,
      type: AuvInviteRewardType.fromValue(json['type'] ?? 1),
      reward: json['reward'] ?? 0,
    );
  }

  /// 获取格式化的时间
  DateTime get createdTime =>
      DateTime.fromMillisecondsSinceEpoch(createdAt);

  /// 获取实际奖励钻石数（除以100）
  int get actualReward => reward;

  /// 奖励是否来自注册
  bool get isRegisterReward => type == AuvInviteRewardType.register;

  /// 奖励是否来自充值
  bool get isRechargeReward => type == AuvInviteRewardType.recharge;
}

/// 邀请信息
class AuvInviteInfo {
  final String inviteCode;          // 邀请码
  final int awardIncome;            // 总收入（钻石数）
  final int inviteAward;           // 注册邀请奖励
  final int rechargeAward;         // 充值邀请奖励
  final String shareUrl;           // 分享链接
  final int inviteDailyCount;      // 每日邀请最大人数
  final int inviteCount;           // 当天已邀请人数

  AuvInviteInfo({
    required this.inviteCode,
    required this.awardIncome,
    required this.inviteAward,
    required this.rechargeAward,
    required this.shareUrl,
    required this.inviteDailyCount,
    required this.inviteCount,
  });

  factory AuvInviteInfo.fromJson(Map<String, dynamic> json) {
    return AuvInviteInfo(
      inviteCode: json['inviteCode'] ?? '',
      awardIncome: json['awardIncome'] ?? 0,
      inviteAward: json['inviteAward'] ?? 0,
      rechargeAward: json['rechargeAward'] ?? 0,
      shareUrl: json['shareUrl'] ?? '',
      inviteDailyCount: json['inviteDailyCount'] ?? 0,
      inviteCount: json['inviteCount'] ?? 0,
    );
  }

  /// 每日剩余可邀请人数
  int get remainingInviteCount =>
      (inviteDailyCount - inviteCount).clamp(0, inviteDailyCount);

  /// 是否已达每日邀请上限
  bool get isDailyLimitReached => inviteCount >= inviteDailyCount;
}

/// 邀请绑定记录
class AuvInviteRecord {
  final int createdAt;              // 注册时间戳
  final bool hasBindInviteCode;     // 是否绑定邀请码
  final bool canBindInviteCode;    // 是否可以绑定邀请码
  final String inviteCode;          // 邀请码

  AuvInviteRecord({
    required this.createdAt,
    required this.hasBindInviteCode,
    required this.canBindInviteCode,
    required this.inviteCode,
  });

  factory AuvInviteRecord.fromJson(Map<String, dynamic> json) {
    return AuvInviteRecord(
      createdAt: json['createdAt'] ?? 0,
      hasBindInviteCode: json['hasBindInviteCode'] ?? false,
      canBindInviteCode: json['canBindInviteCode'] ?? false,
      inviteCode: json['inviteCode'] ?? '',
    );
  }

  /// 注册时间
  DateTime get registrationTime =>
      DateTime.fromMillisecondsSinceEpoch(createdAt);

  /// 是否已绑定
  bool get isBound => hasBindInviteCode;

  /// 是否可以绑定
  bool get canBind => canBindInviteCode;
}
