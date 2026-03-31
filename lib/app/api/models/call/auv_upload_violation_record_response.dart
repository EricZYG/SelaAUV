/// 上传违规处罚记录响应模型
/// 
/// 上报违规后的处罚结果信息
class AuvUploadViolationRecordResponse {
  /// 处罚类型
  /// 
  /// 1.提醒，2.警告，3.封禁，4.取消认证
  final int? violateType;

  /// 违规次数
  final int? violateCount;

  AuvUploadViolationRecordResponse({
    this.violateType,
    this.violateCount,
  });

  factory AuvUploadViolationRecordResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvUploadViolationRecordResponse();
    return AuvUploadViolationRecordResponse(
      violateType: json['violateType'],
      violateCount: json['violateCount'],
    );
  }
}