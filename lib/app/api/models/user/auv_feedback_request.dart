/// 举报类型
///
/// 1. 反馈
/// 2. 举报
/// 3. 官方回复
class AuvFeedbackType {
  static const int feedback = 1;
  static const int report = 2;
  static const int officialReply = 3;
}

/// 举报主题类型
class AuvFeedbackTopicType {
  /// 广告骚扰
  static const int adHarassment = 1;
  /// 对话懒散
  static const int lazyChat = 2;
  /// 主播不露脸
  static const int noShow = 3;
  /// 攻击谩骂
  static const int abuse = 4;
  /// 虚假信息
  static const int fakeInfo = 5;
  /// 诈骗
  static const int scam = 6;
  /// 政治
  static const int political = 7;
  /// 淫秽色情
  static const int pornographic = 8;
  /// 其他
  static const int other = 9;
  /// 虐待儿童
  static const int childAbuse = 10;
}

/// 举报/反馈请求模型
///
/// 对应接口: /user/feedback/save
///
/// 字段说明:
/// - type: 举报类型，1.反馈，2.举报，3.官方回复
/// - anchorUserId: 主播的用户ID（可选）
/// - linkId: 关联id，如举报通话则传入频道id（可选）
/// - topicType: 举报主题（必填）
/// - content: 内容（必填）
/// - path: 图片地址，多个图片用逗号分开（必填）
class AuvFeedbackRequest {
  /// 举报类型，1.反馈，2.举报，3.官方回复
  final int type;

  /// 主播的用户ID（可选）
  final int? anchorUserId;

  /// 关联id，如举报通话则传入频道id（可选）
  final int? linkId;

  /// 举报主题（必填）
  final int topicType;

  /// 内容（必填）
  final String content;

  /// 图片地址，多个图片用逗号分开（必填）
  final String? path;

  AuvFeedbackRequest({
    required this.type,
    required this.topicType,
    required this.content,
    this.anchorUserId,
    this.linkId,
    this.path,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      if (anchorUserId != null) 'anchorUserId': anchorUserId,
      if (linkId != null) 'linkId': linkId,
      'topicType': topicType,
      'content': content,
      if (path != null) 'path': path,
    };
  }
}
