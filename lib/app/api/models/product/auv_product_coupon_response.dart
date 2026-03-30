/// 商品可用优惠券模型（包含每个支付渠道的价格）
library;

import 'auv_product_pay_channel_price_response.dart';

class AuvProductCouponResponse {
  /// 记录ID
  final int? recordId;

  /// 优惠券id
  final int? couponId;

  /// 优惠券类型
  /// 1.钻石商品价格打折
  /// 2.钻石商品加赠钻石百分比
  /// 3.钻石商品加赠钻石固定值
  /// 4.VIP商品价格打折
  /// 5.VIP商品加赠天数百分比
  /// 6.VIP商品加赠天数固定值
  final int? couponType;

  /// 优惠数值
  final int? couponValue;

  /// 使用限制符号
  /// 0.无限制
  /// 1.小于
  /// 2.等于
  /// 3.大于
  /// 4.范围
  final int? productSymbol;

  /// 使用限制单位
  /// 1.钻石数
  /// 2.vip天数
  final int? productUnit;

  /// 使用限制数值
  final int? productValue;

  /// 使用限制范围最小值
  final int? productMin;

  /// 使用限制范围最大值
  final int? productMax;

  /// 商品编码
  final String? productCode;

  /// 美元价格（单位分）
  final int? price;

  /// 当地货币价格（单位分）
  final int? currencyPrice;

  /// 每个支付渠道的价格列表
  final List<AuvProductPayChannelPriceResponse>? pppCoupons;

  AuvProductCouponResponse({
    this.recordId,
    this.couponId,
    this.couponType,
    this.couponValue,
    this.productSymbol,
    this.productUnit,
    this.productValue,
    this.productMin,
    this.productMax,
    this.productCode,
    this.price,
    this.currencyPrice,
    this.pppCoupons,
  });

  factory AuvProductCouponResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvProductCouponResponse();
    return AuvProductCouponResponse(
      recordId: json['recordId'],
      couponId: json['couponId'],
      couponType: json['couponType'],
      couponValue: json['couponValue'],
      productSymbol: json['productSymbol'],
      productUnit: json['productUnit'],
      productValue: json['productValue'],
      productMin: json['productMin'],
      productMax: json['productMax'],
      productCode: json['productCode'],
      price: json['price'],
      currencyPrice: json['currencyPrice'],
      pppCoupons: (json['pppCoupons'] as List<dynamic>?)
          ?.map((e) => AuvProductPayChannelPriceResponse.fromJson(e))
          .toList(),
    );
  }
}