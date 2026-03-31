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

/// 获取订单列表查询条件模型
class AuvOrderListCondition {
  /// 商品类型
  /// 1.普通商品 2.折扣商品 3.vip商品
  /// 不传为查询全部
  final int? productType;

  /// 订单状态
  /// 0.待支付 1.已支付 2.已退款 3.已关闭
  /// 不传为查询全部
  final int? orderStatus;

  AuvOrderListCondition({
    this.productType,
    this.orderStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      if (productType != null) 'productType': productType,
      if (orderStatus != null) 'orderStatus': orderStatus,
    };
  }
}
