/// 获取通话记录请求模型
///
/// 获取通话记录接口的请求参数
class AuvGetCallRecordRequest {
  /// 查询条件
  final AuvCallRecordConditionRequest? condition;

  /// 页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  AuvGetCallRecordRequest({
    this.condition,
    required this.pageNum,
    required this.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      if (condition != null) 'condition': condition!.toJson(),
      'pageNum': pageNum,
      'pageSize': pageSize,
    };
  }
}

/// 通话记录查询条件模型
class AuvCallRecordConditionRequest {
  /// 唤起方式列表
  /// 0.正常唤起，1.AIB唤起，2.匹配唤起，3.主播邀请，4.主播免费邀请，5.免费匹配
  final List<int>? callTypes;

  /// 唤起方式，0.正常唤起，1.AIB唤起，2.匹配唤起，3.主播邀请，4.主播免费邀请，5.免费匹配
  final int? callType;

  /// 通话标志，0.未接，1.已接
  final int? callFlag;

  AuvCallRecordConditionRequest({
    this.callTypes,
    this.callType,
    this.callFlag,
  });

  Map<String, dynamic> toJson() {
    return {
      if (callTypes != null) 'callTypes': callTypes,
      if (callType != null) 'callType': callType,
      if (callFlag != null) 'callFlag': callFlag,
    };
  }
}