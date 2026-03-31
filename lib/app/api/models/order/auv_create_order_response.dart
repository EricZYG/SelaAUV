/// 创建订单响应模型
class AuvCreateOrderResponse {
  /// 订单id
  final int? orderId;

  /// 系统订单号
  final String? orderNo;

  /// 付款币种总额，单位分
  final int? currencyFee;

  /// 付款币种编码
  final String? currencyCode;

  /// 支付链接
  final String? ppUrl;

  AuvCreateOrderResponse({
    this.orderId,
    this.orderNo,
    this.currencyFee,
    this.currencyCode,
    this.ppUrl,
  });

  factory AuvCreateOrderResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCreateOrderResponse();
    return AuvCreateOrderResponse(
      orderId: json['orderId'],
      orderNo: json['orderNo'],
      currencyFee: json['currencyFee'],
      currencyCode: json['currencyCode'],
      ppUrl: json['ppUrl'],
    );
  }

  /// 获取付款金额显示
  String get currencyFeeDisplay {
    if (currencyFee == null || currencyCode == null) return '';
    return '${(currencyFee! / 100).toStringAsFixed(2)} $currencyCode';
  }
}
