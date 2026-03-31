import 'auv_user_gift_item_response.dart';

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
