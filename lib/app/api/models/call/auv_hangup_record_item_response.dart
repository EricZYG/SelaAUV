/// 挂机记录项响应模型
/// 
/// 表示单条挂机记录信息
class AuvHangupRecordItemResponse {
  /// 记录id
  final int? recordId;

  /// 挂机主播
  final int? anchorUserId;

  /// 挂机类型
  /// 
  /// 1.正常模式，2.匹配模式，3.连续超时挂断
  final int? hangupType;

  /// 创建时间
  final int? createdAt;

  AuvHangupRecordItemResponse({
    this.recordId,
    this.anchorUserId,
    this.hangupType,
    this.createdAt,
  });

  factory AuvHangupRecordItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvHangupRecordItemResponse();
    return AuvHangupRecordItemResponse(
      recordId: json['recordId'],
      anchorUserId: json['anchorUserId'],
      hangupType: json['hangupType'],
      createdAt: json['createdAt'],
    );
  }
}
