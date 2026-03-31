import 'auv_advertisement_response.dart';

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
