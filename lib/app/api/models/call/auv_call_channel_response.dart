/// 通话频道模型
/// 
/// 创建通话频道接口返回的数据
/// 
/// 字段说明:
/// - channelId: 频道ID
/// - type: 通话类型 (0:普通通话, 1:AIB通话, 2:匹配通话)
/// - startAt: 开始计时时间
/// - status: 通话状态 (0:正常, 1:未接, 2:拒绝, 3:通话中)
class AuvCallChannelResponse {
  /// 频道ID
  final int? channelId;
  
  /// 通话类型
  /// 0: 普通通话
  /// 1: AIB通话
  /// 2: 匹配通话
  final int? type;
  
  /// 开始计时时间
  final int? startAt;
  
  /// 通话状态
  /// 0: 正常
  /// 1: 未接
  /// 2: 拒绝
  /// 3: 通话中
  final int? status;

  AuvCallChannelResponse({
    this.channelId,
    this.type,
    this.startAt,
    this.status,
  });

  factory AuvCallChannelResponse.fromJson(Map<String, dynamic> json) {
    return AuvCallChannelResponse(
      channelId: json['channelId'],
      type: json['type'],
      startAt: json['startAt'],
      status: json['status'],
    );
  }
}