/// 银行收款渠道模型
///
/// 表示银行收款渠道信息
///
/// 字段说明:
/// - payId: 收款id
/// - payoutType: 收款类型
/// - channelType: 支付渠道编码
/// - channelName: 支付渠道名称
/// - nationalFlagPath: 图标
class AuvPayoutChannelResponse {
  /// 收款id
  final int? payId;

  /// 收款类型
  final int? payoutType;

  /// 支付渠道编码
  final String? channelType;

  /// 支付渠道名称
  final String? channelName;

  /// 图标
  final String? nationalFlagPath;

  AuvPayoutChannelResponse({
    this.payId,
    this.payoutType,
    this.channelType,
    this.channelName,
    this.nationalFlagPath,
  });

  factory AuvPayoutChannelResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvPayoutChannelResponse();
    return AuvPayoutChannelResponse(
      payId: json['payId'],
      payoutType: json['payoutType'],
      channelType: json['channelType'],
      channelName: json['channelName'],
      nationalFlagPath: json['nationalFlagPath'],
    );
  }
}