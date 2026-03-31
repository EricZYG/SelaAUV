/// 分页响应模型
/// 
/// 用于分页数据的响应
class AuvPageResponse<T> {
  /// 数据列表
  final List<T>? list;

  /// 总记录数
  final int? total;

  /// 每页条数
  final int? pageSize;

  /// 当前页码
  final int? pageNum;

  /// 总页数
  final int? pages;

  /// 是否有下一页
  final bool? hasNextPage;

  /// 是否有上一页
  final bool? hasPreviousPage;

  AuvPageResponse({
    this.list,
    this.total,
    this.pageSize,
    this.pageNum,
    this.pages,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  factory AuvPageResponse.fromJson(
    Map<String, dynamic>? json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    if (json == null) return AuvPageResponse();
    return AuvPageResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      total: json['total'],
      pageSize: json['pageSize'],
      pageNum: json['pageNum'],
      pages: json['pages'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
    );
  }
}
