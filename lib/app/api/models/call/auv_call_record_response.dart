/// 通话记录模型
/// 
/// 表示用户的历史通话记录
/// 
/// 字段说明:
/// - channelId: 频道ID
/// - peerUserId: 对方用户ID
/// - startAt: 开始计时时间
/// - endAt: 挂断时间(0表示未接通)
/// - createdAt: 拨打时间
/// - callType: 通话类型(0:正常拨打, 1:AIB唤起, 2:匹配唤起, 3:主播邀请, 4:主播免费邀请, 5:免费匹配)
/// - peerName: 对方名称
/// - peerAvatar: 对方头像
class AuvCallRecordResponse {
  /// 频道ID
  final int? channelId;
  
  /// 对方用户ID
  final int? peerUserId;
  
  /// 开始计时时间
  final int? startAt;
  
  /// 挂断时间(0表示未接通)
  final int? endAt;
  
  /// 拨打时间
  final int? createdAt;
  
  /// 通话类型
  /// 0: 正常拨打
  /// 1: AIB唤起
  /// 2: 匹配唤起
  /// 3: 主播邀请
  /// 4: 主播免费邀请
  /// 5: 免费匹配
  final int? callType;
  
  /// 对方名称
  final String? peerName;
  
  /// 对方头像
  final String? peerAvatar;

  AuvCallRecordResponse({
    this.channelId,
    this.peerUserId,
    this.startAt,
    this.endAt,
    this.createdAt,
    this.callType,
    this.peerName,
    this.peerAvatar,
  });

  factory AuvCallRecordResponse.fromJson(Map<String, dynamic> json) {
    return AuvCallRecordResponse(
      channelId: json['channelId'],
      peerUserId: json['peerUserId'],
      startAt: json['startAt'],
      endAt: json['endAt'],
      createdAt: json['createdAt'],
      callType: json['callType'],
      peerName: json['peerName'],
      peerAvatar: json['peerAvatar'],
    );
  }
  
  /// 计算通话时长(秒)
  /// endAt为0表示未接通，返回null
  int? get durationSeconds {
    if (endAt == null || endAt == 0 || startAt == null) return null;
    return endAt! - startAt!;
  }
}