/// 主播免费邀请通话信息响应模型
/// 
/// 查询对方免费邀请通话相关信息
class AuvFreeInviteCallInfoResponse {
  /// 免费邀请通话的免费时长
  /// 
  /// 单位：秒
  final int? freeInviteSeconds;

  /// 免费邀请通话次数上限
  final int? freeInviteCountLimit;

  /// 免费邀请通话剩余次数
  final int? freeInviteLeftCount;

  AuvFreeInviteCallInfoResponse({
    this.freeInviteSeconds,
    this.freeInviteCountLimit,
    this.freeInviteLeftCount,
  });

  factory AuvFreeInviteCallInfoResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvFreeInviteCallInfoResponse();
    return AuvFreeInviteCallInfoResponse(
      freeInviteSeconds: json['freeInviteSeconds'],
      freeInviteCountLimit: json['freeInviteCountLimit'],
      freeInviteLeftCount: json['freeInviteLeftCount'],
    );
  }
}