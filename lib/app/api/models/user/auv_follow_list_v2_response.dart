import 'auv_follow_list_response.dart';

/// 关注列表V2请求模型
class AuvFollowListV2Request {
  final int type;

  AuvFollowListV2Request({required this.type});

  Map<String, dynamic> toJson() => {'type': type};
}

/// 关注列表V2项响应模型
class AuvFollowListV2ItemResponse {
  final int? userId;
  final int? followUserId;
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
  final int? inLiveRoom;
  final int? roomId;
  final AuvFollowLevelConfigResponse? levelConfig;

  AuvFollowListV2ItemResponse({
    this.userId,
    this.followUserId,
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
    this.inLiveRoom,
    this.roomId,
    this.levelConfig,
  });

  factory AuvFollowListV2ItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvFollowListV2ItemResponse();
    return AuvFollowListV2ItemResponse(
      userId: json['userId'],
      followUserId: json['followUserId'],
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
      inLiveRoom: json['inLiveRoom'],
      roomId: json['roomId'],
      levelConfig: json['levelConfig'] != null
          ? AuvFollowLevelConfigResponse.fromJson(json['levelConfig'])
          : null,
    );
  }

  bool get isUserOnline => isOnline == 1;
  bool get isVip => vipFlag == true;
  bool get isFriend => followFlag == 3;
  bool get hasFollowed => followFlag == 2 || followFlag == 3;
  bool get isInLiveRoom => inLiveRoom == 1;
}

/// 关注列表V2分页数据响应模型
class AuvFollowListV2DataResponse {
  final List<AuvFollowListV2ItemResponse>? list;
  final int? total;
  final int? pageSize;
  final int? pageNum;
  final int? pages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;
  final bool? isFirstPage;
  final bool? isLastPage;

  AuvFollowListV2DataResponse({
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

  factory AuvFollowListV2DataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvFollowListV2DataResponse();
    return AuvFollowListV2DataResponse(
      list: (json['list'] as List<dynamic>?)?.map((e) => AuvFollowListV2ItemResponse.fromJson(e)).toList(),
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
