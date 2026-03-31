/// 挂机记录查询条件请求模型
/// 
/// 用于查询挂机记录的可选筛选条件
class AuvHangupRecordConditionRequest {
  /// 挂机类型
  /// 
  /// 1.正常模式，2.匹配模式，3.连续超时挂断
  final int? hangupType;

  AuvHangupRecordConditionRequest({
    this.hangupType,
  });

  Map<String, dynamic> toJson() {
    return {
      if (hangupType != null) 'hangupType': hangupType,
    };
  }
}