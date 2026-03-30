/// 带优惠券的商品模型
library;

import 'auv_product_pay_channel_response.dart';
import 'auv_product_coupon_response.dart';

class AuvProductWithCouponResponse {
  /// 商品id
  final int? productId;

  /// 商品编码
  final String? productCode;

  /// 美元价格（单位分）
  final int? price;

  /// 钻石数（小数点后两位）
  final int? diamonds;

  /// 赠送钻石数（小数点后两位）
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
  final List<AuvProductPayChannelResponse>? ppp;

  /// 优惠券列表
  final List<AuvProductCouponResponse>? coupons;

  AuvProductWithCouponResponse({
    this.productId,
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
    this.coupons,
  });

  factory AuvProductWithCouponResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvProductWithCouponResponse();
    return AuvProductWithCouponResponse(
      productId: json['productId'],
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
          ?.map((e) => AuvProductPayChannelResponse.fromJson(e))
          .toList(),
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => AuvProductCouponResponse.fromJson(e))
          .toList(),
    );
  }

  /// 格式化价格显示
  String get formattedPrice {
    if (currencyPrice == null || currencyCode == null) {
      return '${(price ?? 0) / 100} USD';
    }
    return '${(currencyPrice! / 100).toStringAsFixed(2)} $currencyCode';
  }

  /// 是否有优惠券
  bool get hasCoupons => coupons != null && coupons!.isNotEmpty;
}