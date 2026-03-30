/// 商品支付渠道价格模型
class AuvProductPayChannelPriceResponse {
  /// 支付渠道id
  final int? ppId;

  /// 当地货币价格（单位分）
  final int? currencyPrice;

  /// 货币编码
  final String? currencyCode;

  AuvProductPayChannelPriceResponse({
    this.ppId,
    this.currencyPrice,
    this.currencyCode,
  });

  factory AuvProductPayChannelPriceResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvProductPayChannelPriceResponse();
    return AuvProductPayChannelPriceResponse(
      ppId: json['ppId'],
      currencyPrice: json['currencyPrice'],
      currencyCode: json['currencyCode'],
    );
  }
}