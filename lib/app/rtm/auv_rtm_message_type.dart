/// 声网 RTM 消息类型枚举
enum AuvRtmMessageType {
  // ========== 基础消息 ==========
  jumpNotice(10, '跳转通知'),
  text(11, '文本消息'),
  image(12, '图片消息'),
  privacyImg(13, '私密聊天图片'),
  video(14, '视频'),
  voice(15, '语音'),
  call(16, '通话消息'),
  gift(17, '礼物消息'),
  followRequest(18, '加好友消息'),
  msgScript(19, '话术消息'),
  rateApp(20, 'App评分'),
  balanceChanged(21, '余额变动'),
  propChanged(22, '道具卡变动'),
  msgInCall(23, '视频通话内聊天'),
  seeHome(24, '有人看了主页'),
  registerReward(25, '新手礼包发放'),
  privacyVideo(26, '私密聊天视频'),
  followRequestAgree(27, '同意好友申请'),
  anchorOnline(28, '主播上线通知'),
  sticker(29, '表情'),
  block(30, '拉黑'),
  orderChanged(31, '订单状态变化'),
  begGiftInMsg(32, '私信索要礼物'),
  begGiftInCall(33, '通话索要礼物'),
  begRecharge(34, '索要充值'),
  begGiftSuccess(35, '索要礼物成功'),
  begRechargeSuccess(36, '索要充值成功'),
  unlockPrivacyImg(37, '解锁私密图片'),
  momentImg(38, '主播动态图片'),
  momentNotice(39, '主播动态通知'),

  // ========== 通话消息 (41-50) ==========
  beginCall(41, '开始通话'),
  failCall(42, '通话失败'),
  settlementCall(43, '通话结算'),
  feedback(44, '举报回复'),
  authFail(45, '认证失败'),
  ban(46, '封禁'),
  levelChange(47, '等级变更'),
  privacyCall(48, '隐私通话'),
  unlockPrivacyVideo(49, '解锁私密视频'),
  trialChange(50, '试播状态变更'),
  setVideoResolution(51, '设置分辨率'),

  // ========== 游戏房间消息 (52-55) ==========
  roomInUserChange(52, '游戏房间人数变化'),
  roomInTopChange(53, '游戏房间Top变化'),
  roomInMaxReward(54, '游戏房间大奖'),
  roomInChatMsg(55, '游戏内聊天'),

  // ========== 用户相关 (56-65) ==========
  likeMe(56, '喜欢我'),
  advanceUser(57, '成为高级用户'),
  heartbeatLevelChange(58, '心动等级变更'),
  rewardReplayForAnchor(59, '主播奖励回复'),
  messageReaded(60, '消息已读'),
  messageRecall(61, '撤回消息'),
  messageDeductRefund(62, '扣费退回'),
  anchorFaceConfirm(63, '主播露脸确认'),
  callTrialAnchor(64, '试播主播通话'),
  normalToTrial(65, '变成试播状态'),

  // ========== 直播间消息 (100-105) ==========
  liveGiftShowChange(100, '礼物秀变更'),
  liveStatusChange(101, '直播间状态变更'),
  liveVipJoin(102, 'Vip进入'),
  liveChatMsg(103, '直播间聊天'),
  livePermissionDisabled(104, '直播权限禁用'),
  liveLuckyGift(105, '幸运礼物'),

  // ========== 未知 ==========
  unknown(0, '未知消息');

  final int value;
  final String desc;

  const AuvRtmMessageType(this.value, this.desc);

  /// 根据 int 值获取枚举
  static AuvRtmMessageType fromValue(int value) {
    return AuvRtmMessageType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvRtmMessageType.unknown,
    );
  }

  /// 是否为基础消息类型
  bool get isBasicMessage =>
      this == text ||
      this == image ||
      this == voice ||
      this == video ||
      this == sticker;

  /// 是否为私密消息类型
  bool get isPrivacyMessage =>
      this == privacyImg ||
      this == privacyVideo ||
      this == unlockPrivacyImg ||
      this == unlockPrivacyVideo;

  /// 是否为通话相关消息
  bool get isCallMessage =>
      this == call ||
      this == beginCall ||
      this == failCall ||
      this == settlementCall ||
      this == msgInCall ||
      this == privacyCall ||
      this == callTrialAnchor;

  /// 是否为直播间消息
  bool get isLiveMessage =>
      value >= 100 && value <= 199;

  /// 是否为礼物相关消息
  bool get isGiftMessage =>
      this == gift ||
      this == begGiftInMsg ||
      this == begGiftInCall ||
      this == begGiftSuccess ||
      this == liveLuckyGift ||
      this == liveGiftShowChange;

  /// 是否为通知类消息（不需要显示在聊天列表）
  bool get isNotification =>
      value >= 20 && value <= 39 ||
      value >= 41 && value <= 50 ||
      value >= 56 && value <= 65 ||
      isLiveMessage;
}
