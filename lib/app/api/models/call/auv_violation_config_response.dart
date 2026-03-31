/// 违规处罚配置响应模型
/// 
/// 获取通话违规处罚相关配置信息
class AuvViolationConfigResponse {
  /// 高频开关
  /// 
  /// 0.关闭，1.打开
  final int? preFlag;

  /// 低频开关
  /// 
  /// 0.关闭，1.打开
  final int? postFlag;

  /// 高频提醒开关
  /// 
  /// 0.关闭，1.打开
  final int? preRemind;

  /// 低频提醒开关
  /// 
  /// 0.关闭，1.打开
  final int? postRemind;

  /// 高频通话间隔数量
  final int? preDelayCount;

  /// 低频通话间隔数量
  final int? postDelayCount;

  /// 高频检测间隔秒数
  final int? preDelaySeconds;

  /// 低频检测间隔秒数
  final int? postDelaySeconds;

  /// 高频检测秒数
  final int? preTotalSeconds;

  /// 提醒次数
  final int? remindCount;

  /// 警告次数
  final int? warnCount;

  /// 封禁次数
  final int? banCount;

  /// 封禁类型
  final int? banType;

  /// 封禁理由
  final String? banReason;

  /// 重新认证间隔秒数
  final int? authDelaySeconds;

  /// 取消认证理由
  final String? cancelAuthReason;

  /// 今日违规次数
  final int? violateCount;

  /// 封禁分钟数
  final int? banMinutes;

  /// 违规重置天数
  final int? resetDays;

  AuvViolationConfigResponse({
    this.preFlag,
    this.postFlag,
    this.preRemind,
    this.postRemind,
    this.preDelayCount,
    this.postDelayCount,
    this.preDelaySeconds,
    this.postDelaySeconds,
    this.preTotalSeconds,
    this.remindCount,
    this.warnCount,
    this.banCount,
    this.banType,
    this.banReason,
    this.authDelaySeconds,
    this.cancelAuthReason,
    this.violateCount,
    this.banMinutes,
    this.resetDays,
  });

  factory AuvViolationConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvViolationConfigResponse();
    return AuvViolationConfigResponse(
      preFlag: json['preFlag'],
      postFlag: json['postFlag'],
      preRemind: json['preRemind'],
      postRemind: json['postRemind'],
      preDelayCount: json['preDelayCount'],
      postDelayCount: json['postDelayCount'],
      preDelaySeconds: json['preDelaySeconds'],
      postDelaySeconds: json['postDelaySeconds'],
      preTotalSeconds: json['preTotalSeconds'],
      remindCount: json['remindCount'],
      warnCount: json['warnCount'],
      banCount: json['banCount'],
      banType: json['banType'],
      banReason: json['banReason'],
      authDelaySeconds: json['authDelaySeconds'],
      cancelAuthReason: json['cancelAuthReason'],
      violateCount: json['violateCount'],
      banMinutes: json['banMinutes'],
      resetDays: json['resetDays'],
    );
  }
}