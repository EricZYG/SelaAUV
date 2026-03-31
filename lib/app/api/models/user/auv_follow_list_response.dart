/// 关注列表等级配置响应模型
class AuvFollowLevelConfigResponse {
  final int? level;
  final int? begin;
  final int? end;
  final String? icon;
  final int? userId;

  AuvFollowLevelConfigResponse({
    this.level,
    this.begin,
    this.end,
    this.icon,
    this.userId,
  });

  factory AuvFollowLevelConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvFollowLevelConfigResponse();
    return AuvFollowLevelConfigResponse(
      level: json['level'],
      begin: json['begin'],
      end: json['end'],
      icon: json['icon'],
      userId: json['userID'],
    );
  }
}

/// 关注列表项响应模型
class AuvFollowListItemResponse {
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
  final String? signature;
  final int? followFlag;
  final int? rid;
  final String? roomBgImg;
  final bool? vipFlag;
  final AuvFollowLevelConfigResponse? levelConfig;

  AuvFollowListItemResponse({
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
    this.signature,
    this.followFlag,
    this.rid,
    this.roomBgImg,
    this.vipFlag,
    this.levelConfig,
  });

  factory AuvFollowListItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvFollowListItemResponse();
    return AuvFollowListItemResponse(
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
      signature: json['signature'],
      followFlag: json['followFlag'],
      rid: json['rid'],
      roomBgImg: json['roomBgImg'],
      vipFlag: json['vipFlag'],
      levelConfig: json['levelConfig'] != null
          ? AuvFollowLevelConfigResponse.fromJson(json['levelConfig'])
          : null,
    );
  }

  bool get isUserOnline => isOnline == 1;
  bool get isVip => vipFlag == true;
  bool get isFriend => followFlag == 3;
  bool get hasFollowed => followFlag == 2 || followFlag == 3;
}

/// 关注列表请求模型
class AuvFollowListRequest {
  final int type;

  AuvFollowListRequest({required this.type});

  Map<String, dynamic> toJson() => {'type': type};
}

/// 关注列表分页数据响应模型
class AuvFollowListDataResponse {
  final List<AuvFollowListItemResponse>? list;
  final int? total;
  final int? pageSize;
  final int? pageNum;
  final int? pages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;
  final bool? isFirstPage;
  final bool? isLastPage;

  AuvFollowListDataResponse({
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

  factory AuvFollowListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvFollowListDataResponse();
    return AuvFollowListDataResponse(
      list: (json['list'] as List<dynamic>?)?.map((e) => AuvFollowListItemResponse.fromJson(e)).toList(),
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

/// 关注列表类型枚举
enum AuvFollowListType {
  friend(1),
  friendRequest(2),
  following(3);

  final int value;
  const AuvFollowListType(this.value);

  static AuvFollowListType fromValue(int value) {
    return AuvFollowListType.values.firstWhere((e) => e.value == value, orElse: () => AuvFollowListType.friend);
  }
}
