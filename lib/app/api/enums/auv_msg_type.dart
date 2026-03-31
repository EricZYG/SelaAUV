/// 消息类型枚举
enum AuvMsgType {
  text(11),      // 文字
  image(12),     // 图片
  video(14),     // 视频
  voice(15);     // 语音

  final int value;
  const AuvMsgType(this.value);

  static AuvMsgType? fromValue(int value) {
    return AuvMsgType.values.where((e) => e.value == value).firstOrNull;
  }
}
