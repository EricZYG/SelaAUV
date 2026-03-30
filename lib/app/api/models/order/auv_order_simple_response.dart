/// 订单简要信息模型
class AuvOrderSimpleResponse {
  /// 订单id
  final int? orderId;

  /// 系统订单号
  final String? orderNo;

  /// 交易订单号
  final String? tradeNo;

  /// 商品类型
  /// 1.普通商品
  /// 2.折扣商品
  /// 3.vip商品
  /// 4.普通中奖商品
  /// 5.幸运中奖商品
  /// 6.节日中奖商品
  final int? productType;

  /// 支付类型
  /// 1.GOOGLE
  /// 2.APPLE
  final int? payType;

  /// 支付渠道名称
  final String? channelName;

  /// 付款币种总额，单位分
  final int? currencyFee;

  /// 付款币种编码
  final String? currencyCode;

  /// 钻石数，小数点后两位
  final int? diamonds;

  /// vip天数
  final int? vipDays;

  /// 订单状态
  /// 0.待支付
  /// 1.已支付
  /// 2.已退款
  /// 3.已关闭
  final int? orderStatus;

  /// 创建时间
  final int? createdAt;

  /// 修改时间
  final int? updatedAt;

  /// 支付成功时间
  final int? paidAt;

  AuvOrderSimpleResponse({
    this.orderId,
    this.orderNo,
    this.tradeNo,
    this.productType,
    this.payType,
    this.channelName,
    this.currencyFee,
    this.currencyCode,
    this.diamonds,
    this.vipDays,
    this.orderStatus,
    this.createdAt,
    this.updatedAt,
    this.paidAt,
  });

  factory AuvOrderSimpleResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvOrderSimpleResponse();
    return AuvOrderSimpleResponse(
      orderId: json['orderId'],
      orderNo: json['orderNo'],
      tradeNo: json['tradeNo'],
      productType: json['productType'],
      payType: json['payType'],
      channelName: json['channelName'],
      currencyFee: json['currencyFee'],
      currencyCode: json['currencyCode'],
      diamonds: json['diamonds'],
      vipDays: json['vipDays'],
      orderStatus: json['orderStatus'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      paidAt: json['paidAt'],
    );
  }

  /// 获取订单状态描述
  String get orderStatusDesc {
    switch (orderStatus) {
      case 0:
        return '待支付';
      case 1:
        return '已支付';
      case 2:
        return '已退款';
      case 3:
        return '已关闭';
      default:
        return '未知';
    }
  }

  /// 获取商品类型描述
  String get productTypeDesc {
    switch (productType) {
      case 1:
        return '普通商品';
      case 2:
        return '折扣商品';
      case 3:
        return 'VIP商品';
      case 4:
        return '普通中奖商品';
      case 5:
        return '幸运中奖商品';
      case 6:
        return '节日中奖商品';
      default:
        return '未知';
    }
  }

  /// 获取支付类型描述
  String get payTypeDesc {
    switch (payType) {
      case 1:
        return 'GOOGLE';
      case 2:
        return 'APPLE';
      default:
        return '未知';
    }
  }

  /// 获取钻石显示
  String get diamondsDisplay {
    if (diamonds == null) return '0';
    return (diamonds! / 100).toStringAsFixed(0);
  }

  /// 获取付款金额显示
  String get currencyFeeDisplay {
    if (currencyFee == null || currencyCode == null) return '';
    return '${(currencyFee! / 100).toStringAsFixed(2)} $currencyCode';
  }

  /// 获取创建时间
  DateTime? get createTime {
    if (createdAt == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt!);
  }

  /// 获取支付成功时间
  DateTime? get payTime {
    if (paidAt == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(paidAt!);
  }
}