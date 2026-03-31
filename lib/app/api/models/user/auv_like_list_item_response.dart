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
