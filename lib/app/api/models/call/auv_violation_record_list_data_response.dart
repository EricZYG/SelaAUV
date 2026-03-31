import 'auv_violation_record_item_response.dart';

/// 违规处罚记录列表数据响应模型
class AuvViolationRecordListDataResponse {
  /// 违规记录列表
  final List<AuvViolationRecordItemResponse>? list;

  /// 当前页码
  final int? pageNum;

  /// 每页条数
  final int? pageSize;

  /// 总记录数
  final String? total;

  /// 是否有下一页
  final bool? hasNextPage;

  AuvViolationRecordListDataResponse({
    this.list,
    this.pageNum,
    this.pageSize,
    this.total,
    this.hasNextPage,
  });

  factory AuvViolationRecordListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvViolationRecordListDataResponse();
    return AuvViolationRecordListDataResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvViolationRecordItemResponse.fromJson(e))
          .toList(),
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      total: json['total']?.toString(),
      hasNextPage: json['hasNextPage'],
    );
  }
}
