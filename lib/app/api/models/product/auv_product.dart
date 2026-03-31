/// 商品模型
/// 
/// 表示应用内的商品信息
class AuvProduct {
  /// 商品ID
  final int? id;

  /// 商品编码
  final String? productCode;

  /// 商品名称
  final String? name;

  /// 商品类型
  /// 
  /// 1.充值中心, 2.快捷弹窗, 3.充值VIP
  final int? type;

  /// 钻石数量
  final int? diamonds;

  /// 原价（如果有折扣）
  final double? originalPrice;

  /// 现价
  final double? price;

  /// 货币单位
  final String? currency;

  /// 图标URL
  final String? icon;

  /// 描述
  final String? description;

  /// 是否可用
  final bool? available;

  /// 排序权重
  final int? sortOrder;

  AuvProduct({
    this.id,
    this.productCode,
    this.name,
    this.type,
    this.diamonds,
    this.originalPrice,
    this.price,
    this.currency,
    this.icon,
    this.description,
    this.available,
    this.sortOrder,
  });

  factory AuvProduct.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvProduct();
    return AuvProduct(
      id: json['id'],
      productCode: json['productCode'],
      name: json['name'],
      type: json['type'],
      diamonds: json['diamonds'],
      originalPrice: json['originalPrice']?.toDouble(),
      price: json['price']?.toDouble(),
      currency: json['currency'],
      icon: json['icon'],
      description: json['description'],
      available: json['available'],
      sortOrder: json['sortOrder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'name': name,
      'type': type,
      'diamonds': diamonds,
      'originalPrice': originalPrice,
      'price': price,
      'currency': currency,
      'icon': icon,
      'description': description,
      'available': available,
      'sortOrder': sortOrder,
    };
  }
}
