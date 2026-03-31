/// 聊天记录查询请求参数
///
/// 用于分页查询聊天记录
class AuvMsgRecordRequest {
  /// 对方用户id，选填
  final int? otherUserId;

  /// 偏移id，初始不传，后续传上次记录列表中的最后一个元素的id
  final String? offsetId;

  /// 每页条数
  final int? pageSize;

  AuvMsgRecordRequest({
    this.otherUserId,
    this.offsetId,
    this.pageSize,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (otherUserId != null) params['otherUserId'] = otherUserId;
    if (offsetId != null) params['offsetId'] = offsetId;
    if (pageSize != null) params['pageSize'] = pageSize;
    return params;
  }
}
