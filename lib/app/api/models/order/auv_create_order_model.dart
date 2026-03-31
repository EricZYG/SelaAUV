/// 创建订单请求模型
class AuvCreateOrderParams {
  /// 支付渠道id（必填）
  final int ppId;

  /// 商品id（必填）
  final int productId;

  /// 引导充值的主播（可选）
  final int? anchorUserId;

  /// 优惠券记录id（可选）
  final int? couponRecordId;

  /// 充值转化的虚拟视频id（可选）
  final int? videoId;

  /// 下单路径（可选）
  /// rechargeCenter: 充值中心
  /// vipCenter: VIP中心
  /// homeRecharge: 首页充值按钮
  /// chatMsgNoMoney: 私聊发送消息充值
  /// createCallNoMoney: 拨打电话没钱
  /// createAibCallNoMoney: 拨打aib电话没钱
  /// callEndRecharge: 拨打结束页面充值
  /// callGiftRecharge: 通话过程礼物充值
  /// aivGiftRecharge: 通话过程礼物充值
  /// aivOpenVoice: aiv打开声音按钮
  /// callCountDownRecharge: 通话过程中30s倒计时按钮充值
  /// matchNoMoney: 匹配没钱
  /// matchDiamondButton: 匹配界面的充值按钮
  /// chatMsgGift: 私聊礼物充值
  /// callDiamondItemRecharge: 通话界面钻石按钮充值
  /// aivDiamondItemRecharge: aiv通话界面钻石按钮充值
  final String? createPath;

  /// 游戏房间ID（可选）
  final int? gameRoomId;

  /// payerMax前置组件支付token（可选）
  final String? paymentToken;

  /// payerMax前置组件sessionKey（可选）
  final String? sessionKey;

  AuvCreateOrderParams({
    required this.ppId,
    required this.productId,
    this.anchorUserId,
    this.couponRecordId,
    this.videoId,
    this.createPath,
    this.gameRoomId,
    this.paymentToken,
    this.sessionKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'ppId': ppId,
      'productId': productId,
      if (anchorUserId != null) 'anchorUserId': anchorUserId,
      if (couponRecordId != null) 'couponRecordId': couponRecordId,
      if (videoId != null) 'videoId': videoId,
      if (createPath != null) 'createPath': createPath,
      if (gameRoomId != null) 'gameRoomId': gameRoomId,
      if (paymentToken != null) 'paymentToken': paymentToken,
      if (sessionKey != null) 'sessionKey': sessionKey,
    };
  }
}

/// 创建订单响应模型
class AuvCreateOrderResponse {
  /// 订单id
  final int? orderId;

  /// 系统订单号
  final String? orderNo;

  /// 付款币种总额，单位分
  final int? currencyFee;

  /// 付款币种编码
  final String? currencyCode;

  /// 支付链接
  final String? ppUrl;

  AuvCreateOrderResponse({
    this.orderId,
    this.orderNo,
    this.currencyFee,
    this.currencyCode,
    this.ppUrl,
  });

  factory AuvCreateOrderResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCreateOrderResponse();
    return AuvCreateOrderResponse(
      orderId: json['orderId'],
      orderNo: json['orderNo'],
      currencyFee: json['currencyFee'],
      currencyCode: json['currencyCode'],
      ppUrl: json['ppUrl'],
    );
  }

  /// 获取付款金额显示
  String get currencyFeeDisplay {
    if (currencyFee == null || currencyCode == null) return '';
    return '${(currencyFee! / 100).toStringAsFixed(2)} $currencyCode';
  }
}
