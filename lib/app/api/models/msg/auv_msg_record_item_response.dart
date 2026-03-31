/// 聊天记录项模型
///
/// 分页查询聊天记录接口返回的数据
///
/// 字段说明:
/// - id: 主键id，用于后续传到offsetId参数
/// - fromUserId: 发送方用户id
/// - targetUserId: 接收方用户id
/// - msgType: 消息类型(1.文字, 2.图片, 4.视频, 5.语音等)
/// - content: 消息内容，对应发送消息接口的urlOrContent参数
/// - jsonData: 发给对方的原内容
/// - extraData: 额外内容
/// - createdAt: 发送时间
/// - otherUsername: 对方用户名
/// - otherNickname: 对方昵称
/// - otherPortrait: 对方头像
/// - otherIsOnline: 对方是否在线(0.离线, 1.在线)
class AuvMsgRecordItemResponse {
  /// 主键id，用于后续传到offsetId参数
  final String? id;

  /// 发送方用户id
  final int? fromUserId;

  /// 接收方用户id
  final int? targetUserId;

  /// 消息类型: 1.文字, 2.图片, 4.视频, 5.语音等
  final int? msgType;

  /// 消息内容
  final String? content;

  /// 发给对方的原内容
  final String? jsonData;

  /// 额外内容
  final String? extraData;

  /// 发送时间
  final int? createdAt;

  /// 对方用户名
  final String? otherUsername;

  /// 对方昵称
  final String? otherNickname;

  /// 对方头像
  final String? otherPortrait;

  /// 对方是否在线(0.离线, 1.在线)
  final int? otherIsOnline;

  AuvMsgRecordItemResponse({
    this.id,
    this.fromUserId,
    this.targetUserId,
    this.msgType,
    this.content,
    this.jsonData,
    this.extraData,
    this.createdAt,
    this.otherUsername,
    this.otherNickname,
    this.otherPortrait,
    this.otherIsOnline,
  });

  factory AuvMsgRecordItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvMsgRecordItemResponse();
    return AuvMsgRecordItemResponse(
      id: json['id']?.toString(),
      fromUserId: json['fromUserId'],
      targetUserId: json['targetUserId'],
      msgType: json['msgType'],
      content: json['content'],
      jsonData: json['jsonData'],
      extraData: json['extraData'],
      createdAt: json['createdAt'],
      otherUsername: json['otherUsername'],
      otherNickname: json['otherNickname'],
      otherPortrait: json['otherPortrait'],
      otherIsOnline: json['otherIsOnline'],
    );
  }

  /// 是否是文字消息
  bool get isTextMessage => msgType == 1;

  /// 是否是图片消息
  bool get isImageMessage => msgType == 2;

  /// 是否是视频消息
  bool get isVideoMessage => msgType == 4;

  /// 是否是语音消息
  bool get isVoiceMessage => msgType == 5;

  /// 对方是否在线
  bool get isOtherOnline => otherIsOnline == 1;

  /// 获取发送时间(DateTime)
  DateTime? get createdAtDateTime {
    if (createdAt == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt!);
  }
}
