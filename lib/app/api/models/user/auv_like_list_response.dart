/// 喜欢列表请求模型
class AuvLikeListRequest {
  final int type;

  AuvLikeListRequest({required this.type});

  Map<String, dynamic> toJson() => {'type': type};
}

/// 喜欢列表项响应模型
class AuvLikeListItemResponse {
  final int? userId;
  final String? nickname;
  final String? portrait;
  final int? isOnline;
  final int? userAuth;
  final int? sex;
  final int? birthday;
  final int? countryCode;
  final String? countryPath;
  final String? countryTitle;
  final int? disturbFlag;
  final int? createdAt;
  final int? stat;

  AuvLikeListItemResponse({
    this.userId,
    this.nickname,
    this.portrait,
    this.isOnline,
    this.userAuth,
    this.sex,
    this.birthday,
    this.countryCode,
    this.countryPath,
    this.countryTitle,
    this.disturbFlag,
    this.createdAt,
    this.stat,
  });

  factory AuvLikeListItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvLikeListItemResponse();
    return AuvLikeListItemResponse(
      userId: json['userId'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      isOnline: json['isOnline'],
      userAuth: json['userAuth'],
      sex: json['sex'],
      birthday: json['birthday'],
      countryCode: json['countryCode'],
      countryPath: json['countryPath'],
      countryTitle: json['countryTitle'],
      disturbFlag: json['disturbFlag'],
      createdAt: json['createdAt'],
      stat: json['stat'],
    );
  }

  bool get isUserOnline => isOnline == 1;
  bool get isDisturb => disturbFlag == 1;
  bool get hasLikedBack => stat == 2;
  bool get isPending => stat == 0;
  bool get isIgnored => stat == 1;
}

/// 喜欢列表分页数据响应模型
class AuvLikeListDataResponse {
  final List<AuvLikeListItemResponse>? list;
  final int? total;
  final int? pageSize;
  final int? pageNum;
  final int? pages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;
  final bool? isFirstPage;
  final bool? isLastPage;

  AuvLikeListDataResponse({
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

  factory AuvLikeListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvLikeListDataResponse();
    return AuvLikeListDataResponse(
      list: (json['list'] as List<dynamic>?)?.map((e) => AuvLikeListItemResponse.fromJson(e)).toList(),
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

/// 更新喜欢状态请求模型
class AuvUpdateLikeStatRequest {
  final List<int> likeMeUserIds;
  final int stat;

  AuvUpdateLikeStatRequest({required this.likeMeUserIds, required this.stat});

  Map<String, dynamic> toJson() => {'likeMeUserIds': likeMeUserIds, 'stat': stat};
}

/// 喜欢列表类型枚举
enum AuvLikeListType {
  like(1),
  likedMe(2);

  final int value;
  const AuvLikeListType(this.value);

  static AuvLikeListType fromValue(int value) {
    return AuvLikeListType.values.firstWhere((e) => e.value == value, orElse: () => AuvLikeListType.likedMe);
  }
}
