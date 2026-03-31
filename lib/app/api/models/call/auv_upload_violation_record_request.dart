/// 上传违规处罚记录请求模型
/// 
/// 上报违规处罚记录信息
class AuvUploadViolationRecordRequest {
  /// 频道id
  final int channelId;

  /// 通话多少秒时违规
  final int recordSeconds;

  /// 违规截图
  final String? screenshotUrl;

  AuvUploadViolationRecordRequest({
    required this.channelId,
    required this.recordSeconds,
    this.screenshotUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'recordSeconds': recordSeconds,
      if (screenshotUrl != null) 'screenshotUrl': screenshotUrl,
    };
  }
}