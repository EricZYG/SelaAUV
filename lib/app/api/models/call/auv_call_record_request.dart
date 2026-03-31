/// 获取通话记录请求模型
///
/// 获取通话记录接口的请求参数
class AuvGetCallRecordRequest {
  /// 查询条件
  /// 
  /// 包含筛选条件，如通话类型、通话状态等
  final AuvCallRecordConditionRequest? condition;

  /// 页码
  /// 
  /// 当前请求的页码，从1开始
  final int pageNum;

  /// 每页条数
  /// 
  /// 每页返回的记录数量
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
  /// 
  /// 支持多选，用于筛选特定类型的通话记录
  /// 0.正常唤起，1.AIB唤起，2.匹配唤起，3.主播邀请，4.主播免费邀请，5.免费匹配
  final List<int>? callTypes;

  /// 唤起方式
  /// 
  /// 单个唤起方式筛选
  /// 0.正常唤起，1.AIB唤起，2.匹配唤起，3.主播邀请，4.主播免费邀请，5.免费匹配
  final int? callType;

  /// 通话标志
  /// 
  /// 用于筛选通话接通状态
  /// 0.未接，1.已接
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