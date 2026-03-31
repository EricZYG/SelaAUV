/// 黑名单列表项响应模型
/// 
/// 表示黑名单中的单个用户信息
class AuvBlackListItemResponse {
  /// 用户id
  final int? userId;

  /// 用户昵称
  final String? nickname;

  /// 头像相对地址
  final String? portrait;

  /// 身份
  final int? userAuth;

  /// 性别
  /// 
  /// 1.男，2.女
  final int? sex;

  /// 生日时间戳
  final int? birthday;

  /// 国家编码
  final int? countryCode;

  /// 国旗链接
  final String? countryPath;

  /// 国家名
  final String? countryTitle;

  /// 创建时间（拉黑时间）
  final int? createdAt;

  AuvBlackListItemResponse({
    this.userId,
    this.nickname,
    this.portrait,
    this.userAuth,
    this.sex,
    this.birthday,
    this.countryCode,
    this.countryPath,
    this.countryTitle,
    this.createdAt,
  });

  factory AuvBlackListItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvBlackListItemResponse();
    return AuvBlackListItemResponse(
      userId: json['userId'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      userAuth: json['userAuth'],
      sex: json['sex'],
      birthday: json['birthday'],
      countryCode: json['countryCode'],
      countryPath: json['countryPath'],
      countryTitle: json['countryTitle'],
      createdAt: json['createdAt'],
    );
  }

  /// 获取拉黑时间
  DateTime? get blacklistedAt {
    if (createdAt == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt!);
  }
}

/// 黑名单分页数据响应模型
/// 
/// 包含分页信息和黑名单用户列表
class AuvBlackListDataResponse {
  /// 用户列表
  final List<AuvBlackListItemResponse>? list;

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

  /// 是否第一页
  final bool? isFirstPage;

  /// 是否最后一页
  final bool? isLastPage;

  AuvBlackListDataResponse({
    this.list,
    this.total,
    this.pageSize,
    this.pageNum,
    this.pages,
    this.hasNextPage,
    this.hasPreviousPage,
    this.isFirstPage,
    this.isLastPage,
  });

  factory AuvBlackListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvBlackListDataResponse();
    return AuvBlackListDataResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvBlackListItemResponse.fromJson(e))
          .toList(),
      total: json['total'],
      pageSize: json['pageSize'],
      pageNum: json['pageNum'],
      pages: json['pages'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
      isFirstPage: json['isFirstPage'],
      isLastPage: json['isLastPage'],
    );
  }
}
