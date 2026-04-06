export 'auv_user_gift_list_data_response.dart';

/// 普通礼物项模型
///
/// 获取普通礼物列表接口返回的礼物数据
///
/// 实际API返回示例:
/// ```json
/// {
///   "gid": 1000,
///   "name": "kiss",
///   "diamonds": 10000,
///   "coins": 1000,
///   "giftType": 1,
///   "isTaskGift": 1,
///   "heartbeatLevel": 0,
///   "icon": "https://example.com/icon.png",
///   "animEffectUrl": null,
///   "md5": null
/// }
/// ```
///
/// 字段说明:
/// - gid: 礼物ID
/// - name: 礼物名称
/// - diamonds: 钻石价格
/// - coins: 金币价格
/// - giftType: 礼物类型(1.普通礼物, 2.VIP礼物)
/// - isTaskGift: 是否任务礼物，1是 0否
/// - heartbeatLevel: 心动等级要求，0表示无要求
/// - icon: 图标URL
/// - animEffectUrl: 特效URL
/// - md5: 资源MD5
class AuvUserGiftItemResponse {
  /// 礼物ID
  final int? gid;

  /// 礼物名称
  final String? name;

  /// 钻石价格(小数点后两位)
  final int? diamonds;

  /// 金币价格(小数点后两位)
  final int? coins;

  /// 礼物类型: 1.普通礼物, 2.VIP礼物
  final int? giftType;

  /// 图标URL
  final String? icon;

  /// 特效URL
  final String? animEffectUrl;

  ///note 这个字段作用是什么？ 资源MD5
  final String? md5;

  /// 【遗漏】是否任务礼物，1是 0否
  final int? isTaskGift;

  /// 【遗漏】心动等级要求，0表示无要求
  final int? heartbeatLevel;

  AuvUserGiftItemResponse({
    this.gid,
    this.name,
    this.diamonds,
    this.coins,
    this.giftType,
    this.icon,
    this.animEffectUrl,
    this.md5,
    this.isTaskGift,
    this.heartbeatLevel,
  });

  factory AuvUserGiftItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvUserGiftItemResponse();
    return AuvUserGiftItemResponse(
      gid: json['gid'],
      name: json['name'],
      diamonds: json['diamonds'],
      coins: json['coins'],
      giftType: json['giftType'] ?? json['gift_type'],
      icon: json['icon'],
      animEffectUrl: json['animEffectUrl'] ?? json['anim_effect_url'],
      md5: json['md5'],
      isTaskGift: json['isTaskGift'],
      heartbeatLevel: json['heartbeatLevel'],
    );
  }

  /// 是否是普通礼物
  bool get isNormalGift => giftType == 1;

  /// 是否是VIP礼物
  bool get isVipGift => giftType == 2;

  /// 是否任务礼物
  bool get isTask => isTaskGift == 1;

  /// 是否有心动等级要求
  bool get hasHeartbeatLevelRequirement => (heartbeatLevel ?? 0) > 0;
}
