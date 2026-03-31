/// 幸运礼物项模型
///
/// 获取幸运礼物列表接口返回的数据
///
/// 字段说明:
/// - luckyId: 主键id
/// - probability: 礼物概率，10表示10%的概率
/// - gid: 礼物ID
/// - name: 礼物名称
/// - diamonds: 钻石价格
/// - coins: 金币价格
/// - giftType: 礼物类型(1.普通礼物, 2.VIP礼物)
/// - icon: 图标URL
/// - animEffectUrl: 特效URL
/// - md5: 资源MD5
class AuvLuckyGiftItemResponse {
  /// 主键id
  final int? luckyId;

  /// 礼物概率，10表示10%的概率
  final double? probability;

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

  /// 资源MD5
  final String? md5;

  AuvLuckyGiftItemResponse({
    this.luckyId,
    this.probability,
    this.gid,
    this.name,
    this.diamonds,
    this.coins,
    this.giftType,
    this.icon,
    this.animEffectUrl,
    this.md5,
  });

  factory AuvLuckyGiftItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvLuckyGiftItemResponse();
    return AuvLuckyGiftItemResponse(
      luckyId: json['luckyId'],
      probability: (json['probability'] as num?)?.toDouble(),
      gid: json['gid'],
      name: json['name'],
      diamonds: json['diamonds'],
      coins: json['coins'],
      giftType: json['giftType'] ?? json['gift_type'],
      icon: json['icon'],
      animEffectUrl: json['animEffectUrl'] ?? json['anim_effect_url'],
      md5: json['md5'],
    );
  }

  /// 是否是普通礼物
  bool get isNormalGift => giftType == 1;

  /// 是否是VIP礼物
  bool get isVipGift => giftType == 2;

  /// 获取概率百分比
  double? get probabilityPercent => probability != null ? probability! * 100 : null;
}
