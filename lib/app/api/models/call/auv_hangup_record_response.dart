/// 挂机记录项响应模型
/// 
/// 表示单条挂机记录信息
class AuvHangupRecordItemResponse {
  /// 记录id
  final int? recordId;

  /// 挂机主播
  final int? anchorUserId;

  /// 挂机类型
  /// 
  /// 1.正常模式，2.匹配模式，3.连续超时挂断
  final int? hangupType;

  /// 创建时间
  final int? createdAt;

  AuvHangupRecordItemResponse({
    this.recordId,
    this.anchorUserId,
    this.hangupType,
    this.createdAt,
  });

  factory AuvHangupRecordItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvHangupRecordItemResponse();
    return AuvHangupRecordItemResponse(
      recordId: json['recordId'],
      anchorUserId: json['anchorUserId'],
      hangupType: json['hangupType'],
      createdAt: json['createdAt'],
    );
  }
}

/// 挂机记录列表数据响应模型
/// 
/// 包含分页信息和挂机记录列表
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