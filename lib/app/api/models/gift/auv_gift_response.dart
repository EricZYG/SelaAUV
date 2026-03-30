/// 礼物模型
/// 
/// 表示可赠送的礼物信息
/// 
/// 字段说明:
/// - id: 礼物ID
/// - name: 礼物名称
/// - icon: 礼物图标URL
/// - price: 礼物价格
/// - giftType: 礼物类型(1:普通礼物, 2:幸运礼物等)
/// - giftUrl: 礼物动图URL
/// - animationUrl: 动画效果URL
/// - diamonds: 所需钻石数
class AuvGiftResponse {
  /// 礼物ID
  final int id;
  
  /// 礼物名称
  final String name;
  
  /// 礼物图标URL
  final String icon;
  
  /// 礼物价格
  final int price;
  
  /// 礼物类型
  /// 1: 普通礼物
  /// 2: 幸运礼物
  final int? giftType;
  
  /// 礼物动图URL
  final String? giftUrl;
  
  /// 动画效果URL
  final String? animationUrl;
  
  /// 所需钻石数
  final int? diamonds;

  AuvGiftResponse({
    required this.id,
    required this.name,
    required this.icon,
    required this.price,
    this.giftType,
    this.giftUrl,
    this.animationUrl,
    this.diamonds,
  });

  factory AuvGiftResponse.fromJson(Map<String, dynamic> json) {
    return AuvGiftResponse(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      price: json['price'] ?? 0,
      giftType: json['gift_type'] ?? json['giftType'],
      giftUrl: json['gift_url'] ?? json['giftUrl'],
      animationUrl: json['animation_url'] ?? json['animationUrl'],
      diamonds: json['diamonds'],
    );
  }
}