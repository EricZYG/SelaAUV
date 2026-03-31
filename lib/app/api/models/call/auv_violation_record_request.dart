/// 违规处罚记录查询条件请求模型
/// 
/// 用于查询违规处罚记录的可选筛选条件
class AuvViolationRecordConditionRequest {
  /// 处罚类型
  /// 
  /// 1.提醒，2.警告，3.封禁，4.取消认证
  final int? recordType;

  /// 申诉状态
  /// 
  /// 0.无申诉，1.申诉中，2.申诉成功，3.申诉失败
  final int? recordStatus;

  AuvViolationRecordConditionRequest({
    this.recordType,
    this.recordStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      if (recordType != null) 'recordType': recordType,
      if (recordStatus != null) 'recordStatus': recordStatus,
    };
  }
}