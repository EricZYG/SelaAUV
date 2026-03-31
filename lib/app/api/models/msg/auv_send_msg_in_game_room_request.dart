/// 游戏房间发送消息请求参数
///
/// 用于在游戏房间中发送实时消息
class AuvSendMsgInGameRoomRequest {
  /// 接收者id，固定传0
  final int recipientId;

  /// 频道名称
  final String channelId;

  /// 消息类型: 11.文字, 12.图片, 14.视频, 15.语音
  final int type;

  /// 图片地址/视频地址/语音地址/文本内容
  final String? urlOrContent;

  /// 客户端自定义数据
  final String? jsonData;

  AuvSendMsgInGameRoomRequest({
    this.recipientId = 0,
    required this.channelId,
    required this.type,
    this.urlOrContent,
    this.jsonData,
  });

  Map<String, dynamic> toJson() {
    return {
      'recipientId': recipientId,
      'channelId': channelId,
      'type': type,
      if (urlOrContent != null) 'urlOrContent': urlOrContent,
      if (jsonData != null) 'jsonData': jsonData,
    };
  }

  /// 创建文字消息
  static AuvSendMsgInGameRoomRequest textMessage({
    required String channelId,
    required String content,
    String? jsonData,
  }) {
    return AuvSendMsgInGameRoomRequest(
      channelId: channelId,
      type: 11,
      urlOrContent: content,
      jsonData: jsonData,
    );
  }

  /// 创建图片消息
  static AuvSendMsgInGameRoomRequest imageMessage({
    required String channelId,
    required String imageUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInGameRoomRequest(
      channelId: channelId,
      type: 12,
      urlOrContent: imageUrl,
      jsonData: jsonData,
    );
  }

  /// 创建视频消息
  static AuvSendMsgInGameRoomRequest videoMessage({
    required String channelId,
    required String videoUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInGameRoomRequest(
      channelId: channelId,
      type: 14,
      urlOrContent: videoUrl,
      jsonData: jsonData,
    );
  }

  /// 创建语音消息
  static AuvSendMsgInGameRoomRequest voiceMessage({
    required String channelId,
    required String voiceUrl,
    String? jsonData,
  }) {
    return AuvSendMsgInGameRoomRequest(
      channelId: channelId,
      type: 15,
      urlOrContent: voiceUrl,
      jsonData: jsonData,
    );
  }

  /// 消息类型常量
  static const int typeText = 11;
  static const int typeImage = 12;
  static const int typeVideo = 14;
  static const int typeVoice = 15;
}
