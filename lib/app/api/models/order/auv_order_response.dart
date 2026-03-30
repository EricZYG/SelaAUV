/// 订单模型
/// 
/// 表示创建的充值订单
/// 
/// 字段说明:
/// - orderId: 订单ID
/// - orderNo: 订单号
/// - amount: 订单金额
/// - payUrl: 支付链接(跳转后完成支付)
/// - productName: 商品名称
/// - diamonds: 购买钻石数量
class AuvOrderResponse {
  /// 订单ID
  final int orderId;
  
  /// 订单号
  final String orderNo;
  
  /// 订单金额
  final int amount;
  
  /// 支付链接
  final String? payUrl;
  
  /// 商品名称
  final String? productName;
  
  /// 购买钻石数量
  final int? diamonds;

  AuvOrderResponse({
    required this.orderId,
    required this.orderNo,
    required this.amount,
    this.payUrl,
    this.productName,
    this.diamonds,
  });

  factory AuvOrderResponse.fromJson(Map<String, dynamic> json) {
    return AuvOrderResponse(
      orderId: json['order_id'] ?? json['orderId'] ?? 0,
      orderNo: json['order_no'] ?? json['orderNo'] ?? '',
      amount: json['amount'] ?? 0,
      payUrl: json['pay_url'] ?? json['payUrl'],
      productName: json['product_name'] ?? json['productName'],
      diamonds: json['diamonds'],
    );
  }
}