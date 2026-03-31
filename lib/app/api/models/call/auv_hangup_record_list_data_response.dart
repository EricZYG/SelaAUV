import 'auv_hangup_record_item_response.dart';

/// 挂机记录列表数据响应模型
class AuvHangupRecordListDataResponse {
  /// 挂机记录列表
  final List<AuvHangupRecordItemResponse>? list;

  /// 当前页码
  final int? pageNum;

  /// 每页条数
  final int? pageSize;

  /// 总记录数
  final String? total;

  /// 是否有下一页
  final bool? hasNextPage;

  AuvHangupRecordListDataResponse({
    this.list,
    this.pageNum,
    this.pageSize,
    this.total,
    this.hasNextPage,
  });

  factory AuvHangupRecordListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvHangupRecordListDataResponse();
    return AuvHangupRecordListDataResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvHangupRecordItemResponse.fromJson(e))
          .toList(),
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      total: json['total']?.toString(),
      hasNextPage: json['hasNextPage'],
    );
  }
}
