/// API 响应码枚举
enum AuvApiCode {
  // ========== 成功 ==========
  success(0, 'Success'),

  // ========== 系统错误 (1001-1049) ==========
  systemError(1001, 'System error'),
  notLoggedIn(1002, 'Not logged in'),
  loginError(1003, 'Login information error'),
  accountBanned(1004, 'Account banned'),
  accountNotFound(1005, 'Account does not exist'),
  paramError(1006, 'Parameter error'),
  illegalIp(1007, 'Illegal IP'),
  insufficientBalance(1008, 'Insufficient balance'),
  tooManyRequests(1009, 'Too many requests'),
  inBlacklist(1010, 'In blacklist'),
  lockTimeout(1011, 'Get lock timeout'),
  uploadFailed(1012, 'Upload failed'),
  identityNotSupported(1013, 'Partner identity not supported for chat'),
  invalidShareCode(1014, 'Invalid share code'),
  certificationLimitReached(1015, 'Daily certification limit reached'),
  contentUnderReview(1016, 'Content under review'),
  wrongPassword(1017, 'Wrong password'),
  googleAlreadyBound(1018, 'Google account already bound'),
  tagLimitExceeded(1019, 'Tag count exceeded'),
  loggedInElsewhere(1020, 'Logged in on another device'),
  versionTooLow(1021, 'App version too low'),
  dataUpdateInvalid(1022, 'Data update invalid'),
  quickReplyLimitExceeded(1023, 'Quick reply limit exceeded'),
  imageNotFound(1024, 'Image not found'),
  femaleOnlyRegistration(1025, 'Only female registration allowed'),
  anchorCannotLoginUser(1026, 'Anchor cannot login user end'),
  keepAtLeastOneQuickReply(1027, 'Keep at least one quick reply'),
  anchorCannotBindGuild(1029, 'Anchor cannot bind system guild'),
  userCannotRegisterAnchor(1030, 'Registered user cannot register as anchor'),
  guildHasAccount(1031, 'Guild already has account, cannot use invite code'),
  emailNotBound(1032, 'Account not bound to email'),
  emailAlreadyBound(1033, 'Account already has bound email'),
  verificationCodeError(1034, 'Verification code error'),
  guildNameChangeLimit(1035, 'Guild name change limit reached'),
  guildBindChangeLimit(1036, 'Guild bind change limit reached'),
  verificationCodeSendFailed(1037, 'Verification code send failed'),
  targetAlreadyBound(1038, 'Target account already bound by another guild'),
  emailAlreadyUsed(1039, 'Email already bound to another account'),
  searchUserNotFound(1040, 'Searched user not found'),
  faceNotDetected(1041, 'Face not detected'),
  faceMismatch(1042, 'Face comparison inconsistent'),
  gameMountFull(1043, 'Live game mount full'),
  anchorHasLiveRoom(1044, 'Anchor already has live room'),
  anchorCannotRegister(1045, 'Anchor end cannot register'),
  containsBlockedWords(1046, 'Contains blocked words'),
  levelTooLow(1047, 'User level too low to send message'),
  vpnDetected(1048, 'VPN detected'),

  // ========== 订单错误 (2001-2099) ==========
  orderCreateFailed(2001, 'Order creation failed'),
  cannotReceiveDiscount(2002, 'Cannot receive installment discount'),

  // ========== 通话错误 (3001-3099) ==========
  callError(3001, 'Call error'),
  partnerUnavailable(3002, 'Partner cannot answer'),
  matchFailed(3003, 'Match failed'),
  partnerBalanceInsufficient(3004, 'Partner balance insufficient'),
  partnerInTrialMode(3005, 'Partner in trial mode'),
  partnerInLive(3006, 'Partner is in live stream'),

  // ========== 邀请码错误 (4001-4099) ==========
  inviteCodeError(4001, 'Invite code error'),
  inviteCodeAlreadyBound(4002, 'Repeat bind invite code'),
  inviteCodeExpired(4003, 'Invite code expired'),
  inviteCodeTooLate(4004, 'Cannot bind invite code of later registered friend'),
  inviteLimitReached(4005, 'Today invite limit reached'),

  // ========== 礼物错误 (5001-5099) ==========
  giftNotFound(5001, 'Gift not found'),

  // ========== 签到错误 (6001-6099) ==========
  duplicateSignIn(6001, 'Duplicate sign in'),

  // ========== 提现错误 (7001-7099) ==========
  cannotWithdraw(7001, 'Cannot withdraw'),

  // ========== 其他错误 (8001-8999) ==========
  unknown(8001, 'Unknown error');

  final int code;
  final String message;

  const AuvApiCode(this.code, this.message);

  /// 根据 code 获取枚举
  static AuvApiCode fromCode(int code) {
    return AuvApiCode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => AuvApiCode.unknown,
    );
  }

  /// 是否成功
  bool get isSuccess => this == AuvApiCode.success;
}
