/// 主播风格枚举
enum AuvAnchorStyle {
  display(1),   // 展示型
  chatting(2),   // 聊天型
  casual(3);    // 随意型

  final int value;
  const AuvAnchorStyle(this.value);
}

/// 性别枚举
enum AuvSex {
  male(1),   // 男
  female(2); // 女

  final int value;
  const AuvSex(this.value);
}

/// 匹配类型枚举
enum AuvMatchAnchorType {
  real(0),   // 真实主播
  virtual(1); // 虚拟视频

  final int value;
  const AuvMatchAnchorType(this.value);
}

/// 高风险类型
enum AuvAnchorFKType {
  privateContent(1, '私密内容'),
  sexualContent(2, '色情内容'),
  violentContent(3, '暴力内容'),
  politicalContent(4, '政治内容'),
  otherContent(5, '其他违规');

  final int value;
  final String desc;
  const AuvAnchorFKType(this.value, this.desc);
}
