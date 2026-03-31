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
