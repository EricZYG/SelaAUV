/// 通话记录项模型
///
/// 表示单条通话记录信息
class AuvCallRecordItemResponse {
  /// 频道id
  /// 
  /// 通话频道的唯一标识符
  final int? channelId;

  /// 对方用户id
  /// 
  /// 通话对方的用户ID
  final int? peerUserId;

  /// 开始计时时间
  /// 
  /// 通话开始计时的时间戳（毫秒）
  final int? startAt;

  /// 挂断时间
  /// 
  /// 通话结束的时间戳（毫秒），0表示未接通
  final int? endAt;

  /// 拨打时间
  /// 
  /// 发起通话的时间戳（毫秒）
  final int? createdAt;

  /// 唤起方式
  /// 
  /// 0.正常拨打，1.AIB，2.匹配，3.主播邀请，4.主播免费邀请，5.免费匹配
  final int? callType;

  /// 对方昵称
  /// 
  /// 通话对方的显示昵称
  final String? peerNickname;

  /// 对方头像
  /// 
  /// 通话对方的头像URL地址
  final String? peerPortrait;

  /// 对方是否在线
  /// 
  /// 0.离线，1.在线
  final int? peerIsOnline;

  /// 频道状态
  /// 
  /// 0.拨号中，1.已接通，2.被叫拒绝，3.主叫方取消，4.通话完成，5.异常结束，6.拨号超时
  final int? channelStatus;

  /// 是否vip
  /// 
  /// true表示对方是VIP用户，false表示普通用户
  final bool? vipFlag;

  /// 等级值
  /// 
  /// 对方的用户等级数值
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
  /// 
  /// 根据开始时间和结束时间计算通话持续秒数
  /// endAt为0表示未接通，返回null
  int? get durationSeconds {
    if (endAt == null || endAt == 0 || startAt == null) return null;
    return endAt! - startAt!;
  }

  /// 获取唤起方式描述
  /// 
  /// 返回可读性更好的唤起方式文字说明
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
  /// 
  /// 返回可读性更好的频道状态文字说明
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
  /// 
  /// 判断通话是否成功接通
  bool get isConnected => channelStatus == 1 || channelStatus == 4;

  /// 是否未接通
  /// 
  /// 判断通话是否未能接通
  bool get isNotConnected => endAt == 0 || channelStatus == 2 || channelStatus == 3 || channelStatus == 6;
}