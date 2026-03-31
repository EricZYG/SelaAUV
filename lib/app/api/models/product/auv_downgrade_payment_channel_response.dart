/// 降档营销商品支付渠道模型
class AuvDowngradePaymentChannelResponse {
  /// 支付渠道id
  final int? ppId;

  /// 支付类型
  final int? ppType;

  /// 支付渠道编码
  final String? ccType;

  /// 支付渠道名称
  final String? ccName;

  /// 图标
  final String? nationalFlagPath;

  /// 是否上报美元价格，0.上报当地货币，1.上报美元价格
  final int? uploadUsd;

  /// 支付渠道排序
  final int? ppOrder;

  /// 是否浏览器打开支付链接，0.否，1.是
  final int? browserOpen;

  /// 当地货币价格，单位分
  final int? currencyPrice;

  /// 货币编码
  final String? currencyCode;

  AuvDowngradePaymentChannelResponse({
    this.ppId,
    this.ppType,
    this.ccType,
    this.ccName,
    this.nationalFlagPath,
    this.uploadUsd,
    this.ppOrder,
    this.browserOpen,
    this.currencyPrice,
    this.currencyCode,
  });

  factory AuvDowngradePaymentChannelResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvDowngradePaymentChannelResponse();
    return AuvDowngradePaymentChannelResponse(
      ppId: json['ppId'],
      ppType: json['ppType'],
      ccType: json['ccType'],
      ccName: json['ccName'],
      nationalFlagPath: json['nationalFlagPath'],
      uploadUsd: json['uploadUsd'],
      ppOrder: json['ppOrder'],
      browserOpen: json['browserOpen'],
      currencyPrice: json['currencyPrice'],
      currencyCode: json['currencyCode'],
    );
  }
}
