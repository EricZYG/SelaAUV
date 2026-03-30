/// 普通礼物项模型
///
/// 获取普通礼物列表接口返回的礼物数据
///
/// 字段说明:
/// - gid: 礼物ID
/// - name: 礼物名称
/// - diamonds: 钻石价格
/// - coins: 金币价格
/// - giftType: 礼物类型(1.普通礼物, 2.VIP礼物)
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

  /// 资源MD5
  final String? md5;

  AuvUserGiftItemResponse({
    this.gid,
    this.name,
    this.diamonds,
    this.coins,
    this.giftType,
    this.icon,
    this.animEffectUrl,
    this.md5,
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
    );
  }

  /// 是否是普通礼物
  bool get isNormalGift => giftType == 1;

  /// 是否是VIP礼物
  bool get isVipGift => giftType == 2;
}

/// 普通礼物列表响应数据模型(分页)
class AuvUserGiftListDataResponse {
  /// 总记录数
  final int? total;

  /// 礼物列表
  final List<AuvUserGiftItemResponse>? list;

  /// 当前页码
  final int? pageNum;

  /// 每页数量
  final int? pageSize;

  /// 总页数
  final int? pages;

  AuvUserGiftListDataResponse({
    this.total,
    this.list,
    this.pageNum,
    this.pageSize,
    this.pages,
  });

  factory AuvUserGiftListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvUserGiftListDataResponse();
    return AuvUserGiftListDataResponse(
      total: json['total'],
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvUserGiftItemResponse.fromJson(e))
          .toList(),
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      pages: json['pages'],
    );
  }
}