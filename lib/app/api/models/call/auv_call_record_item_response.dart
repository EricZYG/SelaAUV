/// 通话记录项模型
///
/// 表示单条通话记录信息
class AuvCallRecordItemResponse {
  /// 频道id
  final int? channelId;

  /// 对方用户id
  final int? peerUserId;

  /// 开始计时时间
  final int? startAt;

  /// 挂断时间 0表示未接通
  final int? endAt;

  /// 拨打时间
  final int? createdAt;

  /// 唤起方式
  /// 0.正常拨打
  /// 1.AIB
  /// 2.匹配
  /// 3.主播邀请
  /// 4.主播免费邀请
  /// 5.免费匹配
  final int? callType;

  /// 对方昵称
  final String? peerNickname;

  /// 对方头像
  final String? peerPortrait;

  /// 对方是否在线
  final int? peerIsOnline;

  /// 频道状态
  /// 0.拨号中
  /// 1.已接通
  /// 2.被叫拒绝
  /// 3.主叫方取消
  /// 4.通话完成
  /// 5.异常结束
  /// 6.拨号超时
  final int? channelStatus;

  /// 是否vip
  final bool? vipFlag;

  /// 等级值
  final int? level;

  AuvCallRecordItemResponse({
    this.channelId,
    this.peerUserId,
    this.startAt,
    this.endAt,
    this.createdAt,
    this.callType,
    this.peerNickname,
    this.peerPortrait,
    this.peerIsOnline,
    this.channelStatus,
    this.vipFlag,
    this.level,
  });

  factory AuvCallRecordItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCallRecordItemResponse();
    return AuvCallRecordItemResponse(
      channelId: json['channelId'],
      peerUserId: json['peerUserId'],
      startAt: json['startAt'],
      endAt: json['endAt'],
      createdAt: json['createdAt'],
      callType: json['callType'],
      peerNickname: json['peerNickname'],
      peerPortrait: json['peerPortrait'],
      peerIsOnline: json['peerIsOnline'],
      channelStatus: json['channelStatus'],
      vipFlag: json['vipFlag'],
      level: json['level'],
    );
  }

  /// 计算通话时长(秒)
  /// endAt为0表示未接通，返回null
  int? get durationSeconds {
    if (endAt == null || endAt == 0 || startAt == null) return null;
    return endAt! - startAt!;
  }

  /// 获取唤起方式描述
  String get callTypeDesc {
    switch (callType) {
      case 0:
        return '正常拨打';
      case 1:
        return 'AIB';
      case 2:
        return '匹配';
      case 3:
        return '主播邀请';
      case 4:
        return '主播免费邀请';
      case 5:
        return '免费匹配';
      default:
        return '未知';
    }
  }

  /// 获取频道状态描述
  String get channelStatusDesc {
    switch (channelStatus) {
      case 0:
        return '拨号中';
      case 1:
        return '已接通';
      case 2:
        return '被叫拒绝';
      case 3:
        return '主叫方取消';
      case 4:
        return '通话完成';
      case 5:
        return '异常结束';
      case 6:
        return '拨号超时';
      default:
        return '未知';
    }
  }

  /// 是否已接通
  bool get isConnected => channelStatus == 1 || channelStatus == 4;

  /// 是否未接通
  bool get isNotConnected => endAt == 0 || channelStatus == 2 || channelStatus == 3 || channelStatus == 6;
}