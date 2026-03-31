import '../../enums/auv_call.dart';

/// 挂断通话请求模型
///
/// 用户或主播结束通话时提交的数据
class AuvEndCallRequest {
  /// 频道id
  ///
  /// 通话频道的唯一标识符
  final int channelId;
  
  /// 挂断原因
  ///
  /// 标识通话结束的原因
  /// - 0.正常挂断
  /// - 1.对方未接
  /// - 2.对方拒绝
  /// - 3.通话超时
  /// - 4.网络异常
  /// - 5.用户主动挂断
  /// - 6.对方挂断
  /// - 7.系统中断
  /// - 8.余额不足
  final int endType;
  
  /// 客户端挂断时间
  ///
  /// 客户端记录的实际挂断时间（毫秒时间戳）
  final int? clientEndAt;
  
  /// 客户端通话时长
  ///
  /// 客户端计算的通话持续时长（毫秒）
  final int? clientDuration;
  
  /// 不在视频范围内的时长
  ///
  /// 用户不在摄像头可视范围内的累计时长（毫秒）
  final int? outDuration;
  
  /// 不在视频范围内的次数
  ///
  /// 用户离开视频画面或关闭视频的次数
  final int? outCount;
  
  /// 请求次数
  ///
  /// 通话建立过程中发送的请求总次数
  final int? requestCount;
  
  /// 匹配模式
  ///
  /// 1.隐私模式
  final int? matchMode;

  AuvEndCallRequest({
    required this.channelId,
    required this.endType,
    this.clientEndAt,
    this.clientDuration,
    this.outDuration,
    this.outCount,
    this.requestCount,
    this.matchMode,
  });

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'endType': endType,
      if (clientEndAt != null) 'clientEndAt': clientEndAt,
      if (clientDuration != null) 'clientDuration': clientDuration,
      if (outDuration != null) 'outDuration': outDuration,
      if (outCount != null) 'outCount': outCount,
      if (requestCount != null) 'requestCount': requestCount,
      if (matchMode != null) 'matchMode': matchMode,
    };
  }

  /// 获取挂断原因描述
  ///
  /// 返回可读性更好的挂断原因文字说明
  String get endTypeDesc {
    switch (endType) {
      case 0:
        return '正常挂断';
      case 1:
        return '对方未接';
      case 2:
        return '对方拒绝';
      case 3:
        return '通话超时';
      case 4:
        return '网络异常';
      case 5:
        return '用户主动挂断';
      case 6:
        return '对方挂断';
      case 7:
        return '系统中断';
      case 8:
        return '余额不足';
      default:
        return '未知';
    }
  }
}
