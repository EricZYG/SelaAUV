/// 广告项模型
///
/// 表示广告信息
///
/// 字段说明:
/// - id: 广告id
/// - appChannel: 应用渠道
/// - countryCode: 国家编码
/// - jumpUrl: 跳转链接
/// - img: 广告图片
/// - sort: 排序
/// - createdAt: 创建时间
class AuvAdvertisementResponse {
  /// 广告id
  final int? id;

  /// 应用渠道
  final String? appChannel;

  /// 国家编码
  final int? countryCode;

  /// 跳转链接
  final String? jumpUrl;

  /// 广告图片
  final String? img;

  /// 排序
  final int? sort;

  /// 创建时间
  final int? createdAt;

  AuvAdvertisementResponse({
    this.id,
    this.appChannel,
    this.countryCode,
    this.jumpUrl,
    this.img,
    this.sort,
    this.createdAt,
  });

  factory AuvAdvertisementResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAdvertisementResponse();
    return AuvAdvertisementResponse(
      id: json['id'],
      appChannel: json['appChannel'],
      countryCode: json['countryCode'],
      jumpUrl: json['jumpUrl'],
      img: json['img'],
      sort: json['sort'],
      createdAt: json['createdAt'],
    );
  }
}

/// 广告列表数据模型
///
/// 表示广告列表响应数据
///
/// 字段说明:
/// - list: 广告列表
class AuvAdvertisementListResponse {
  /// 广告列表
  final List<AuvAdvertisementResponse>? list;

  AuvAdvertisementListResponse({
    this.list,
  });

  factory AuvAdvertisementListResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAdvertisementListResponse();
    return AuvAdvertisementListResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvAdvertisementResponse.fromJson(e))
          .toList(),
    );
  }
}