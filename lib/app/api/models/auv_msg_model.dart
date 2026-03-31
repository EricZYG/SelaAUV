import '../enums/auv_msg_type.dart';
import '../enums/auv_product.dart';

/// 消息类型枚举（已移至 enums/auv_msg_type.dart）
// enum AuvMsgType moved to enums/auv_msg_type.dart

/// 发送消息请求
class AuvSendMsgRequest {
  /// 接收者id
  final int recipientId;
  /// 消息类型 11.文字，12.图片 14.视频 15.语音
  final AuvMsgType type;
  /// 图片地址 视频地址 语音地址 文本内容
  final String urlOrContent;
  /// 客户端自己用的数据
  final String? jsonData;
  /// 额外数据
  final String? extraData;

  AuvSendMsgRequest({
    required this.recipientId,
    required this.type,
    required this.urlOrContent,
    this.jsonData,
    this.extraData,
  });

  factory AuvSendMsgRequest.text({
    required int recipientId,
    required String content,
    String? jsonData,
    String? extraData,
  }) {
    return AuvSendMsgRequest(
      recipientId: recipientId,
      type: AuvMsgType.text,
      urlOrContent: content,
      jsonData: jsonData,
      extraData: extraData,
    );
  }

  factory AuvSendMsgRequest.image({
    required int recipientId,
    required String imageUrl,
    String? jsonData,
    String? extraData,
  }) {
    return AuvSendMsgRequest(
      recipientId: recipientId,
      type: AuvMsgType.image,
      urlOrContent: imageUrl,
      jsonData: jsonData,
      extraData: extraData,
    );
  }

  factory AuvSendMsgRequest.video({
    required int recipientId,
    required String videoUrl,
    String? jsonData,
    String? extraData,
  }) {
    return AuvSendMsgRequest(
      recipientId: recipientId,
      type: AuvMsgType.video,
      urlOrContent: videoUrl,
      jsonData: jsonData,
      extraData: extraData,
    );
  }

  factory AuvSendMsgRequest.voice({
    required int recipientId,
    required String voiceUrl,
    String? jsonData,
    String? extraData,
  }) {
    return AuvSendMsgRequest(
      recipientId: recipientId,
      type: AuvMsgType.voice,
      urlOrContent: voiceUrl,
      jsonData: jsonData,
      extraData: extraData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientId': recipientId,
      'type': type.value,
      'urlOrContent': urlOrContent,
      if (jsonData != null) 'jsonData': jsonData,
      if (extraData != null) 'extraData': extraData,
    };
  }
}

/// 发送消息响应
class AuvSendMsgResponse {
  final int code;
  final String message;
  final int timestamp;

  AuvSendMsgResponse({
    required this.code,
    required this.message,
    required this.timestamp,
  });

  factory AuvSendMsgResponse.fromJson(Map<String, dynamic> json) {
    return AuvSendMsgResponse(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
    );
  }

  /// 是否发送成功
  bool get success => code == 0;

  @override
  String toString() {
    return 'AuvSendMsgResponse(code: $code, message: $message, timestamp: $timestamp)';
  }
}

/// 通话中发送消息请求
/// 
/// 在视频通话中发送消息，不校验好友关系也不扣费
class AuvSendMsgInCallRequest {
  /// 接收者id
  final int recipientId;
  /// 消息类型 11.文字，12.图片 14.视频 15.语音
  final AuvMsgType type;
  /// 通话频道id
  final int channelId;
  /// 图片地址 视频地址 语音地址 文本内容
  final String urlOrContent;
  /// 客户端自己用的数据
  final String? jsonData;

  AuvSendMsgInCallRequest({
    required this.recipientId,
    required this.type,
    required this.channelId,
    required this.urlOrContent,
    this.jsonData,
  });

  factory AuvSendMsgInCallRequest.text({
    required int recipientId,
    required int channelId,
    required String content,
    String? jsonData,
  }) {
    return AuvSendMsgInCallRequest(
      recipientId: recipientId,
      type: AuvMsgType.text,
      channelId: channelId,
      urlOrContent: content,
      jsonData: jsonData,
    );
  }

  factory AuvSendMsgInCallRequest.image({
    required int recipientId,
    required int channelId,
    required String imageUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInCallRequest(
      recipientId: recipientId,
      type: AuvMsgType.image,
      channelId: channelId,
      urlOrContent: imageUrl,
      jsonData: jsonData,
    );
  }

  factory AuvSendMsgInCallRequest.video({
    required int recipientId,
    required int channelId,
    required String videoUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInCallRequest(
      recipientId: recipientId,
      type: AuvMsgType.video,
      channelId: channelId,
      urlOrContent: videoUrl,
      jsonData: jsonData,
    );
  }

  factory AuvSendMsgInCallRequest.voice({
    required int recipientId,
    required int channelId,
    required String voiceUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInCallRequest(
      recipientId: recipientId,
      type: AuvMsgType.voice,
      channelId: channelId,
      urlOrContent: voiceUrl,
      jsonData: jsonData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientId': recipientId,
      'type': type.value,
      'channelId': channelId,
      'urlOrContent': urlOrContent,
      if (jsonData != null) 'jsonData': jsonData,
    };
  }
}

/// 游戏房间中发送消息请求
/// 
/// 在游戏房间中发送消息，recipientId固定传0
class AuvSendMsgInGameRoomRequest {
  /// 接收者id（固定传0）
  final int recipientId;
  /// 频道名称
  final String channelId;
  /// 消息类型 11.文字，12.图片 14.视频 15.语音
  final AuvMsgType type;
  /// 图片地址 视频地址 语音地址 文本内容
  final String urlOrContent;
  /// 客户端自己用的数据
  final String? jsonData;

  AuvSendMsgInGameRoomRequest({
    this.recipientId = 0,
    required this.channelId,
    required this.type,
    required this.urlOrContent,
    this.jsonData,
  });

  factory AuvSendMsgInGameRoomRequest.text({
    required String channelId,
    required String content,
    String? jsonData,
  }) {
    return AuvSendMsgInGameRoomRequest(
      channelId: channelId,
      type: AuvMsgType.text,
      urlOrContent: content,
      jsonData: jsonData,
    );
  }

  factory AuvSendMsgInGameRoomRequest.image({
    required String channelId,
    required String imageUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInGameRoomRequest(
      channelId: channelId,
      type: AuvMsgType.image,
      urlOrContent: imageUrl,
      jsonData: jsonData,
    );
  }

  factory AuvSendMsgInGameRoomRequest.video({
    required String channelId,
    required String videoUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInGameRoomRequest(
      channelId: channelId,
      type: AuvMsgType.video,
      urlOrContent: videoUrl,
      jsonData: jsonData,
    );
  }

  factory AuvSendMsgInGameRoomRequest.voice({
    required String channelId,
    required String voiceUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInGameRoomRequest(
      channelId: channelId,
      type: AuvMsgType.voice,
      urlOrContent: voiceUrl,
      jsonData: jsonData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientId': recipientId,
      'channelId': channelId,
      'type': type.value,
      'urlOrContent': urlOrContent,
      if (jsonData != null) 'jsonData': jsonData,
    };
  }
}

/// 访客记录项
class AuvUserSeeVo {
  final int userId;           // 用户id
  final String username;      // 用于显示的UID
  final String nickname;      // 昵称
  final String portrait;       // 头像
  final String birthday;       // 年龄
  final int countryCode;       // 国家编码
  final String countryPath;    // 国旗链接
  final String countryTitle;   // 国家名
  final int seeTime;           // 查看时间（时间戳）
  final int seeCount;          // 查看次数
  final int isOnline;          // 是否在线，0.离线，1.在线，2.忙线

  AuvUserSeeVo({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.portrait,
    required this.birthday,
    required this.countryCode,
    required this.countryPath,
    required this.countryTitle,
    required this.seeTime,
    required this.seeCount,
    required this.isOnline,
  });

  factory AuvUserSeeVo.fromJson(Map<String, dynamic> json) {
    return AuvUserSeeVo(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      birthday: json['birthday'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      seeTime: json['seeTime'] ?? 0,
      seeCount: json['seeCount'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
    );
  }

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙碌
  bool get isUserBusy => isOnline == 2;

  /// 是否离线
  bool get isOffline => isOnline == 0;

  /// 获取查看时间
  DateTime? get seeDateTime {
    if (seeTime <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(seeTime);
  }
}

/// 聊天记录项
class AuvMsgRecord {
  final String id;              // 主键id，用于后续传到offsetId参数
  final int fromUserId;          // 发送方用户id
  final int targetUserId;        // 接收方用户id
  final int msgType;             // 消息类型 (11.文字，12.图片 14.视频 15.语音)
  final String content;          // 消息内容
  final String jsonData;         // 发给对方的原内容
  final String extraData;        // 额外内容
  final int createdAt;           // 发送时间（时间戳）
  final String otherUsername;    // 对方用户名
  final String otherNickname;    // 对方昵称
  final String otherPortrait;    // 对方头像
  final int otherIsOnline;       // 对方是否在线

  AuvMsgRecord({
    required this.id,
    required this.fromUserId,
    required this.targetUserId,
    required this.msgType,
    required this.content,
    required this.jsonData,
    required this.extraData,
    required this.createdAt,
    required this.otherUsername,
    required this.otherNickname,
    required this.otherPortrait,
    required this.otherIsOnline,
  });

  factory AuvMsgRecord.fromJson(Map<String, dynamic> json) {
    return AuvMsgRecord(
      id: json['id'] ?? '',
      fromUserId: json['fromUserId'] ?? 0,
      targetUserId: json['targetUserId'] ?? 0,
      msgType: json['msgType'] ?? 0,
      content: json['content'] ?? '',
      jsonData: json['jsonData'] ?? '',
      extraData: json['extraData'] ?? '',
      createdAt: json['createdAt'] ?? 0,
      otherUsername: json['otherUsername'] ?? '',
      otherNickname: json['otherNickname'] ?? '',
      otherPortrait: json['otherPortrait'] ?? '',
      otherIsOnline: json['otherIsOnline'] ?? 0,
    );
  }

  /// 获取消息类型枚举
  AuvMsgType get type {
    switch (msgType) {
      case 11:
        return AuvMsgType.text;
      case 12:
        return AuvMsgType.image;
      case 14:
        return AuvMsgType.video;
      case 15:
        return AuvMsgType.voice;
      default:
        return AuvMsgType.text;
    }
  }

  /// 获取发送时间
  DateTime? get createdDateTime {
    if (createdAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt);
  }

  /// 对方是否在线
  bool get isOtherOnline => otherIsOnline == 1;
}

/// 聊天记录查询参数
class AuvGetMsgRecordsParams {
  /// 对方用户id（选填）
  final int? otherUserId;
  /// 偏移id，初始不传，后续传上次记录列表中的最后一个元素的id
  final String? offsetId;
  /// 每页条数
  final int pageSize;

  AuvGetMsgRecordsParams({
    this.otherUserId,
    this.offsetId,
    required this.pageSize,
  });

  Map<String, dynamic> toQueryParams() {
    return {
      if (otherUserId != null) 'otherUserId': otherUserId,
      if (offsetId != null) 'offsetId': offsetId,
      'pageSize': pageSize,
    };
  }
}

// ==================== 商品相关 ====================

/// 商品类型（用于获取商品列表的分类）
/// 
/// 用于区分不同的商品列表来源
enum AuvProductType {
  /// 充值中心 - 主充值页面显示的商品
  rechargeCenter(1, '充值中心'),
  
  /// 快捷弹窗 - 触发充值提示时弹出的商品
  quickPopup(2, '快捷弹窗'),
  
  /// 充值VIP - VIP会员充值的商品
  rechargeVip(3, '充值VIP');

  final int value;
  final String label;
  const AuvProductType(this.value, this.label);

  static AuvProductType fromValue(int value) {
    return AuvProductType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvProductType.rechargeCenter,
    );
  }
}

/// 商品类型（商品本身的属性）
/// 
/// 用于区分商品的销售策略类型
enum AuvProductCategory {
  /// 普通商品 - 标准价格商品
  normal(1, '普通商品'),
  
  /// 折扣商品 - 有折扣优惠的商品
  discount(2, '折扣商品'),
  
  /// VIP商品 - VIP会员专属商品
  vip(3, 'VIP商品');

  final int value;
  final String label;
  const AuvProductCategory(this.value, this.label);

  static AuvProductCategory fromValue(int value) {
    return AuvProductCategory.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvProductCategory.normal,
    );
  }
}

/// 折扣类型
/// 
/// 用于区分折扣的使用限制条件
enum AuvDiscountType {
  /// 首充折扣 - 仅首次充值可用的折扣
  firstRecharge(1, '首充折扣'),
  
  /// 单次折扣 - 每次充值都可使用的折扣
  single(2, '单次折扣'),
  
  /// 限时折扣 - 在特定时间段内有效的折扣
  limited(3, '限时折扣'),
  
  /// 分次领取 - 需要分多次领取的优惠
  multiple(4, '分次领取');

  final int value;
  final String label;
  const AuvDiscountType(this.value, this.label);

  static AuvDiscountType fromValue(int value) {
    return AuvDiscountType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvDiscountType.firstRecharge,
    );
  }
}

/// 商品项
/// 
/// 表示单个充值商品的信息
/// 
/// 对应接口:
/// - GET /p/product/getProducts - 获取商品列表
/// - GET /p/product/getCountryProduct - 按国家获取单个商品
/// 
/// 响应示例:
/// ```json
/// {
///   "productId": 1825479644239925250,
///   "productCode": "sela499",
///   "price": 499,
///   "diamonds": 800000,
///   "bonus": 10000,
///   "vipDays": 1,
///   "productType": 2,
///   "discountType": 4,
///   "currencyPrice": 499,
///   "currencyCode": "USD",
///   "ppp": [...]
/// }
/// ```
class AuvProduct {
  /// 商品ID
  /// 类型: long
  /// 说明: 商品的唯一标识符
  final int productId;

  /// 商品编码
  /// 类型: string
  /// 说明: 商品的后台编码，如"sela499"
  final String productCode;

  /// 美元价格
  /// 类型: int
  /// 说明: 商品的美元价格（单位：分），如499表示$4.99
  final int price;

  /// 钻石数量
  /// 类型: int
  /// 说明: 购买后获得的钻石数量（单位：个，非分），已除以100
  final int diamonds;

  /// 赠送钻石数量
  /// 类型: int
  /// 说明: 购买时额外赠送的钻石数量（单位：个，非分）
  final int bonus;

  /// VIP天数
  /// 类型: int
  /// 说明: 购买后获得的VIP会员天数
  final int vipDays;

  /// 视频卡数量
  /// 类型: int
  /// 说明: 购买后获得的视频通话卡数量
  final int callCardNum;

  /// 匹配卡数量
  /// 类型: int
  /// 说明: 购买后获得的匹配功能卡数量
  final int matchCardNum;

  /// 聊天卡数量
  /// 类型: int
  /// 说明: 购买后获得的聊天功能卡数量
  final int chatCardNum;

  /// 商品类型
  /// 类型: int
  /// 说明: 1.普通商品，2.折扣商品，3.VIP商品
  final int productType;

  /// 折扣类型
  /// 类型: int
  /// 说明: 1.首充折扣，2.单次折扣，3.限时折扣，4.分次领取
  final int discountType;

  /// 折扣比例
  /// 类型: int?
  /// 说明: 折扣值，如10表示优惠10%（即90折）
  final int? discount;

  /// 商品排序
  /// 类型: int
  /// 说明: 商品在列表中的显示顺序，数字越小越靠前
  final int productOrder;

  /// VIP每日价格
  /// 类型: int?
  /// 说明: VIP商品每日平均价格（单位：分），用于显示"每天仅需X元"
  final int? vipUnitPrice;

  /// 当地货币价格
  /// 类型: int
  /// 说明: 商品在用户当地的货币价格（单位：分）
  final int currencyPrice;

  /// 货币编码
  /// 类型: string
  /// 说明: 当地货币的ISO代码，如"USD"、"JPY"、"CNY"
  final String currencyCode;

  /// 分次领取列表
  /// 类型: List<AuvSplit>?
  /// 说明: 分次领取商品的分次明细，非分次商品为null
  final List<AuvSplit>? splits;

  /// 支付渠道列表
  /// 类型: List<AuvPaymentChannel>?
  /// 说明: 该商品支持的支付渠道列表
  final List<AuvPaymentChannel>? ppp;

  AuvProduct({
    required this.productId,
    required this.productCode,
    required this.price,
    required this.diamonds,
    required this.bonus,
    required this.vipDays,
    required this.callCardNum,
    required this.matchCardNum,
    required this.chatCardNum,
    required this.productType,
    required this.discountType,
    this.discount,
    required this.productOrder,
    this.vipUnitPrice,
    required this.currencyPrice,
    required this.currencyCode,
    this.splits,
    this.ppp,
  });

  factory AuvProduct.fromJson(Map<String, dynamic> json) {
    return AuvProduct(
      productId: json['productId'] ?? 0,
      productCode: json['productCode'] ?? '',
      price: json['price'] ?? 0,
      diamonds: json['diamonds'] ?? 0,
      bonus: json['bonus'] ?? 0,
      vipDays: json['vipDays'] ?? 0,
      callCardNum: json['callCardNum'] ?? 0,
      matchCardNum: json['matchCardNum'] ?? 0,
      chatCardNum: json['chatCardNum'] ?? 0,
      productType: json['productType'] ?? 1,
      discountType: json['discountType'] ?? 1,
      discount: json['discount'],
      productOrder: json['productOrder'] ?? 0,
      vipUnitPrice: json['vipUnitPrice'],
      currencyPrice: json['currencyPrice'] ?? 0,
      currencyCode: json['currencyCode'] ?? '',
      splits: json['splits'] != null
          ? (json['splits'] as List).map((e) => AuvSplit.fromJson(e)).toList()
          : null,
      ppp: json['ppp'] != null
          ? (json['ppp'] as List).map((e) => AuvPaymentChannel.fromJson(e)).toList()
          : null,
    );
  }

  /// 获取商品类别枚举
  AuvProductCategory get category => AuvProductCategory.fromValue(productType);

  /// 获取折扣类型枚举
  AuvDiscountType get discountCategory => AuvDiscountType.fromValue(discountType);

  /// 获取总钻石数（钻石+赠送）
  int get totalDiamonds => diamonds + bonus;

  /// 是否有折扣
  bool get hasDiscount => discount != null && discount! > 0;

  /// 是否是分次领取
  bool get isMultiple => discountType == AuvDiscountType.multiple.value;

  /// 是否有VIP权益
  bool get hasVipBenefit => vipDays > 0;

  /// 格式化本地价格显示
  String get formattedPrice {
    if (currencyPrice <= 0 || currencyCode.isEmpty) {
      return '${(price / 100).toStringAsFixed(2)} USD';
    }
    return '${(currencyPrice / 100).toStringAsFixed(2)} $currencyCode';
  }

  /// 获取美元价格显示
  String get formattedUsdPrice => '${(price / 100).toStringAsFixed(2)} USD';

  /// 获取钻石数量显示
  String get formattedDiamonds {
    final total = totalDiamonds;
    if (total >= 10000) {
      return '${(total / 10000).toStringAsFixed(1)}万';
    }
    return total.toString();
  }

  /// 获取折扣描述
  String? get discountDesc {
    if (!hasDiscount) return null;
    return '${discount}% OFF';
  }
}

/// 分次领取明细
/// 
/// 表示分次领取商品中每一期的领取内容
/// 
/// 仅在商品类型为分次领取(discountType=4)时才有值
/// 
/// 响应示例:
/// ```json
/// {
///   "splitDay": 1,
///   "diamonds": 100000,
///   "bonus": 0,
///   "vipDays": 0,
///   "callCardNum": 0,
///   "matchCardNum": 0,
///   "chatCardNum": 0
/// }
/// ```
class AuvSplit {
  /// 领取天数
  /// 类型: int
  /// 说明: 第几天可以领取，如1表示第一天可领取
  final int splitDay;

  /// 钻石数量
  /// 类型: int
  /// 说明: 该期可领取的钻石数量（单位：个，非分）
  final int diamonds;

  /// 赠送钻石数量
  /// 类型: int
  /// 说明: 该期可额外领取的赠送钻石数量（单位：个，非分）
  final int bonus;

  /// VIP天数
  /// 类型: int
  /// 说明: 该期可领取的VIP会员天数
  final int vipDays;

  /// 视频卡数量
  /// 类型: int
  /// 说明: 该期可领取的视频通话卡数量
  final int callCardNum;

  /// 匹配卡数量
  /// 类型: int
  /// 说明: 该期可领取的匹配功能卡数量
  final int matchCardNum;

  /// 聊天卡数量
  /// 类型: int
  /// 说明: 该期可领取的聊天功能卡数量
  final int chatCardNum;

  AuvSplit({
    required this.splitDay,
    required this.diamonds,
    required this.bonus,
    required this.vipDays,
    required this.callCardNum,
    required this.matchCardNum,
    required this.chatCardNum,
  });

  /// 获取总钻石数（钻石+赠送）
  int get totalDiamonds => diamonds + bonus;

  /// 是否有钻石
  bool get hasDiamonds => diamonds > 0;

  /// 是否有VIP权益
  bool get hasVipBenefit => vipDays > 0;

  /// 获取领取天数描述
  String get dayLabel => '第${splitDay}天';

  /// 格式化钻石显示
  String get formattedDiamonds {
    if (diamonds >= 10000) {
      return '${(diamonds / 10000).toStringAsFixed(1)}万';
    }
    return diamonds.toString();
  }

  factory AuvSplit.fromJson(Map<String, dynamic> json) {
    return AuvSplit(
      splitDay: json['splitDay'] ?? 0,
      diamonds: json['diamonds'] ?? 0,
      bonus: json['bonus'] ?? 0,
      vipDays: json['vipDays'] ?? 0,
      callCardNum: json['callCardNum'] ?? 0,
      matchCardNum: json['matchCardNum'] ?? 0,
      chatCardNum: json['chatCardNum'] ?? 0,
    );
  }
}

/// 支付渠道
/// 
/// 表示商品支持的支付方式和相关信息
/// 
/// 对应接口: GET /p/product/getProducts, GET /p/product/getCountryProduct
/// 
/// 响应示例:
/// ```json
/// {
///   "ppId": 1,
///   "ppType": 1,
///   "ccType": null,
///   "ccName": "Google",
///   "nationalFlagPath": "https://...",
///   "uploadUsd": 0,
///   "supportCoupon": 0,
///   "discountFlag": 0,
///   "ppOrder": 1,
///   "browserOpen": 0,
///   "currencyPrice": 499,
///   "currencyCode": "USD"
/// }
/// ```
class AuvPaymentChannel {
  /// 支付渠道ID
  /// 类型: long
  /// 说明: 支付渠道的唯一标识符
  final int ppId;

  /// 支付类型
  /// 类型: int
  /// 说明: 支付渠道的类型标识
  /// 参考值: 1=Google, 19=CreditCard_pdd, 22=CreditCard_pdd2 等
  final int ppType;

  /// 支付渠道编码
  /// 类型: String?
  /// 说明: 支付渠道的编码标识，如"card"
  final String? ccType;

  /// 支付渠道名称
  /// 类型: String
  /// 说明: 支付渠道的显示名称，如"Google"、"Credit Card_pdd"
  final String ccName;

  /// 国旗/图标路径
  /// 类型: String
  /// 说明: 支付渠道的图标或国旗图片URL
  final String nationalFlagPath;

  /// 上报价格类型
  /// 类型: int
  /// 说明: 0.上报当地货币价格，1.上报美元价格
  /// 用于统计分析时的价格统一
  final int uploadUsd;

  /// 是否支持优惠券
  /// 类型: int
  /// 说明: 0.不支持，1.支持
  /// 支持优惠券的支付渠道可以使用优惠券抵扣
  final int supportCoupon;

  /// 优惠标签显示标识
  /// 类型: int
  /// 说明: 0.不显示优惠标签，1.显示优惠标签
  final int discountFlag;

  /// 支付渠道排序
  /// 类型: int
  /// 说明: 支付渠道在列表中的显示顺序，数字越小越靠前
  final int ppOrder;

  /// 是否浏览器打开
  /// 类型: int
  /// 说明: 0.否（App内支付），1.是（跳转浏览器支付）
  /// 部分支付渠道需要跳转到浏览器完成支付
  final int browserOpen;

  /// 当地货币价格
  /// 类型: int
  /// 说明: 该支付渠道的当地货币价格（单位：分）
  final int currencyPrice;

  /// 货币编码
  /// 类型: String
  /// 说明: 当地货币的ISO代码，如"USD"、"JPY"、"CNY"
  final String currencyCode;

  /// 钻石数量
  /// 类型: int?
  /// 说明: 该支付渠道对应的钻石数量（emma新版本才有）
  final int? diamonds;

  /// VIP天数
  /// 类型: int?
  /// 说明: 该支付渠道对应的VIP天数（emma新版本才有）
  final int? vipDays;

  /// 视频卡数量
  /// 类型: int?
  /// 说明: 该支付渠道对应的视频通话卡数量（emma新版本才有）
  final int? callCardNum;

  /// 匹配卡数量
  /// 类型: int?
  /// 说明: 该支付渠道对应的匹配功能卡数量（emma新版本才有）
  final int? matchCardNum;

  /// 聊天卡数量
  /// 类型: int?
  /// 说明: 该支付渠道对应的聊天功能卡数量（emma新版本才有）
  final int? chatCardNum;

  AuvPaymentChannel({
    required this.ppId,
    required this.ppType,
    this.ccType,
    required this.ccName,
    required this.nationalFlagPath,
    required this.uploadUsd,
    this.supportCoupon = 0,
    required this.discountFlag,
    required this.ppOrder,
    required this.browserOpen,
    required this.currencyPrice,
    required this.currencyCode,
    this.diamonds,
    this.vipDays,
    this.callCardNum,
    this.matchCardNum,
    this.chatCardNum,
  });

  /// 是否显示优惠标签
  bool get showDiscountFlag => discountFlag == 1;

  /// 是否浏览器打开
  bool get isBrowserOpen => browserOpen == 1;

  /// 是否支持优惠券
  bool get isSupportCoupon => supportCoupon == 1;

  /// 是否上报美元价格
  bool get isUploadUsd => uploadUsd == 1;

  /// 格式化价格显示
  String get formattedPrice {
    return '${(currencyPrice / 100).toStringAsFixed(2)} $currencyCode';
  }

  factory AuvPaymentChannel.fromJson(Map<String, dynamic> json) {
    return AuvPaymentChannel(
      ppId: json['ppId'] ?? 0,
      ppType: json['ppType'] ?? 0,
      ccType: json['ccType'],
      ccName: json['ccName'] ?? '',
      nationalFlagPath: json['nationalFlagPath'] ?? '',
      uploadUsd: json['uploadUsd'] ?? 0,
      supportCoupon: json['supportCoupon'] ?? 0,
      discountFlag: json['discountFlag'] ?? 0,
      ppOrder: json['ppOrder'] ?? 0,
      browserOpen: json['browserOpen'] ?? 0,
      currencyPrice: json['currencyPrice'] ?? 0,
      currencyCode: json['currencyCode'] ?? '',
      diamonds: json['diamonds'],
      vipDays: json['vipDays'],
      callCardNum: json['callCardNum'],
      matchCardNum: json['matchCardNum'],
      chatCardNum: json['chatCardNum'],
    );
  }
}

// ==================== 订单相关 ====================

/// 订单状态枚举
enum AuvOrderStatus {
  pending(0),   // 待支付
  paid(1),      // 已支付
  refunded(2),  // 已退款
  closed(3);    // 已关闭

  const AuvOrderStatus(this.value);
  final int value;

  static AuvOrderStatus fromValue(int value) {
    return AuvOrderStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvOrderStatus.pending,
    );
  }
}

/// 订单项
class AuvOrder {
  final int orderId;             // 订单id
  final String orderNo;          // 系统订单号
  final int productType;         // 商品类型，1.普通商品，2.折扣商品，3.vip商品
  final int ppType;             // 支付类型，1.GOOGLE，2.APPLE
  final String ccName;           // 支付渠道名称
  final int currencyFee;        // 付款币种总额，单位分
  final String currencyCode;     // 付款币种编码
  final int diamonds;            // 钻石数，小数点后两位
  final int? vipDays;          // VIP天数
  final int callCardNum;        // 视频卡数量
  final int matchCardNum;       // 匹配卡数量
  final int chatCardNum;        // 聊天卡数量
  final int orderStatus;         // 订单状态，0.待支付，1.已支付，2.已退款，3.已关闭
  final int createdAt;          // 创建时间（时间戳）

  AuvOrder({
    required this.orderId,
    required this.orderNo,
    required this.productType,
    required this.ppType,
    required this.ccName,
    required this.currencyFee,
    required this.currencyCode,
    required this.diamonds,
    this.vipDays,
    required this.callCardNum,
    required this.matchCardNum,
    required this.chatCardNum,
    required this.orderStatus,
    required this.createdAt,
  });

  factory AuvOrder.fromJson(Map<String, dynamic> json) {
    return AuvOrder(
      orderId: json['orderId'] ?? 0,
      orderNo: json['orderNo'] ?? '',
      productType: json['productType'] ?? 1,
      ppType: json['ppType'] ?? 0,
      ccName: json['ccName'] ?? '',
      currencyFee: json['currencyFee'] ?? 0,
      currencyCode: json['currencyCode'] ?? '',
      diamonds: json['diamonds'] ?? 0,
      vipDays: json['vipDays'],
      callCardNum: json['callCardNum'] ?? 0,
      matchCardNum: json['matchCardNum'] ?? 0,
      chatCardNum: json['chatCardNum'] ?? 0,
      orderStatus: json['orderStatus'] ?? 0,
      createdAt: json['createdAt'] ?? 0,
    );
  }

  /// 获取订单状态枚举
  AuvOrderStatus get status => AuvOrderStatus.fromValue(orderStatus);

  /// 获取创建时间
  DateTime? get createdDateTime {
    if (createdAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt);
  }

  /// 获取商品类别枚举
  AuvProductCategory get category => AuvProductCategory.fromValue(productType);

  /// 格式化价格显示（分转为元）
  String get formattedPrice {
    return '${(currencyFee / 100).toStringAsFixed(2)} $currencyCode';
  }
}

/// 订单查询条件
class AuvOrderCondition {
  /// 商品类型，1.普通商品，2.折扣商品，3.vip商品，不传为查询全部
  final int? productType;
  /// 订单状态，0.待支付，1.已支付，2.已退款，3.已关闭，不传为查询全部
  final int? orderStatus;

  AuvOrderCondition({
    this.productType,
    this.orderStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      if (productType != null) 'productType': productType,
      if (orderStatus != null) 'orderStatus': orderStatus,
    };
  }

  bool get isEmpty => productType == null && orderStatus == null;
}

/// 订单列表查询参数
class AuvOrderListParams {
  /// 第几页
  final int pageNum;
  /// 每页几条
  final int pageSize;
  /// 查询条件
  final AuvOrderCondition? condition;

  AuvOrderListParams({
    required this.pageNum,
    required this.pageSize,
    this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      if (condition != null && !condition!.isEmpty) 'condition': condition!.toJson(),
    };
  }
}

/// 订单分页响应
class AuvOrderListResponse {
  final List<AuvOrder> list;     // 订单列表
  final int pageNum;             // 当前第几页
  final int total;               // 总条数
  final int size;                // 当前页条数
  final int pages;               // 总页数
  final bool isFirstPage;        // 是否第一页
  final bool isLastPage;         // 是否最后一页
  final bool hasPreviousPage;    // 是否存在上一页
  final bool hasNextPage;       // 是否存在下一页

  AuvOrderListResponse({
    required this.list,
    required this.pageNum,
    required this.total,
    required this.size,
    required this.pages,
    required this.isFirstPage,
    required this.isLastPage,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory AuvOrderListResponse.fromJson(Map<String, dynamic> json) {
    return AuvOrderListResponse(
      list: json['list'] != null
          ? (json['list'] as List).map((e) => AuvOrder.fromJson(e)).toList()
          : [],
      pageNum: json['pageNum'] ?? 1,
      total: json['total'] ?? 0,
      size: json['size'] ?? 0,
      pages: json['pages'] ?? 0,
      isFirstPage: json['isFirstPage'] ?? true,
      isLastPage: json['isLastPage'] ?? true,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      hasNextPage: json['hasNextPage'] ?? false,
    );
  }

  bool get isEmpty => list.isEmpty;
  bool get isNotEmpty => list.isNotEmpty;
}

/// 订单状态简项（批量查询返回）
class AuvOrderStatusItem {
  final String orderNo;          // 系统订单号
  final int orderStatus;         // 订单状态，0.待支付，1.已支付，2.已退款，3.已关闭
  final String currencyCode;     // 付款币种编码
  final int currencyFee;        // 付款币种总额，单位分

  AuvOrderStatusItem({
    required this.orderNo,
    required this.orderStatus,
    required this.currencyCode,
    required this.currencyFee,
  });

  factory AuvOrderStatusItem.fromJson(Map<String, dynamic> json) {
    return AuvOrderStatusItem(
      orderNo: json['orderNo'] ?? '',
      orderStatus: json['orderStatus'] ?? 0,
      currencyCode: json['currencyCode'] ?? '',
      currencyFee: json['currencyFee'] ?? 0,
    );
  }

  /// 获取订单状态枚举
  AuvOrderStatus get status => AuvOrderStatus.fromValue(orderStatus);

  /// 格式化价格显示
  String get formattedPrice {
    return '${(currencyFee / 100).toStringAsFixed(2)} $currencyCode';
  }
}

/// 下单路径枚举
enum AuvCreatePath {
  rechargeCenter('rechargeCenter', '充值中心'),
  vipCenter('vipCenter', 'VIP中心'),
  homeRecharge('homeRecharge', '首页充值按钮'),
  chatMsgNoMoney('chatMsgNoMoney', '私聊发送消息充值'),
  createCallNoMoney('createCallNoMoney', '拨打电话没钱'),
  createAibCallNoMoney('createAibCallNoMoney', '拨打aib电话没钱'),
  callEndRecharge('callEndRecharge', '拨打结束页面充值'),
  callGiftRecharge('callGiftRecharge', '通话过程礼物充值'),
  aivGiftRecharge('aivGiftRecharge', 'AIV通话礼物充值'),
  aivOpenVoice('aivOpenVoice', 'AIV打开声音按钮'),
  callCountDownRecharge('callCountDownRecharge', '通话30s倒计时充值'),
  matchNoMoney('matchNoMoney', '匹配没钱'),
  matchDiamondButton('matchDiamondButton', '匹配界面充值按钮'),
  chatMsgGift('chatMsgGift', '私聊礼物充值'),
  callDiamondItemRecharge('callDiamondItemRecharge', '通话钻石按钮充值'),
  aivDiamondItemRecharge('aivDiamondItemRecharge', 'AIV通话钻石按钮充值');

  const AuvCreatePath(this.value, this.description);
  final String value;
  final String description;
}

/// 下单请求参数
class AuvCreateOrderParams {
  /// 支付渠道id
  final int ppId;
  /// 商品id
  final int productId;
  /// 引导充值的主播
  final int? anchorUserId;
  /// 优惠券记录id
  final int? couponRecordId;
  /// 充值转化的虚拟视频id
  final int? videoId;
  /// 下单路径
  final String? createPath;
  /// 游戏房间ID
  final int? gameRoomId;
  /// payermax支付token
  final String? paymentToken;
  /// payermax会话密钥
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

/// 下单响应
class AuvCreateOrderResponse {
  final int orderId;         // 订单id
  final String orderNo;      // 系统订单号
  final int currencyFee;    // 付款币种总额，单位分
  final String currencyCode; // 付款币种编码
  final String? ppUrl;      // 支付链接

  AuvCreateOrderResponse({
    required this.orderId,
    required this.orderNo,
    required this.currencyFee,
    required this.currencyCode,
    this.ppUrl,
  });

  factory AuvCreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return AuvCreateOrderResponse(
      orderId: json['orderId'] ?? 0,
      orderNo: json['orderNo'] ?? '',
      currencyFee: json['currencyFee'] ?? 0,
      currencyCode: json['currencyCode'] ?? '',
      ppUrl: json['ppUrl'],
    );
  }

  /// 格式化价格显示
  String get formattedPrice {
    return '${(currencyFee / 100).toStringAsFixed(2)} $currencyCode';
  }

  /// 是否有支付链接
  bool get hasPayUrl => ppUrl != null && ppUrl!.isNotEmpty;
}

/// 优惠券类型枚举
enum AuvCouponType {
  diamondDiscount(1, '钻石商品价格打折'),
  diamondBonusPercent(2, '钻石商品加赠钻石百分比'),
  diamondBonusFixed(3, '钻石商品加赠钻石固定值'),
  vipDiscount(4, 'VIP商品价格打折'),
  vipBonusPercent(5, 'VIP商品加赠天数百分比'),
  vipBonusFixed(6, 'VIP商品加赠天数固定值');

  const AuvCouponType(this.value, this.description);
  final int value;
  final String description;

  static AuvCouponType fromValue(int value) {
    return AuvCouponType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvCouponType.diamondDiscount,
    );
  }
}

/// 优惠券使用限制符号枚举
enum AuvCouponSymbol {
  none(0, '无限制'),
  lessThan(1, '小于'),
  equal(2, '等于'),
  greaterThan(3, '大于'),
  range(4, '范围');

  const AuvCouponSymbol(this.value, this.description);
  final int value;
  final String description;

  static AuvCouponSymbol fromValue(int value) {
    return AuvCouponSymbol.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvCouponSymbol.none,
    );
  }
}

/// 优惠券使用限制单位枚举
enum AuvCouponUnit {
  diamond(1, '钻石数'),
  vipDays(2, 'VIP天数');

  const AuvCouponUnit(this.value, this.description);
  final int value;
  final String description;

  static AuvCouponUnit fromValue(int value) {
    return AuvCouponUnit.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvCouponUnit.diamond,
    );
  }
}

/// 优惠券信息
class AuvCoupon {
  final int couponId;              // 优惠券id
  final int couponType;            // 优惠券类型
  final int couponValue;           // 优惠数值
  final int productSymbol;         // 使用限制符号
  final int productUnit;           // 使用限制单位
  final int productValue;          // 使用限制数值
  final int productMin;           // 使用限制范围最小值
  final int productMax;           // 使用限制范围最大值

  AuvCoupon({
    required this.couponId,
    required this.couponType,
    required this.couponValue,
    required this.productSymbol,
    required this.productUnit,
    required this.productValue,
    required this.productMin,
    required this.productMax,
  });

  factory AuvCoupon.fromJson(Map<String, dynamic> json) {
    return AuvCoupon(
      couponId: json['couponId'] ?? 0,
      couponType: json['couponType'] ?? 0,
      couponValue: json['couponValue'] ?? 0,
      productSymbol: json['productSymbol'] ?? 0,
      productUnit: json['productUnit'] ?? 0,
      productValue: json['productValue'] ?? 0,
      productMin: json['productMin'] ?? 0,
      productMax: json['productMax'] ?? 0,
    );
  }

  /// 获取优惠券类型枚举
  AuvCouponType get type => AuvCouponType.fromValue(couponType);

  /// 获取使用限制符号枚举
  AuvCouponSymbol get symbol => AuvCouponSymbol.fromValue(productSymbol);

  /// 获取使用限制单位枚举
  AuvCouponUnit get unit => AuvCouponUnit.fromValue(productUnit);

  /// 获取优惠券描述
  String get description {
    final typeDesc = type.description;
    final valueStr = _formatCouponValue();
    return '$valueStr $typeDesc';
  }

  /// 获取使用条件描述
  String get conditionDesc {
    if (symbol == AuvCouponSymbol.none) {
      return '无使用限制';
    }

    final unitDesc = unit == AuvCouponUnit.diamond ? '钻石' : '天VIP';

    if (symbol == AuvCouponSymbol.range) {
      final minStr = _formatProductValue(productMin);
      final maxStr = _formatProductValue(productMax);
      return '满$minStr-$maxStr $unitDesc可用';
    }

    final valueStr = _formatProductValue(productValue);
    final symbolStr = switch (symbol) {
      AuvCouponSymbol.lessThan => '小于',
      AuvCouponSymbol.equal => '等于',
      AuvCouponSymbol.greaterThan => '满',
      _ => '',
    };

    return '$symbolStr$valueStr $unitDesc可用';
  }

  /// 获取折扣显示（如 80%off）
  String get discountDisplay {
    if (type == AuvCouponType.diamondDiscount ||
        type == AuvCouponType.vipDiscount) {
      final percent = 100 - couponValue;
      return '${percent}%off';
    }
    return description;
  }

  /// 获取加赠显示（如 +70💎）
  String get bonusDisplay {
    if (type == AuvCouponType.diamondBonusFixed) {
      final diamonds = couponValue / 100;
      return '+${diamonds.toStringAsFixed(0)}💎';
    }
    if (type == AuvCouponType.vipBonusFixed) {
      return '+${couponValue}天VIP';
    }
    return description;
  }

  String _formatCouponValue() {
    return switch (type) {
      AuvCouponType.diamondDiscount ||
      AuvCouponType.vipDiscount =>
        '${100 - couponValue}%off',
      AuvCouponType.diamondBonusPercent ||
      AuvCouponType.vipBonusPercent =>
        '+${couponValue}%',
      AuvCouponType.diamondBonusFixed =>
        '+${(couponValue / 100).toStringAsFixed(0)}💎',
      AuvCouponType.vipBonusFixed =>
        '+${couponValue}天',
    };
  }

  String _formatProductValue(int value) {
    if (unit == AuvCouponUnit.diamond) {
      return (value / 100).toStringAsFixed(0);
    }
    return value.toString();
  }
}

/// 优惠券状态枚举
enum AuvUserCouponStatus {
  unused(0, '未使用'),
  used(1, '已使用');

  const AuvUserCouponStatus(this.value, this.description);
  final int value;
  final String description;

  static AuvUserCouponStatus fromValue(int value) {
    return AuvUserCouponStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvUserCouponStatus.unused,
    );
  }
}

/// 用户优惠券信息（已领取的优惠券）
class AuvUserCoupon {
  final int recordId;             // 记录ID
  final int couponId;            // 优惠券id
  final int couponType;          // 优惠券类型
  final int couponValue;         // 优惠数值
  final int productSymbol;       // 使用限制符号
  final int productUnit;         // 使用限制单位
  final int productValue;        // 使用限制数值
  final int productMin;          // 使用限制范围最小值
  final int productMax;          // 使用限制范围最大值
  final int couponStatus;        // 优惠券状态
  final int expireFlag;          // 是否过期
  final int endTime;             // 过期时间（时间戳）

  AuvUserCoupon({
    required this.recordId,
    required this.couponId,
    required this.couponType,
    required this.couponValue,
    required this.productSymbol,
    required this.productUnit,
    required this.productValue,
    required this.productMin,
    required this.productMax,
    required this.couponStatus,
    required this.expireFlag,
    required this.endTime,
  });

  factory AuvUserCoupon.fromJson(Map<String, dynamic> json) {
    return AuvUserCoupon(
      recordId: json['recordId'] ?? 0,
      couponId: json['couponId'] ?? 0,
      couponType: json['couponType'] ?? 0,
      couponValue: json['couponValue'] ?? 0,
      productSymbol: json['productSymbol'] ?? 0,
      productUnit: json['productUnit'] ?? 0,
      productValue: json['productValue'] ?? 0,
      productMin: json['productMin'] ?? 0,
      productMax: json['productMax'] ?? 0,
      couponStatus: json['couponStatus'] ?? 0,
      expireFlag: json['expireFlag'] ?? 0,
      endTime: json['endTime'] ?? 0,
    );
  }

  /// 获取优惠券类型枚举
  AuvCouponType get type => AuvCouponType.fromValue(couponType);

  /// 获取使用限制符号枚举
  AuvCouponSymbol get symbol => AuvCouponSymbol.fromValue(productSymbol);

  /// 获取使用限制单位枚举
  AuvCouponUnit get unit => AuvCouponUnit.fromValue(productUnit);

  /// 获取优惠券状态枚举
  AuvUserCouponStatus get status => AuvUserCouponStatus.fromValue(couponStatus);

  /// 是否已使用
  bool get isUsed => couponStatus == AuvUserCouponStatus.used.value;

  /// 是否已过期
  bool get isExpired => expireFlag == 1 || (endTime > 0 && endTime < DateTime.now().millisecondsSinceEpoch);

  /// 是否可用（未使用且未过期）
  bool get isAvailable => !isUsed && !isExpired;

  /// 获取优惠券描述
  String get description => type.description;

  /// 获取折扣显示（如 80%off）
  String get discountDisplay {
    if (type == AuvCouponType.diamondDiscount ||
        type == AuvCouponType.vipDiscount) {
      final percent = 100 - couponValue;
      return '${percent}%off';
    }
    return description;
  }

  /// 获取加赠显示（如 +70💎）
  String get bonusDisplay {
    if (type == AuvCouponType.diamondBonusFixed) {
      final diamonds = couponValue / 100;
      return '+${diamonds.toStringAsFixed(0)}💎';
    }
    if (type == AuvCouponType.vipBonusFixed) {
      return '+${couponValue}天VIP';
    }
    return description;
  }

  /// 获取使用条件描述
  String get conditionDesc {
    if (symbol == AuvCouponSymbol.none) {
      return '无使用限制';
    }

    final unitDesc = unit == AuvCouponUnit.diamond ? '钻石' : '天VIP';

    if (symbol == AuvCouponSymbol.range) {
      final minStr = _formatProductValue(productMin);
      final maxStr = _formatProductValue(productMax);
      return '满$minStr-$maxStr $unitDesc可用';
    }

    final valueStr = _formatProductValue(productValue);
    final symbolStr = switch (symbol) {
      AuvCouponSymbol.lessThan => '小于',
      AuvCouponSymbol.equal => '等于',
      AuvCouponSymbol.greaterThan => '满',
      _ => '',
    };

    return '$symbolStr$valueStr $unitDesc可用';
  }

  /// 获取过期时间描述
  String get expireTimeDesc {
    if (endTime <= 0) return '永久有效';
    final expireDate = DateTime.fromMillisecondsSinceEpoch(endTime);
    return '${expireDate.month}/${expireDate.day} 到期';
  }

  String _formatProductValue(int value) {
    if (unit == AuvCouponUnit.diamond) {
      return (value / 100).toStringAsFixed(0);
    }
    return value.toString();
  }
}
