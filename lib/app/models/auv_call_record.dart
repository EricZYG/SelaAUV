import 'package:slea_auv/app/models/auv_call_end_type.dart';

/// 通话记录模型
class AuvCallRecord {
  final String id;
  final String channelId;
  final String callerId;
  final String callerName;
  final String? callerAvatar;
  final String receiverId;
  final String receiverName;
  final String? receiverAvatar;
  final AuvCallType callType;
  final AuvCallStatus status;
  final AuvCallEndType endType;
  final int duration;
  final int fee;
  final int createTime;
  final int? endTime;

  AuvCallRecord({
    required this.id,
    required this.channelId,
    required this.callerId,
    required this.callerName,
    this.callerAvatar,
    required this.receiverId,
    required this.receiverName,
    this.receiverAvatar,
    required this.callType,
    required this.status,
    required this.endType,
    required this.duration,
    required this.fee,
    required this.createTime,
    this.endTime,
  });

  /// 是否为已接通通话
  bool get isConnected => status == AuvCallStatus.connected;

  /// 是否为正常结束
  bool get isNormalEnd => endType.isNormalEnd;

  /// 是否为对方原因
  bool get isPeerReason => endType.isPeerReason;

  /// 是否为余额不足
  bool get isBalanceIssue => endType.isBalanceIssue;

  /// 获取结束原因描述
  String get endReason => endType.description;

  /// 获取通话时长格式化字符串
  String get durationFormatted {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  factory AuvCallRecord.fromJson(Map<String, dynamic> json) {
    return AuvCallRecord(
      id: json['id']?.toString() ?? '',
      channelId: json['channel_id'] ?? json['channelId'] ?? '',
      callerId: json['caller_id'] ?? json['callerId'] ?? '',
      callerName: json['caller_name'] ?? json['callerName'] ?? '',
      callerAvatar: json['caller_avatar'],
      receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
      receiverName: json['receiver_name'] ?? json['receiverName'] ?? '',
      receiverAvatar: json['receiver_avatar'],
      callType: AuvCallType.fromValue(json['call_type'] ?? json['callType'] ?? 1),
      status: AuvCallStatus.fromValue(json['status'] ?? 4),
      endType: AuvCallEndType.fromValue(json['end_type'] ?? json['endType'] ?? 0),
      duration: json['duration'] ?? 0,
      fee: json['fee'] ?? 0,
      createTime: json['create_time'] ?? json['createTime'] ?? 0,
      endTime: json['end_time'] ?? json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'channel_id': channelId,
      'caller_id': callerId,
      'caller_name': callerName,
      'caller_avatar': callerAvatar,
      'receiver_id': receiverId,
      'receiver_name': receiverName,
      'receiver_avatar': receiverAvatar,
      'call_type': callType.value,
      'status': status.value,
      'end_type': endType.value,
      'duration': duration,
      'fee': fee,
      'create_time': createTime,
      if (endTime != null) 'end_time': endTime,
    };
  }
}

/// 通话记录列表响应
class AuvCallRecordResponse {
  final List<AuvCallRecord> list;
  final int page;
  final int pageSize;
  final int total;

  AuvCallRecordResponse({
    required this.list,
    required this.page,
    required this.pageSize,
    required this.total,
  });

  bool get hasMore => list.length >= pageSize;
  bool get isEmpty => list.isEmpty;

  factory AuvCallRecordResponse.fromJson(Map<String, dynamic> json) {
    final listData = json['list'] ?? json['data'] ?? [];
    return AuvCallRecordResponse(
      list: (listData as List).map((e) => AuvCallRecord.fromJson(e)).toList(),
      page: json['page'] ?? 1,
      pageSize: json['page_size'] ?? json['pageSize'] ?? 20,
      total: json['total'] ?? 0,
    );
  }
}
