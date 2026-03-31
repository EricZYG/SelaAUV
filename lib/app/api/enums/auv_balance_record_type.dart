/// 余额明细类型枚举
enum AuvBalanceRecordType {
  // ========== 钻石明细类型 (101-199) ==========
  orderRecharge(101, '订单充值', BalanceCategory.diamond),
  orderRefund(102, '订单退款', BalanceCategory.diamond),
  platformRecharge(103, '平台充值', BalanceCategory.diamond),
  platformDeduct(104, '平台扣减', BalanceCategory.diamond),
  newbieGift(105, '新手礼包', BalanceCategory.diamond),
  userSignIn(106, '用户签到', BalanceCategory.diamond),
  userTask(107, '用户任务', BalanceCategory.diamond),
  userInviteRegister(108, '用户邀请注册成功', BalanceCategory.diamond),
  userInviteRecharge(109, '用户邀请充值成功', BalanceCategory.diamond),
  gameSpend(110, '游戏花费', BalanceCategory.diamond),
  gameReward(111, '游戏奖励', BalanceCategory.diamond),
  returnGift(112, '回归礼包', BalanceCategory.diamond),

  // ========== 金币明细类型 (201-299) ==========
  anchorWithdraw(201, '主播提现', BalanceCategory.goldCoin),
  withdrawRejected(202, '提现拒审', BalanceCategory.goldCoin),
  systemReward(203, '系统奖励', BalanceCategory.goldCoin),
  systemPunish(204, '系统惩罚', BalanceCategory.goldCoin),
  anchorBanned(205, '主播封禁', BalanceCategory.goldCoin),
  callNoFacePunish(206, '通话未露脸惩罚', BalanceCategory.goldCoin),
  anchorTask(207, '主播任务', BalanceCategory.goldCoin),
  begRecharge(208, '索要充值', BalanceCategory.goldCoin),
  anchorInviteRegister(209, '主播邀请用户注册成功', BalanceCategory.goldCoin),
  anchorInviteRecharge(210, '主播邀请用户充值成功', BalanceCategory.goldCoin),
  inviteAuthSuccess(211, '邀请认证成功', BalanceCategory.goldCoin),
  inviteIncomeReach(212, '邀请收入达标', BalanceCategory.goldCoin),
  trialPassed(213, '试播通过', BalanceCategory.goldCoin),
  anchorSettlement(299, '主播结算', BalanceCategory.goldCoin),

  // ========== 钻石/金币通用 (301-399) ==========
  videoCall(301, '视频通话', BalanceCategory.both),
  matchCall(302, '匹配通话', BalanceCategory.both),
  callRefund(303, '通话退钻', BalanceCategory.both),

  // ========== 礼物相关 (401-499) ==========
  gift(401, '礼物', BalanceCategory.both),
  exchangeGoldCoinToDiamond(402, '金币兑换钻石', BalanceCategory.both),

  // ========== 私信相关 (501-599) ==========
  privateMessage(501, '私信', BalanceCategory.both),
  unlockPrivacyImg(502, '解锁私密图片', BalanceCategory.both),
  unlockPrivacyVideo(503, '解锁私密视频', BalanceCategory.both),
  chatRefund(504, '聊天扣费退回', BalanceCategory.both),

  // ========== 公会金币明细 (601-699) ==========
  guildSettlement(601, '公会结算', BalanceCategory.guildCoin),
  guildWithdraw(602, '公会提现', BalanceCategory.guildCoin),
  guildSystemReward(603, '公会系统奖励', BalanceCategory.guildCoin),
  guildSystemPunish(604, '公会系统惩罚', BalanceCategory.guildCoin),
  guildTask(605, '公会任务', BalanceCategory.guildCoin),
  guildActivity(606, '公会活动', BalanceCategory.guildCoin),
  guildWithdrawRejected(607, '公会提现拒审', BalanceCategory.guildCoin),

  // ========== 未知 ==========
  unknown(0, '未知', BalanceCategory.unknown);

  final int value;
  final String desc;
  final BalanceCategory category;

  const AuvBalanceRecordType(this.value, this.desc, this.category);

  /// 根据 int 值获取枚举
  static AuvBalanceRecordType fromValue(int value) {
    return AuvBalanceRecordType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvBalanceRecordType.unknown,
    );
  }

  /// 是否为钻石类型
  bool get isDiamond => category == BalanceCategory.diamond;

  /// 是否为金币类型
  bool get isGoldCoin => category == BalanceCategory.goldCoin;

  /// 是否为公会金币类型
  bool get isGuildCoin => category == BalanceCategory.guildCoin;

  /// 是否为通用类型
  bool get isBoth => category == BalanceCategory.both;

  /// 是否为收入类型
  bool get isIncome =>
      this == orderRecharge ||
      this == platformRecharge ||
      this == newbieGift ||
      this == userSignIn ||
      this == userTask ||
      this == userInviteRegister ||
      this == userInviteRecharge ||
      this == gameReward ||
      this == returnGift ||
      this == systemReward ||
      this == trialPassed ||
      this == anchorInviteRegister ||
      this == anchorInviteRecharge ||
      this == inviteAuthSuccess ||
      this == inviteIncomeReach ||
      this == anchorTask ||
      this == guildSystemReward ||
      this == guildTask ||
      this == guildActivity;

  /// 是否为支出类型
  bool get isExpense =>
      this == platformDeduct ||
      this == gameSpend ||
      this == videoCall ||
      this == matchCall ||
      this == privateMessage ||
      this == unlockPrivacyImg ||
      this == unlockPrivacyVideo ||
      this == exchangeGoldCoinToDiamond ||
      this == anchorWithdraw ||
      this == guildWithdraw;

  /// 是否为退款类型
  bool get isRefund =>
      this == orderRefund ||
      this == callRefund ||
      this == chatRefund;
}

/// 余额类别
enum BalanceCategory {
  diamond,    // 钻石
  goldCoin,   // 金币
  guildCoin,  // 公会金币
  both,       // 钻石/金币通用
  unknown,    // 未知
}
