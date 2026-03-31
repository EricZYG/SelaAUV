/// 订单状态项模型
class AuvOrderStatusItem {
  /// 系统订单号
  final String? orderNo;

  /// 订单状态
  /// 0.待支付 1.已支付 2.已退款 3.已关闭
  final int? orderStatus;

  /// 付款币种编码
  final String? currencyCode;

  /// 付款币种总额，单位分
  final int? currencyFee;

  AuvOrderStatusItem({
    this.orderNo,
    this.orderStatus,
    this.currencyCode,
    this.currencyFee,
  });

  factory AuvOrderStatusItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvOrderStatusItem();
    return AuvOrderStatusItem(
      orderNo: json['orderNo'],
      orderStatus: json['orderStatus'],
      currencyCode: json['currencyCode'],
      currencyFee: json['currencyFee'],
    );
  }

  /// 获取订单状态描述
  String get orderStatusDesc {
    switch (orderStatus) {
      case 0:
        return '待支付';
      case 1:
        return '已支付';
      case 2:
        return '已退款';
      case 3:
        return '已关闭';
      default:
        return '未知';
    }
  }

  /// 获取付款金额显示
  String get currencyFeeDisplay {
    if (currencyFee == null || currencyCode == null) return '';
    return '${(currencyFee! / 100).toStringAsFixed(2)} $currencyCode';
  }
}
