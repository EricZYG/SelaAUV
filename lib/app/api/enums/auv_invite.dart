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
