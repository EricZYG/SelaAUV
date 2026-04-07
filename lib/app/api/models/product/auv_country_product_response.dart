/// 商品支付渠道信息模型
/// 
/// 对应支付渠道列表中的单个支付渠道
class AuvProductPayChannelVo {
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

  /// 是否上报美元价格
  /// 0.上报当地货币
  /// 1.上报美元价格
  final int? uploadUsd;

  /// 支付渠道排序
  final int? ppOrder;

  /// 是否浏览器打开支付链接
  /// 0.否
  /// 1.是
  final int? browserOpen;

  /// 当地货币价格（单位分）
  final int? currencyPrice;

  /// 货币编码
  final String? currencyCode;

  /// 钻石数（emma新版本才有，小数点后两位）
  final int? diamonds;

  /// vip天数（emma新版本才有）
  final int? vipDays;

  /// 视频卡数量（emma新版本才有）
  final int? callCardNum;

  /// 匹配卡数量（emma新版本才有）
  final int? matchCardNum;

  /// 聊天卡数量（emma新版本才有）
  final int? chatCardNum;

  AuvProductPayChannelVo({
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
    this.diamonds,
    this.vipDays,
    this.callCardNum,
    this.matchCardNum,
    this.chatCardNum,
  });

  factory AuvProductPayChannelVo.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvProductPayChannelVo();
    return AuvProductPayChannelVo(
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
      diamonds: json['diamonds'],
      vipDays: json['vipDays'],
      callCardNum: json['callCardNum'],
      matchCardNum: json['matchCardNum'],
      chatCardNum: json['chatCardNum'],
    );
  }
}

/// 按国家获取单个商品响应模型
/// 
/// 对应接口: GET /p/product/getCountryProduct
/// 
/// 获取特定国家的商品详细信息，包含支付渠道列表
class AuvCountryProductResponse {
  /// 商品id
  final int productId;

  /// 商品编码
  final String productCode;

  /// 美元价格（单位分）
  final int? price;

  /// 钻石数（小额点后两位）
  final int? diamonds;

  /// 赠送钻石数（小额点后两位）
  final int? bonus;

  /// vip天数
  final int? vipDays;

  /// 视频卡数量
  final int? callCardNum;

  /// 匹配卡数量
  final int? matchCardNum;

  /// 聊天卡数量
  final int? chatCardNum;

  /// 商品类型
  /// 1.普通商品
  /// 2.折扣商品
  /// 3.vip商品
  final int? productType;

  /// 折扣类型
  /// 1.首充折扣
  /// 2.单次折扣
  /// 3.限时折扣
  final int? discountType;

  /// 折扣（10表示优惠10%）
  final int? discount;

  /// 商品排序
  final int? productOrder;

  /// vip每天当地货币价格（单位分）
  final int? vipUnitPrice;

  /// 当地货币价格（单位分）
  final int? currencyPrice;

  /// 货币编码
  final String? currencyCode;

  /// 支付渠道列表
  final List<AuvProductPayChannelVo>? ppp;

  AuvCountryProductResponse({
    required this.productId,
    required this.productCode,
    this.price,
    this.diamonds,
    this.bonus,
    this.vipDays,
    this.callCardNum,
    this.matchCardNum,
    this.chatCardNum,
    this.productType,
    this.discountType,
    this.discount,
    this.productOrder,
    this.vipUnitPrice,
    this.currencyPrice,
    this.currencyCode,
    this.ppp,
  });

  factory AuvCountryProductResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvCountryProductResponse(
        productId: 0,
        productCode: '',
      );
    }
    return AuvCountryProductResponse(
      productId: json['productId'] ?? 0,
      productCode: json['productCode'] ?? '',
      price: json['price'],
      diamonds: json['diamonds'],
      bonus: json['bonus'],
      vipDays: json['vipDays'],
      callCardNum: json['callCardNum'],
      matchCardNum: json['matchCardNum'],
      chatCardNum: json['chatCardNum'],
      productType: json['productType'],
      discountType: json['discountType'],
      discount: json['discount'],
      productOrder: json['productOrder'],
      vipUnitPrice: json['vipUnitPrice'],
      currencyPrice: json['currencyPrice'],
      currencyCode: json['currencyCode'],
      ppp: (json['ppp'] as List?)
          ?.map((e) => AuvProductPayChannelVo.fromJson(e))
          .toList(),
    );
  }

  /// 商品类型描述
  String get productTypeDesc {
    switch (productType) {
      case 1:
        return '普通商品';
      case 2:
        return '折扣商品';
      case 3:
        return 'VIP商品';
      default:
        return '未知';
    }
  }

  /// 折扣类型描述
  String get discountTypeDesc {
    switch (discountType) {
      case 1:
        return '首充折扣';
      case 2:
        return '单次折扣';
      case 3:
        return '限时折扣';
      default:
        return '无折扣';
    }
  }

  /// 是否有折扣
  bool get hasDiscount => discount != null && discount! > 0;

  /// 格式化当地货币价格
  String get formattedCurrencyPrice {
    if (currencyPrice == null) return '';
    final price = currencyPrice! / 100;
    return '$currencyCode $price';
  }

  /// 获取第一个支付渠道
  AuvProductPayChannelVo? get firstPayChannel => ppp?.firstOrNull;
}
