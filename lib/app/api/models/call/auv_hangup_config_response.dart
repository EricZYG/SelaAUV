/// 挂机检测配置项响应模型
/// 
/// 表示单条挂机检测配置信息
class AuvHangupConfigItemResponse {
  /// 挂机类型
  /// 
  /// 1.正常模式，2.匹配模式
  final int? hangupType;

  /// 检测间隔，单位秒
  final int? delaySeconds;

  /// 关闭弹窗时间，单位秒
  final int? closeSeconds;

  /// 每日开始时间，格式HH:mm
  final String? dailyBegin;

  /// 每日结束时间，格式HH:mm
  final String? dailyEnd;

  AuvHangupConfigItemResponse({
    this.hangupType,
    this.delaySeconds,
    this.closeSeconds,
    this.dailyBegin,
    this.dailyEnd,
  });

  factory AuvHangupConfigItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvHangupConfigItemResponse();
    return AuvHangupConfigItemResponse(
      hangupType: json['hangupType'],
      delaySeconds: json['delaySeconds'],
      closeSeconds: json['closeSeconds'],
      dailyBegin: json['dailyBegin'],
      dailyEnd: json['dailyEnd'],
    );
  }
}