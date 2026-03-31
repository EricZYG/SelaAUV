import 'auv_moment_media_item.dart';

/// 动态项
class AuvMomentItemResponse {
  /// 动态ID
  final int momentId;

  /// 用户ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String? portrait;

  /// 生日
  final int? birthday;

  /// 性别（1男，2女）
  final int? sex;

  /// 国家代码
  final String? countryCode;

  /// 国家标题
  final String? countryTitle;

  /// 内容
  final String? content;

  /// 点赞数量
  final int praiseCount;

  /// 评论数量
  final int commentCount;

  /// 点击量
  final int clickCount;

  /// 是否点赞（0否，1是）
  final int praiseFlag;

  /// 话题ID列表
  final List<String>? topicIdList;

  /// 话题ID字符串
  final String? topicIds;

  /// 创建时间
  final int createdAt;

  /// 媒体列表
  final List<AuvMomentMediaItem>? medias;

  AuvMomentItemResponse({
    required this.momentId,
    required this.userId,
    required this.nickname,
    this.portrait,
    this.birthday,
    this.sex,
    this.countryCode,
    this.countryTitle,
    this.content,
    required this.praiseCount,
    required this.commentCount,
    required this.clickCount,
    required this.praiseFlag,
    this.topicIdList,
    this.topicIds,
    required this.createdAt,
    this.medias,
  });

  factory AuvMomentItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvMomentItemResponse(
        momentId: 0,
        userId: 0,
        nickname: '',
        praiseCount: 0,
        commentCount: 0,
        clickCount: 0,
        praiseFlag: 0,
        createdAt: 0,
      );
    }
    return AuvMomentItemResponse(
      momentId: json['momentId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String?,
      birthday: json['birthday'] as int?,
      sex: json['sex'] as int?,
      countryCode: json['countryCode'] as String?,
      countryTitle: json['countryTitle'] as String?,
      content: json['content'] as String?,
      praiseCount: json['praiseCount'] as int? ?? 0,
      commentCount: json['commentCount'] as int? ?? 0,
      clickCount: json['clickCount'] as int? ?? 0,
      praiseFlag: json['praiseFlag'] as int? ?? 0,
      topicIdList: (json['topicIdList'] as List<dynamic>?)?.cast<String>(),
      topicIds: json['topicIds'] as String?,
      createdAt: json['createdAt'] as int? ?? 0,
      medias: (json['medias'] as List<dynamic>?)
          ?.map((e) => AuvMomentMediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
