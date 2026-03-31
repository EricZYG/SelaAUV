import 'auv_order_list_request.dart';

/// 获取简单订单列表请求模型
class AuvGetOrderSimpleListRequest {
  final int pageNum;
  final int pageSize;
  final AuvOrderListCondition? condition;

  AuvGetOrderSimpleListRequest({
    required this.pageNum,
    required this.pageSize,
    this.condition,
  });

  Map<String, dynamic> toJson() => {
    'pageNum': pageNum,
    'pageSize': pageSize,
    if (condition != null) 'condition': condition!.toJson(),
  };
}
