/// 降档营销配置模型
class AuvDowngradeConfigResponse {
  /// 浏览商品次数
  final int? viewProductCount;

  /// 浏览支付渠道次数
  final int? viewPayCount;

  /// 总轮次
  final int? roundCount;

  AuvDowngradeConfigResponse({
    this.viewProductCount,
    this.viewPayCount,
    this.roundCount,
  });

  factory AuvDowngradeConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvDowngradeConfigResponse();
    return AuvDowngradeConfigResponse(
      viewProductCount: json['viewProductCount'],
      viewPayCount: json['viewPayCount'],
      roundCount: json['roundCount'],
    );
  }
}
