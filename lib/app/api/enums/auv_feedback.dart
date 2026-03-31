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
