/// 喜欢我的用户简要信息
class AuvLikeMeUserInfo {
  /// 头像
  final String? portrait;

  /// 昵称
  final String? nickname;

  AuvLikeMeUserInfo({
    this.portrait,
    this.nickname,
  });

  factory AuvLikeMeUserInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvLikeMeUserInfo();
    return AuvLikeMeUserInfo(
      portrait: json['portrait'],
      nickname: json['nickname'],
    );
  }
}
