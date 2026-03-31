import 'auv_order_list_condition.dart';

/// 获取订单列表请求模型
class AuvOrderListParams {
  /// 页码（必填）
  final int pageNum;

  /// 每页条数（必填）
  final int pageSize;

  /// 查询条件
  final AuvOrderListCondition? condition;

  AuvOrderListParams({
    required this.pageNum,
    required this.pageSize,
    this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      if (condition != null) 'condition': condition!.toJson(),
    };
  }
}
