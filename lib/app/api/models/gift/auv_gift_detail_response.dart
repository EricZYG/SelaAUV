/// 礼物详情模型
///
/// 获取单个礼物详情接口返回的礼物详细信息
///
/// 字段说明:
/// - id: 数据库主键ID
/// - gid: 礼物ID
/// - name: 礼物名称
/// - diamonds: 钻石价格
/// - coins: 金币价格
/// - countryCode: 国家代码
/// - icon: 图标URL
/// - animEffectUrl: 特效URL
/// - md5: 资源MD5
/// - online: 在线状态
/// - rankBy: 排序权重
/// - createdAt: 创建时间
/// - updatedAt: 更新时间
class AuvGiftDetailResponse {
  /// 数据库主键ID
  final int? id;

  /// 礼物ID
  final int? gid;

  /// 礼物名称
  final String? name;

  /// 钻石价格(小数点后两位)
  final int? diamonds;

  /// 金币价格(小数点后两位)
  final int? coins;

  /// 国家代码
  final int? countryCode;

  /// 图标URL
  final String? icon;

  /// 特效URL
  final String? animEffectUrl;

  /// 资源MD5
  final String? md5;

  /// 在线状态: 1.在线
  final int? online;

  /// 排序权重
  final int? rankBy;

  /// 创建时间戳
  final int? createdAt;

  /// 更新时间戳
  final int? updatedAt;

  AuvGiftDetailResponse({
    this.id,
    this.gid,
    this.name,
    this.diamonds,
    this.coins,
    this.countryCode,
    this.icon,
    this.animEffectUrl,
    this.md5,
    this.online,
    this.rankBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AuvGiftDetailResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvGiftDetailResponse();
    return AuvGiftDetailResponse(
      id: json['id'],
      gid: json['gid'],
      name: json['name'],
      diamonds: json['diamonds'],
      coins: json['coins'],
      countryCode: json['countryCode'] ?? json['country_code'],
      icon: json['icon'],
      animEffectUrl: json['animEffectUrl'] ?? json['anim_effect_url'],
      md5: json['md5'],
      online: json['online'],
      rankBy: json['rankBy'] ?? json['rank_by'],
      createdAt: json['createdAt'] ?? json['created_at'],
      updatedAt: json['updatedAt'] ?? json['updated_at'],
    );
  }

  /// 是否在线
  bool get isOnline => online == 1;

  /// 是否有钻石价格
  bool get hasDiamondPrice => (diamonds ?? 0) > 0;

  /// 是否有金币价格
  bool get hasCoinPrice => (coins ?? 0) > 0;
}