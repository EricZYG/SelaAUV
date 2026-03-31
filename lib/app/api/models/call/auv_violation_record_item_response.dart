/// 违规处罚记录项响应模型
/// 
/// 表示单条违规处罚记录信息
class AuvViolationRecordItemResponse {
  /// 记录id
  final int? recordId;

  /// 频道id
  final int? channelId;

  /// 违规主播的用户id
  final int? anchorUserId;

  /// 通话多少秒时违规
  final int? recordSeconds;

  /// 处罚类型
  /// 
  /// 1.提醒，2.警告，3.封禁，4.取消认证
  final int? recordType;

  /// 申诉状态
  /// 
  /// 0.无申诉，1.申诉中，2.申诉成功，3.申诉失败
  final int? recordStatus;

  /// 封禁类型
  final int? banType;

  /// 封禁到期时间
  final int? banTime;

  /// 违规截图
  final String? screenshotUrl;

  /// 创建时间
  final int? createdAt;

  /// 通话时长，毫秒数
  final int? callDuration;

  /// 违规主播角色
  /// 
  /// 0.主叫方，1.被叫方
  final int? callRole;

  /// 用户id
  final int? userId;

  /// 用户昵称
  final String? nickname;

  /// 头像
  final String? portrait;

  AuvViolationRecordItemResponse({
    this.recordId,
    this.channelId,
    this.anchorUserId,
    this.recordSeconds,
    this.recordType,
    this.recordStatus,
    this.banType,
    this.banTime,
    this.screenshotUrl,
    this.createdAt,
    this.callDuration,
    this.callRole,
    this.userId,
    this.nickname,
    this.portrait,
  });

  factory AuvViolationRecordItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvViolationRecordItemResponse();
    return AuvViolationRecordItemResponse(
      recordId: json['recordId'],
      channelId: json['channelId'],
      anchorUserId: json['anchorUserId'],
      recordSeconds: json['recordSeconds'],
      recordType: json['recordType'],
      recordStatus: json['recordStatus'],
      banType: json['banType'],
      banTime: json['banTime'],
      screenshotUrl: json['screenshotUrl'],
      createdAt: json['createdAt'],
      callDuration: json['callDuration'],
      callRole: json['callRole'],
      userId: json['userId'],
      nickname: json['nickname'],
      portrait: json['portrait'],
    );
  }
}
