/// 通话挂断类型枚举
enum AuvCallEndType {
  // ========== 基础类型 (0-20) ==========
  none(-1, '电话未接通', AuvCallEndCategory.notConnected),
  defaultEnd(0, '正常挂断', AuvCallEndCategory.normal),
  offline(1, '对方离线', AuvCallEndCategory.peer),
  agoraNetworkError(2, '声网连接失败', AuvCallEndCategory.network),
  targetEnd(3, '对方挂断', AuvCallEndCategory.peer),
  joinRenewErr(4, '续key失败', AuvCallEndCategory.system),
  createCallError(5, '创建通话记录失败', AuvCallEndCategory.system),
  noEnoughMoney(6, '余额不足', AuvCallEndCategory.balance),
  forbidCutDown(7, '被封禁', AuvCallEndCategory.banned),
  timeout(8, '连接超时', AuvCallEndCategory.timeout),
  noDiamondRefuse(9, '余额不足自动拒绝', AuvCallEndCategory.balance),
  refuse(11, '正常拒绝', AuvCallEndCategory.normal),
  myOffline(12, '用户本身声网掉线', AuvCallEndCategory.network),
  refuseTimeout(13, '超时拒绝', AuvCallEndCategory.timeout),
  aiChatTimeout(14, '视频通话等待超时', AuvCallEndCategory.timeout),
  interceptRefuse(15, '忙线拒绝', AuvCallEndCategory.busy),
  comeCalledHangUp(16, '来被叫取消主叫', AuvCallEndCategory.normal),
  closeActivity(17, '切后台关闭通话', AuvCallEndCategory.normal),

  // ========== 主叫错误 (10001-10020) ==========
  callTimeout(10001, '主叫超时', AuvCallEndCategory.timeout),
  callCancel(10002, '主叫取消', AuvCallEndCategory.normal),
  callRefuse(10003, '主叫对方拒绝', AuvCallEndCategory.peer),
  callFail(10004, '主叫失败', AuvCallEndCategory.system),
  calledRefuse(10005, '被叫拒绝', AuvCallEndCategory.normal),
  calledCancel(10006, '被叫对方取消', AuvCallEndCategory.peer),
  calledTimeout(10007, '被叫超时', AuvCallEndCategory.timeout),
  noMoneyBefore(10008, '通话前余额不足', AuvCallEndCategory.balance),
  connectError(10009, '用户连接异常', AuvCallEndCategory.network),
  connectCancel(10010, '用户连接取消', AuvCallEndCategory.normal),
  anchorError(10011, '对方异常', AuvCallEndCategory.peer),
  anchorTimeout(10012, '等待对端超时', AuvCallEndCategory.timeout),
  beginTimeout(10013, '等待begin指令超时', AuvCallEndCategory.timeout),
  userEnd(10014, '用户主动挂断', AuvCallEndCategory.normal),
  keyNoMoney(10015, '通话中续key余额不足', AuvCallEndCategory.balance),
  keyFail(10016, '续key接口调用失败', AuvCallEndCategory.system),
  anchorOffline(10017, '对方离线', AuvCallEndCategory.peer),
  anchorEnd(10018, '对方挂断', AuvCallEndCategory.peer),
  anchorBan(10019, '主播封禁', AuvCallEndCategory.banned),
  userNetError(10020, '用户网络异常挂断', AuvCallEndCategory.network),
  permissionDenied(10021, '没有权限', AuvCallEndCategory.permission),
  unusualRefuse(10022, '主播端不支持接起', AuvCallEndCategory.peer),
  localVideoError(10023, '本地视频故障', AuvCallEndCategory.device),
  freeMatchAutoEnd(10024, '免费匹配时间自动结束', AuvCallEndCategory.normal),

  // ========== 特殊拦截 (200-299) ==========
  anchorCalling(201, '主播在通话页面拦截', AuvCallEndCategory.busy),
  userBlack(202, '用户被拉黑', AuvCallEndCategory.blacklist),
  callTwice500(203, '500ms内重复呼叫拦截', AuvCallEndCategory.busy),
  screenBlack(204, '屏幕息屏', AuvCallEndCategory.normal),
  channelNull(205, '频道为null', AuvCallEndCategory.system),

  // ========== 未知 ==========
  unknown(0, '未知', AuvCallEndCategory.unknown);

  final int value;
  final String desc;
  final AuvCallEndCategory category;

  const AuvCallEndType(this.value, this.desc, this.category);

  /// 根据 int 值获取枚举
  static AuvCallEndType fromValue(int value) {
    return AuvCallEndType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvCallEndType.unknown,
    );
  }

  /// 是否为正常挂断
  bool get isNormalEnd =>
      this == defaultEnd ||
      this == refuse ||
      this == callCancel ||
      this == calledRefuse ||
      this == connectCancel ||
      this == userEnd ||
      this == freeMatchAutoEnd ||
      this == closeActivity ||
      this == screenBlack;

  /// 是否为对方原因
  bool get isPeerReason =>
      this == offline ||
      this == targetEnd ||
      this == callRefuse ||
      this == calledCancel ||
      this == calledTimeout ||
      this == anchorOffline ||
      this == anchorEnd ||
      this == anchorError ||
      this == unusualRefuse;

  /// 是否为余额不足
  bool get isBalanceIssue =>
      this == noEnoughMoney ||
      this == noDiamondRefuse ||
      this == noMoneyBefore ||
      this == keyNoMoney;

  /// 是否为网络问题
  bool get isNetworkIssue =>
      this == agoraNetworkError ||
      this == myOffline ||
      this == connectError ||
      this == userNetError;

  /// 是否为超时
  bool get isTimeout =>
      this == timeout ||
      this == refuseTimeout ||
      this == aiChatTimeout ||
      this == callTimeout ||
      this == calledTimeout ||
      this == anchorTimeout ||
      this == beginTimeout;

  /// 是否为封禁/拉黑
  bool get isBlocked =>
      this == forbidCutDown ||
      this == anchorBan ||
      this == userBlack ||
      this == permissionDenied;

  /// 是否为设备问题
  bool get isDeviceIssue =>
      this == localVideoError ||
      this == channelNull;

  /// 获取中文描述
  String get description => desc;
}

/// 通话结束类别
enum AuvCallEndCategory {
  normal,      // 正常结束
  peer,        // 对方原因
  balance,    // 余额问题
  network,    // 网络问题
  timeout,    // 超时
  banned,     // 封禁
  blacklist,  // 黑名单
  permission, // 权限
  device,     // 设备问题
  busy,       // 忙线
  system,     // 系统错误
  notConnected, // 未接通
  unknown,    // 未知
}

/// 通话类型
enum AuvCallType {
  video(1, '视频通话'),
  voice(2, '语音通话'),
  privacy(3, '隐私通话');

  final int value;
  final String desc;

  const AuvCallType(this.value, this.desc);

  static AuvCallType fromValue(int value) {
    return AuvCallType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvCallType.video,
    );
  }
}

/// 通话状态
enum AuvCallStatus {
  calling(1, '呼叫中'),
  ringing(2, '等待接听'),
  connected(3, '已接通'),
  ended(4, '已结束');

  final int value;
  final String desc;

  const AuvCallStatus(this.value, this.desc);

  static AuvCallStatus fromValue(int value) {
    return AuvCallStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvCallStatus.ended,
    );
  }
}
