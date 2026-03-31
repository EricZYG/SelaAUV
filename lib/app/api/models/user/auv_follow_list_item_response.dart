import 'auv_follow_list_response.dart';

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
