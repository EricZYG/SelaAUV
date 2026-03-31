/// 消息类型枚举
enum AuvMessageType {
  /// 未知
  unknown(0),
  
  /// 文本消息
  text(1),
  
  /// 图片消息
  image(2),
  
  /// 语音消息
  voice(3),
  
  /// 视频消息
  video(4),
  
  /// 礼物消息
  gift(5),
  
  /// 系统消息
  system(6),

  /// 撤回消息
  revoke(7),

  /// 主播消息
  anchor(8),

  /// 表情消息
  expression(9),

  /// 点赞消息
  like(10),

  /// 进入房间消息
  enterRoom(11),

  /// 离开房间消息
  leaveRoom(12),

  /// 直播间推送消息
  push(13);

  final int value;
  const AuvMessageType(this.value);

  static AuvMessageType fromValue(int value) {
    return AuvMessageType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvMessageType.unknown,
    );
  }
}
