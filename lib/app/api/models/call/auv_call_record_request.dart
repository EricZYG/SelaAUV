import 'auv_call_record_condition_request.dart';

export 'auv_call_record_condition_request.dart';

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
