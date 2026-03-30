/// 通话聊天室模型
/// 
/// 加入通话聊天室接口返回的数据
/// 
/// 字段说明:
/// - channelId: 频道ID
/// - startAt: 开始计时时间
/// - status: 通话状态 (0:正常, 1:未接, 2:拒绝, 3:通话中)
/// - imToken: IM连接令牌(用于连接即时通讯)
class AuvCallChatRoomResponse {
  /// 频道ID
  final int? channelId;
  
  /// 开始计时时间
  final int? startAt;
  
  /// 通话状态
  /// 0: 正常
  /// 1: 未接
  /// 2: 拒绝
  /// 3: 通话中
  final int? status;
  
  /// IM连接令牌(用于连接即时通讯)
  final String? imToken;

  AuvCallChatRoomResponse({
    this.channelId,
    this.startAt,
    this.status,
    this.imToken,
  });

  factory AuvCallChatRoomResponse.fromJson(Map<String, dynamic> json) {
    return AuvCallChatRoomResponse(
      channelId: json['channelId'],
      startAt: json['startAt'],
      status: json['status'],
      imToken: json['imToken'],
    );
  }
}