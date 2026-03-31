import 'auv_topic_moment_item.dart';

/// 话题项
class AuvTopicItemResponse {
  /// 话题ID
  final int topicId;

  /// 标签ID
  final int tagId;

  /// 标题
  final String title;

  /// 状态
  final int status;

  /// 图标
  final String? icon;

  /// 内容
  final String? content;

  /// 动态数量
  final String? momentCount;

  /// 点击量
  final int? clickCount;

  /// 第一个动态ID
  final int? firstMomentId;

  /// 创建时间
  final int createdAt;

  /// 第一个动态
  final AuvTopicMomentItem? moment;

  AuvTopicItemResponse({
    required this.topicId,
    required this.tagId,
    required this.title,
    required this.status,
    this.icon,
    this.content,
    this.momentCount,
    this.clickCount,
    this.firstMomentId,
    required this.createdAt,
    this.moment,
  });

  factory AuvTopicItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopicItemResponse(
        topicId: 0,
        tagId: 0,
        title: '',
        status: 0,
        createdAt: 0,
      );
    }
    return AuvTopicItemResponse(
      topicId: json['topicId'] as int? ?? 0,
      tagId: json['tagId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      icon: json['icon'] as String?,
      content: json['content'] as String?,
      momentCount: json['momentCount'] as String?,
      clickCount: json['clickCount'] as int?,
      firstMomentId: json['firstMomentId'] as int?,
      createdAt: json['createdAt'] as int? ?? 0,
      moment: json['moment'] != null
          ? AuvTopicMomentItem.fromJson(json['moment'] as Map<String, dynamic>)
          : null,
    );
  }
}
