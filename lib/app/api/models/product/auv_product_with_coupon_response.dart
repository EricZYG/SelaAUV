/// 带优惠券的商品模型
library;

import 'auv_product_pay_channel_response.dart';
import 'auv_product_coupon_response.dart';

/// 分次订单模型
/// 【遗漏】
class AuvProductSplitResponse {
  /// 分次天数
  final int? splitDay;

  /// 钻石数
  final int? diamonds;

  /// 赠送钻石数
  final int? bonus;

  /// VIP天数
  final int? vipDays;

  /// 视频卡数量
  final int? callCardNum;

  /// 匹配卡数量
  final int? matchCardNum;

  /// 聊天卡数量
  final int? chatCardNum;

  AuvProductSplitResponse({
    this.splitDay,
    this.diamonds,
    this.bonus,
    this.vipDays,
    this.callCardNum,
    this.matchCardNum,
    this.chatCardNum,
  });

  factory AuvProductSplitResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvProductSplitResponse();
    return AuvProductSplitResponse(
      splitDay: json['splitDay'],
      diamonds: json['diamonds'],
      bonus: json['bonus'],
      vipDays: json['vipDays'],
      callCardNum: json['callCardNum'],
      matchCardNum: json['matchCardNum'],
      chatCardNum: json['chatCardNum'],
    );
  }
}

class AuvProductWithCouponResponse {
  /// 商品id
  final int? productId;

  ///note 与后台进行绑定的id 商品编码
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
  /// 4.活动折扣
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

  /// 【遗漏】分次订单列表
  final List<AuvProductSplitResponse>? splits;

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
    this.splits,
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
      splits: (json['splits'] as List<dynamic>?)
          ?.map((e) => AuvProductSplitResponse.fromJson(e))
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

  /// 是否有分次订单
  bool get hasSplits => splits != null && splits!.isNotEmpty;
}