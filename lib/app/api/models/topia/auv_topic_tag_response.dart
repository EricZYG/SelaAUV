export 'auv_topic_media_item.dart';
export 'auv_topic_moment_item.dart';
export 'auv_topic_item_response.dart';
export 'auv_topic_condition.dart';
export 'auv_moment_media_item.dart';
export 'auv_moment_item_response.dart';
export 'auv_moment_condition.dart';
export 'auv_comment_reply_item.dart';
export 'auv_comment_item_response.dart';
export 'auv_comment_condition.dart';
export 'auv_publish_media_item.dart';

/// 标签列表项
class AuvTopicTagItemResponse {
  /// 标签ID
  final int id;

  /// 标签名称
  final String tag;

  /// 排序
  final int sort;

  /// 是否关注（0 没关注，1 关注）
  final int isFollow;

  /// 用户设置的排序
  final int? userSort;

  AuvTopicTagItemResponse({
    required this.id,
    required this.tag,
    required this.sort,
    required this.isFollow,
    this.userSort,
  });

  factory AuvTopicTagItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopicTagItemResponse(
        id: 0,
        tag: '',
        sort: 0,
        isFollow: 0,
        userSort: null,
      );
    }
    return AuvTopicTagItemResponse(
      id: json['id'] as int? ?? 0,
      tag: json['tag'] as String? ?? '',
      sort: json['sort'] as int? ?? 0,
      isFollow: json['isFollow'] as int? ?? 0,
      userSort: json['userSort'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag': tag,
      'sort': sort,
      'isFollow': isFollow,
      if (userSort != null) 'userSort': userSort,
    };
  }
}
