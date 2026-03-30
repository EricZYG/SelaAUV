/// 金币商城商店模型
class AuvExchangeStoreResponse {
  /// 商店id
  final int? storeId;

  /// 金币，小数点后两位
  final int? coins;

  /// 兑换钻石，小数点后两位
  final int? diamonds;

  AuvExchangeStoreResponse({
    this.storeId,
    this.coins,
    this.diamonds,
  });

  factory AuvExchangeStoreResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvExchangeStoreResponse();
    return AuvExchangeStoreResponse(
      storeId: json['storeId'],
      coins: json['coins'],
      diamonds: json['diamonds'],
    );
  }

  /// 获取金币显示
  String get coinsDisplay {
    if (coins == null) return '0';
    return (coins! / 100).toStringAsFixed(0);
  }

  /// 获取钻石显示
  String get diamondsDisplay {
    if (diamonds == null) return '0';
    return (diamonds! / 100).toStringAsFixed(0);
  }

  /// 获取兑换比例描述
  String get exchangeRateDesc {
    if (coins == null || diamonds == null || coins == 0 || diamonds == 0) {
      return '无兑换比例';
    }
    return '1金币 = ${(diamonds! / coins!).toStringAsFixed(2)}钻石';
  }
}