/// 优惠券模型
class AuvCoupon {
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
  /// couponType为1、2、4、5时：单位为百分之多少
  /// couponType为3时：单位为钻石数（小数点后两位）
  /// couponType为6时：单位为天数
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
  /// productUnit为1时：单位为钻石数（小数点后两位）
  /// productUnit为2时：单位为天数
  final int? productValue;

  /// 使用限制范围最小值（productSymbol=4时有值）
  final int? productMin;

  /// 使用限制范围最大值（productSymbol=4时有值）
  final int? productMax;

  AuvCoupon({
    this.couponId,
    this.couponType,
    this.couponValue,
    this.productSymbol,
    this.productUnit,
    this.productValue,
    this.productMin,
    this.productMax,
  });

  factory AuvCoupon.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCoupon();
    return AuvCoupon(
      couponId: json['couponId'],
      couponType: json['couponType'],
      couponValue: json['couponValue'],
      productSymbol: json['productSymbol'],
      productUnit: json['productUnit'],
      productValue: json['productValue'],
      productMin: json['productMin'],
      productMax: json['productMax'],
    );
  }

  /// 获取优惠券类型描述
  String get couponTypeDesc {
    switch (couponType) {
      case 1:
        return '钻石商品价格打折';
      case 2:
        return '钻石商品加赠钻石百分比';
      case 3:
        return '钻石商品加赠钻石固定值';
      case 4:
        return 'VIP商品价格打折';
      case 5:
        return 'VIP商品加赠天数百分比';
      case 6:
        return 'VIP商品加赠天数固定值';
      default:
        return '未知类型';
    }
  }

  /// 获取优惠值显示
  String get couponValueDisplay {
    if (couponValue == null) return '';
    switch (couponType) {
      case 1:
      case 4:
        return '${couponValue}%off';
      case 2:
      case 5:
        return '+$couponValue%';
      case 3:
        return '+${(couponValue! / 100).toStringAsFixed(0)}💎';
      case 6:
        return '+$couponValue天';
      default:
        return '$couponValue';
    }
  }

  /// 获取使用限制描述
  String get productLimitDesc {
    if (productSymbol == null || productSymbol == 0) {
      return '无限制';
    }

    final unitStr = productUnit == 1 ? '钻石' : '天数';
    final valueStr = _formatValue(productValue ?? 0, productUnit ?? 1);

    switch (productSymbol) {
      case 1:
        return '不满$valueStr$unitStr可用';
      case 2:
        return '购买$valueStr$unitStr可用';
      case 3:
        return '购买$valueStr${unitStr}以上可用';
      case 4:
        final minStr = _formatValue(productMin ?? 0, productUnit ?? 1);
        final maxStr = _formatValue(productMax ?? 0, productUnit ?? 1);
        return '$minStr-$maxStr$unitStr可用';
      default:
        return '';
    }
  }

  String _formatValue(int value, int unit) {
    if (unit == 1) {
      // 钻石数，单位是小数点后两位（除以100）
      return (value / 100).toStringAsFixed(0);
    } else {
      // 天数
      return value.toString();
    }
  }
}

/// 用户优惠券模型（已领取的优惠券）
class AuvUserCoupon {
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
  /// 0.无限制, 1.小于, 2.等于, 3.大于, 4.范围
  final int? productSymbol;

  /// 使用限制单位
  /// 1.钻石数, 2.vip天数
  final int? productUnit;

  /// 使用限制数值
  final int? productValue;

  /// 使用限制范围最小值
  final int? productMin;

  /// 使用限制范围最大值
  final int? productMax;

  /// 优惠券状态：0.未使用，1.已使用
  final int? couponStatus;

  /// 是否过期：0.未过期，1.已过期
  final int? expireFlag;

  /// 过期时间，时间戳
  final int? endTime;

  AuvUserCoupon({
    this.recordId,
    this.couponId,
    this.couponType,
    this.couponValue,
    this.productSymbol,
    this.productUnit,
    this.productValue,
    this.productMin,
    this.productMax,
    this.couponStatus,
    this.expireFlag,
    this.endTime,
  });

  factory AuvUserCoupon.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvUserCoupon();
    return AuvUserCoupon(
      recordId: json['recordId'],
      couponId: json['couponId'],
      couponType: json['couponType'],
      couponValue: json['couponValue'],
      productSymbol: json['productSymbol'],
      productUnit: json['productUnit'],
      productValue: json['productValue'],
      productMin: json['productMin'],
      productMax: json['productMax'],
      couponStatus: json['couponStatus'],
      expireFlag: json['expireFlag'],
      endTime: json['endTime'],
    );
  }

  /// 是否可用（未使用且未过期）
  bool get isAvailable => couponStatus == 0 && expireFlag == 0;

  /// 获取优惠券类型描述
  String get couponTypeDesc {
    switch (couponType) {
      case 1:
        return '钻石商品价格打折';
      case 2:
        return '钻石商品加赠钻石百分比';
      case 3:
        return '钻石商品加赠钻石固定值';
      case 4:
        return 'VIP商品价格打折';
      case 5:
        return 'VIP商品加赠天数百分比';
      case 6:
        return 'VIP商品加赠天数固定值';
      default:
        return '未知类型';
    }
  }

  /// 获取优惠值显示
  String get couponValueDisplay {
    if (couponValue == null) return '';
    switch (couponType) {
      case 1:
      case 4:
        return '${couponValue}%off';
      case 2:
      case 5:
        return '+$couponValue%';
      case 3:
        return '+${(couponValue! / 100).toStringAsFixed(0)}💎';
      case 6:
        return '+$couponValue天';
      default:
        return '$couponValue';
    }
  }

  /// 获取使用限制描述
  String get productLimitDesc {
    if (productSymbol == null || productSymbol == 0) {
      return '无限制';
    }

    final unitStr = productUnit == 1 ? '钻石' : '天数';
    final valueStr = _formatValue(productValue ?? 0, productUnit ?? 1);

    switch (productSymbol) {
      case 1:
        return '不满$valueStr$unitStr可用';
      case 2:
        return '购买$valueStr$unitStr可用';
      case 3:
        return '购买$valueStr${unitStr}以上可用';
      case 4:
        final minStr = _formatValue(productMin ?? 0, productUnit ?? 1);
        final maxStr = _formatValue(productMax ?? 0, productUnit ?? 1);
        return '$minStr-$maxStr$unitStr可用';
      default:
        return '';
    }
  }

  /// 格式化过期时间
  String? get expireTimeStr {
    if (endTime == null) return null;
    final date = DateTime.fromMillisecondsSinceEpoch(endTime!);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatValue(int value, int unit) {
    if (unit == 1) {
      return (value / 100).toStringAsFixed(0);
    } else {
      return value.toString();
    }
  }
}
