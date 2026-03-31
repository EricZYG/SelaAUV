import '../enums/auv_feedback.dart';

/// 举报/反馈类型
enum AuvFeedbackType {
  feedback(1),      // 反馈
  report(2),         // 举报
  officialReply(3);  // 官方回复

  final int value;
  const AuvFeedbackType(this.value);
}

/// 举报主题类型
enum AuvFeedbackTopicType {
  adSpam(1),           // 广告骚扰
  lazyChat(2),         // 对话懒散
  noFaceShow(3),       // 主播不露脸
  abuse(4),            // 攻击谩骂
  fakeInfo(5),         // 虚假信息
  scam(6),             // 诈骗
  politics(7),         // 政治
  obscene(8),          // 淫秽色情
  other(9),            // 其他
  childAbuse(10);      // 虐待儿童

  final int value;
  const AuvFeedbackTopicType(this.value);
}

/// 举报/反馈请求
class AuvFeedbackRequest {
  final AuvFeedbackType type;       // 举报类型
  final int? anchorUserId;        // 主播用户ID
  final int? linkId;              // 关联ID（如频道ID）
  final AuvFeedbackTopicType topicType; // 举报主题
  final String content;           // 内容
  final String? path;            // 图片地址，多个用逗号分开

  AuvFeedbackRequest({
    required this.type,
    this.anchorUserId,
    this.linkId,
    required this.topicType,
    required this.content,
    this.path,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.value,
      if (anchorUserId != null) 'anchorUserId': anchorUserId,
      if (linkId != null) 'linkId': linkId,
      'topicType': topicType.value,
      'content': content,
      if (path != null) 'path': path,
    };
  }
}

/// 设置密码请求
class AuvSetPasswordRequest {
  final String newPassword; // 新密码

  AuvSetPasswordRequest({required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'newPassword': newPassword,
    };
  }
}

/// 修改密码请求
class AuvChangePasswordRequest {
  final String oriPassword;  // 原密码
  final String newPassword; // 新密码

  AuvChangePasswordRequest({
    required this.oriPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oriPassword': oriPassword,
      'newPassword': newPassword,
    };
  }
}
