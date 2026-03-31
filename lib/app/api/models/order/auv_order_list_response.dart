/// 获取订单列表响应模型
class AuvOrderListResponse {
  /// 订单列表
  final List<AuvOrderListItem>? list;

  /// 总条数
  final int? total;

  /// 当前第几页
  final int? pageNum;

  /// 每页条数
  final int? size;

  /// 总页数
  final int? pages;

  /// 是否第一页
  final bool? isFirstPage;

  /// 是否最后一页
  final bool? isLastPage;

  /// 是否存在上一页
  final bool? hasPreviousPage;

  /// 是否存在下一页
  final bool? hasNextPage;

  AuvOrderListResponse({
    this.list,
    this.total,
    this.pageNum,
    this.size,
    this.pages,
    this.isFirstPage,
    this.isLastPage,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory AuvOrderListResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvOrderListResponse();
    return AuvOrderListResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvOrderListItem.fromJson(e))
          .toList(),
      total: json['total'],
      pageNum: json['pageNum'],
      size: json['size'],
      pages: json['pages'],
      isFirstPage: json['isFirstPage'],
      isLastPage: json['isLastPage'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
    );
  }
}

/// 订单列表项模型
class AuvOrderListItem {
  /// 订单id
  final int? orderId;

  /// 系统订单号
  final String? orderNo;

  /// 商品类型
  /// 1.普通商品 2.折扣商品 3.vip商品
  final int? productType;

  /// 支付类型
  /// 1.GOOGLE 2.APPLE
  final int? ppType;

  /// 支付渠道名称
  final String? ccName;

  /// 付款币种总额，单位分
  final int? currencyFee;

  /// 付款币种编码
  final String? currencyCode;

  /// 钻石数，小数点后两位
  final int? diamonds;

  /// vip天数
  final int? vipDays;

  /// 视频卡数量
  final int? callCardNum;

  /// 匹配卡数量
  final int? matchCardNum;

  /// 聊天卡数量
  final int? chatCardNum;

  /// 订单状态
  /// 0.待支付 1.已支付 2.已退款 3.已关闭
  final int? orderStatus;

  /// 创建时间
  final int? createdAt;

  AuvOrderListItem({
    this.orderId,
    this.orderNo,
    this.productType,
    this.ppType,
    this.ccName,
    this.currencyFee,
    this.currencyCode,
    this.diamonds,
    this.vipDays,
    this.callCardNum,
    this.matchCardNum,
    this.chatCardNum,
    this.orderStatus,
    this.createdAt,
  });

  factory AuvOrderListItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvOrderListItem();
    return AuvOrderListItem(
      orderId: json['orderId'],
      orderNo: json['orderNo'],
      productType: json['productType'],
      ppType: json['ppType'],
      ccName: json['ccName'],
      currencyFee: json['currencyFee'],
      currencyCode: json['currencyCode'],
      diamonds: json['diamonds'],
      vipDays: json['vipDays'],
      callCardNum: json['callCardNum'],
      matchCardNum: json['matchCardNum'],
      chatCardNum: json['chatCardNum'],
      orderStatus: json['orderStatus'],
      createdAt: json['createdAt'],
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
      default:
        return '未知';
    }
  }

  /// 获取支付类型描述
  String get ppTypeDesc {
    switch (ppType) {
      case 1:
        return 'GOOGLE';
      case 2:
        return 'APPLE';
      default:
        return '未知';
    }
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
}
