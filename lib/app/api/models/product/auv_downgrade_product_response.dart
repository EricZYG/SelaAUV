import 'auv_downgrade_payment_channel_response.dart';

/// 降档营销商品模型
class AuvDowngradeProductResponse {
  /// 商品id
  final int? productId;

  /// 商品弹窗顶部的图标
  final String? icon;

  /// 过期秒数
  final int? expireSeconds;

  /// 商品编码
  final String? productCode;

  /// 美元价格，单位分
  final int? price;

  /// 钻石数，小数点后两位
  final int? diamonds;

  /// 赠送钻石数，小数点后两位
  final int? bonus;

  /// vip天数
  final int? vipDays;

  /// 视频卡数量
  final int? callCardNum;

  /// 匹配卡数量
  final int? matchCardNum;

  /// 聊天卡数量
  final int? chatCardNum;

  /// 商品类型，1.普通商品，2.折扣商品，3.vip商品
  final int? productType;

  /// 折扣类型，1.首充折扣，2.单次折扣，3.限时折扣
  final int? discountType;

  /// 折扣（10表示优惠10%）
  final int? discount;

  /// 商品排序
  final int? productOrder;

  /// vip每天当地货币价格，单位分
  final int? vipUnitPrice;

  /// 当地货币价格，单位分
  final int? currencyPrice;

  /// 货币编码
  final String? currencyCode;

  /// 支付渠道列表
  final List<AuvDowngradePaymentChannelResponse>? ppp;

  AuvDowngradeProductResponse({
    this.productId,
    this.icon,
    this.expireSeconds,
    this.productCode,
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

  factory AuvDowngradeProductResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvDowngradeProductResponse();
    return AuvDowngradeProductResponse(
      productId: json['productId'],
      icon: json['icon'],
      expireSeconds: json['expireSeconds'],
      productCode: json['productCode'],
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
      ppp: (json['ppp'] as List<dynamic>?)
          ?.map((e) => AuvDowngradePaymentChannelResponse.fromJson(e))
          .toList(),
    );
  }

  /// 获取过期时间描述
  String get expireTimeDesc {
    if (expireSeconds == null || expireSeconds! <= 0) return '无限制';
    final minutes = expireSeconds! ~/ 60;
    final seconds = expireSeconds! % 60;
    if (minutes > 0) {
      return '$minutes分${seconds}秒后过期';
    }
    return '${seconds}秒后过期';
  }

  /// 获取钻石显示
  String get diamondsDisplay {
    if (diamonds == null) return '0';
    return (diamonds! / 100).toStringAsFixed(0);
  }

  /// 获取赠送钻石显示
  String get bonusDisplay {
    if (bonus == null || bonus! <= 0) return '0';
    return (bonus! / 100).toStringAsFixed(0);
  }

  /// 获取总钻石（钻石+赠送）
  String get totalDiamondsDisplay {
    final total = (diamonds ?? 0) + (bonus ?? 0);
    return (total / 100).toStringAsFixed(0);
  }
}
