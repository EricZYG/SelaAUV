import 'package:slea_auv/app/rtm/auv_rtm_message_type.dart';

/// RTM 消息模型
class AuvRtmMessage {
  final String messageId;
  final int messageType;
  final String? text;
  final String? imageUrl;
  final String? videoUrl;
  final String? voiceUrl;
  final int? voiceDuration;
  final String? senderId;
  final String? receiverId;
  final int? timestamp;
  final Map<String, dynamic>? extra;

  AuvRtmMessage({
    required this.messageId,
    required this.messageType,
    this.text,
    this.imageUrl,
    this.videoUrl,
    this.voiceUrl,
    this.voiceDuration,
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.extra,
  });

  /// 获取消息类型枚举
  AuvRtmMessageType get type => AuvRtmMessageType.fromValue(messageType);

  /// 是否为基础消息
  bool get isBasicMessage => type.isBasicMessage;

  /// 是否为私密消息
  bool get isPrivacyMessage => type.isPrivacyMessage;

  /// 是否为通话消息
  bool get isCallMessage => type.isCallMessage;

  /// 是否为礼物消息
  bool get isGiftMessage => type.isGiftMessage;

  /// 是否为通知消息
  bool get isNotification => type.isNotification;

  /// 是否为直播间消息
  bool get isLiveMessage => type.isLiveMessage;

  factory AuvRtmMessage.fromJson(Map<String, dynamic> json) {
    return AuvRtmMessage(
      messageId: json['messageId'] ?? json['id'] ?? '',
      messageType: json['messageType'] ?? json['type'] ?? 11,
      text: json['text'],
      imageUrl: json['imageUrl'] ?? json['image_url'],
      videoUrl: json['videoUrl'] ?? json['video_url'],
      voiceUrl: json['voiceUrl'] ?? json['voice_url'],
      voiceDuration: json['voiceDuration'] ?? json['voice_duration'],
      senderId: json['senderId'] ?? json['sender_id'],
      receiverId: json['receiverId'] ?? json['receiver_id'],
      timestamp: json['timestamp'],
      extra: json['extra'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'messageType': messageType,
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      if (voiceUrl != null) 'voiceUrl': voiceUrl,
      if (voiceDuration != null) 'voiceDuration': voiceDuration,
      if (senderId != null) 'senderId': senderId,
      if (receiverId != null) 'receiverId': receiverId,
      if (timestamp != null) 'timestamp': timestamp,
      if (extra != null) 'extra': extra,
    };
  }

  @override
  String toString() {
    return 'AuvRtmMessage(id: $messageId, type: ${type.name}, text: $text)';
  }
}

/// 发送消息请求
class AuvSendMessageRequest {
  final String receiverId;
  final AuvRtmMessageType messageType;
  final String? text;
  final String? localPath;
  final Map<String, dynamic>? extra;

  AuvSendMessageRequest({
    required this.receiverId,
    required this.messageType,
    this.text,
    this.localPath,
    this.extra,
  });

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'messageType': messageType.value,
      if (text != null) 'text': text,
      if (localPath != null) 'localPath': localPath,
      if (extra != null) 'extra': extra,
    };
  }
}

/// 通话消息扩展数据
class AuvCallExtra {
  final String channelId;
  final int callType;
  final int duration;
  final int? fee;
  final String? giftId;
  final String? giftCount;

  AuvCallExtra({
    required this.channelId,
    required this.callType,
    this.duration = 0,
    this.fee,
    this.giftId,
    this.giftCount,
  });

  factory AuvCallExtra.fromJson(Map<String, dynamic> json) {
    return AuvCallExtra(
      channelId: json['channelId'] ?? '',
      callType: json['callType'] ?? 0,
      duration: json['duration'] ?? 0,
      fee: json['fee'],
      giftId: json['giftId'],
      giftCount: json['giftCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'callType': callType,
      'duration': duration,
      if (fee != null) 'fee': fee,
      if (giftId != null) 'giftId': giftId,
      if (giftCount != null) 'giftCount': giftCount,
    };
  }
}

/// 礼物消息扩展数据
class AuvGiftExtra {
  final String giftId;
  final String giftName;
  final String? giftIcon;
  final int count;
  final int? totalFee;

  AuvGiftExtra({
    required this.giftId,
    required this.giftName,
    this.giftIcon,
    required this.count,
    this.totalFee,
  });

  factory AuvGiftExtra.fromJson(Map<String, dynamic> json) {
    return AuvGiftExtra(
      giftId: json['giftId'] ?? '',
      giftName: json['giftName'] ?? '',
      giftIcon: json['giftIcon'],
      count: json['count'] ?? 1,
      totalFee: json['totalFee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'giftId': giftId,
      'giftName': giftName,
      if (giftIcon != null) 'giftIcon': giftIcon,
      'count': count,
      if (totalFee != null) 'totalFee': totalFee,
    };
  }
}

/// 心动等级变化消息扩展数据
class AuvHeartbeatLevelChangeExtra {
  /// 变化前的等级
  final int oldLevel;

  /// 变化后的等级
  final int newLevel;

  /// 变化后的心动值
  final int totalScore;

  /// 主播ID
  final int anchorId;

  /// 用户ID
  final int userId;

  AuvHeartbeatLevelChangeExtra({
    required this.oldLevel,
    required this.newLevel,
    required this.totalScore,
    required this.anchorId,
    required this.userId,
  });

  factory AuvHeartbeatLevelChangeExtra.fromJson(Map<String, dynamic> json) {
    return AuvHeartbeatLevelChangeExtra(
      oldLevel: json['oldLevel'] as int? ?? 0,
      newLevel: json['newLevel'] as int? ?? 0,
      totalScore: json['totalScore'] as int? ?? 0,
      anchorId: json['anchorId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'oldLevel': oldLevel,
      'newLevel': newLevel,
      'totalScore': totalScore,
      'anchorId': anchorId,
      'userId': userId,
    };
  }

  /// 是否是等级提升
  bool get isLevelUp => newLevel > oldLevel;

  /// 等级变化量
  int get levelDiff => newLevel - oldLevel;
}
