/// 上报通话质量请求模型
/// 
/// 上报通话质量数据用于监控分析
class AuvReportCallRequest {
  /// 频道id
  /// 
  /// 通话频道的唯一标识符
  final int channelId;
  
  /// 接收质量
  /// 
  /// 通话中接收到的音频/视频质量指标
  final int rxQuality;
  
  /// 时间戳
  /// 
  /// 采集质量数据的时间，毫秒数
  final int time;
  
  /// 发送质量
  /// 
  /// 通话中发送的音频/视频质量指标
  final int txQuality;
  
  /// 是否是对方
  /// 
  /// 标识当前上报的是自己还是对方的质量数据
  /// - 0: 自己
  /// - 1: 对方
  final int isRemote;

  AuvReportCallRequest({
    required this.channelId,
    required this.rxQuality,
    required this.time,
    required this.txQuality,
    required this.isRemote,
  });

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'rxQuality': rxQuality,
      'time': time,
      'txQuality': txQuality,
      'isRemote': isRemote,
    };
  }
}
