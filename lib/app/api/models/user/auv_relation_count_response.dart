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

/// 关系请求数值响应模型
class AuvRelationCountResponse {
  final int? userId;
  final int? followCount;
  final int? followedCount;
  final int? likeCount;
  final int? likeMeCount;
  final int? increaseLikeMeCount;
  final int? seeMeCount;
  final int? latestSeeCount;
  final int? increaseSeeCount;
  final List<AuvLikeMeUserInfo>? likeMeSimpleInfoList;
  final List<String>? seeMePortraits;

  AuvRelationCountResponse({
    this.userId,
    this.followCount,
    this.followedCount,
    this.likeCount,
    this.likeMeCount,
    this.increaseLikeMeCount,
    this.seeMeCount,
    this.latestSeeCount,
    this.increaseSeeCount,
    this.likeMeSimpleInfoList,
    this.seeMePortraits,
  });

  factory AuvRelationCountResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvRelationCountResponse();
    return AuvRelationCountResponse(
      userId: json['userId'],
      followCount: json['followCount'],
      followedCount: json['followedCount'],
      likeCount: json['likeCount'],
      likeMeCount: json['likeMeCount'],
      increaseLikeMeCount: json['increaseLikeMeCount'],
      seeMeCount: json['seeMeCount'],
      latestSeeCount: json['latestSeeCount'],
      increaseSeeCount: json['increaseSeeCount'],
      likeMeSimpleInfoList: (json['likeMeSimpleInfoList'] as List<dynamic>?)
          ?.map((e) => AuvLikeMeUserInfo.fromJson(e))
          .toList(),
      seeMePortraits: (json['seeMePortraits'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }
}
