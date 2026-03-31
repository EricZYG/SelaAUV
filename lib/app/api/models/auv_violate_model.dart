/// 违规处罚配置Model
/// 
/// 对应接口: GET /call/violate/getConfig
/// 
/// 响应示例:
/// ```json
/// {
///   "preFlag": 1,
///   "postFlag": 1,
///   "preRemind": 1,
///   "postRemind": 1,
///   "preDelayCount": 1,
///   "postDelayCount": 1,
///   "preDelaySeconds": 1,
///   "postDelaySeconds": 20,
///   "preTotalSeconds": 60,
///   "remindCount": 1,
///   "warnCount": 1,
///   "banCount": 1,
///   "banType": 7,
///   "banMinutes": 5,
///   "resetDays": 1,
///   "violateCount": 0
/// }
/// ```
class AuvViolateConfig {
  /// 高频开关
  /// 类型: int
  /// 说明: 0.关闭，1.打开
  final int preFlag;

  /// 低频开关
  /// 类型: int
  /// 说明: 0.关闭，1.打开
  final int postFlag;

  /// 高频提醒开关
  /// 类型: int
  /// 说明: 0.关闭，1.打开
  final int preRemind;

  /// 低频提醒开关
  /// 类型: int
  /// 说明: 0.关闭，1.打开
  final int postRemind;

  /// 高频通话间隔数量
  /// 类型: int
  /// 说明: 触发高频检测的通话次数阈值
  final int preDelayCount;

  /// 低频通话间隔数量
  /// 类型: int
  /// 说明: 触发低频检测的通话次数阈值
  final int postDelayCount;

  /// 高频检测间隔秒数
  /// 类型: int
  /// 说明: 高频检测的时间窗口（秒）
  final int preDelaySeconds;

  /// 低频检测间隔秒数
  /// 类型: int
  /// 说明: 低频检测的时间窗口（秒）
  final int postDelaySeconds;

  /// 高频检测秒数
  /// 类型: int
  /// 说明: 高频检测的总时长（秒）
  final int preTotalSeconds;

  /// 提醒次数
  /// 类型: int
  /// 说明: 累计多少次违规后发送提醒
  final int remindCount;

  /// 警告次数
  /// 类型: int
  /// 说明: 累计多少次违规后发送警告
  final int warnCount;

  /// 封禁次数
  /// 类型: int
  /// 说明: 累计多少次违规后执行封禁
  final int banCount;

  /// 封禁类型
  /// 类型: int
  /// 说明: 封禁的类型标识
  final int banType;

  /// 封禁理由
  /// 类型: String?
  /// 说明: 执行封禁时显示的理由文本
  final String? banReason;

  /// 重新认证间隔秒数
  /// 类型: int?
  /// 说明: 被取消认证后重新认证需要等待的秒数
  final int? authDelaySeconds;

  /// 取消认证理由
  /// 类型: String?
  /// 说明: 取消认证时显示的理由文本
  final String? cancelAuthReason;

  /// 今日违规次数
  /// 类型: int
  /// 说明: 当天累计的违规次数
  final int violateCount;

  /// 封禁分钟数
  /// 类型: int
  /// 说明: 每次封禁的时长（分钟）
  final int banMinutes;

  /// 违规重置天数
  /// 类型: int
  /// 说明: 违规计数重置的周期（天）
  final int resetDays;

  AuvViolateConfig({
    required this.preFlag,
    required this.postFlag,
    required this.preRemind,
    required this.postRemind,
    required this.preDelayCount,
    required this.postDelayCount,
    required this.preDelaySeconds,
    required this.postDelaySeconds,
    required this.preTotalSeconds,
    required this.remindCount,
    required this.warnCount,
    required this.banCount,
    required this.banType,
    this.banReason,
    this.authDelaySeconds,
    this.cancelAuthReason,
    required this.violateCount,
    required this.banMinutes,
    required this.resetDays,
  });

  /// 高频开关是否打开
  bool get isPreEnabled => preFlag == 1;

  /// 低频开关是否打开
  bool get isPostEnabled => postFlag == 1;

  /// 高频提醒是否打开
  bool get isPreRemindEnabled => preRemind == 1;

  /// 低频提醒是否打开
  bool get isPostRemindEnabled => postRemind == 1;

  /// 是否需要提醒
  bool get shouldRemind => violateCount >= remindCount;

  /// 是否需要警告
  bool get shouldWarn => violateCount >= warnCount;

  /// 是否需要封禁
  bool get shouldBan => violateCount >= banCount;

  /// 获取当前处罚阶段
  String get punishmentStage {
    if (violateCount >= banCount) return '封禁';
    if (violateCount >= warnCount) return '警告';
    if (violateCount >= remindCount) return '提醒';
    return '正常';
  }

  /// 获取距离下次处罚的违规次数
  int get violationsUntilNextPunishment {
    if (violateCount >= banCount) return 0;
    if (violateCount >= warnCount) return banCount - violateCount;
    if (violateCount >= remindCount) return warnCount - violateCount;
    return remindCount - violateCount;
  }

  factory AuvViolateConfig.fromJson(Map<String, dynamic> json) {
    return AuvViolateConfig(
      preFlag: json['preFlag'] ?? 0,
      postFlag: json['postFlag'] ?? 0,
      preRemind: json['preRemind'] ?? 0,
      postRemind: json['postRemind'] ?? 0,
      preDelayCount: json['preDelayCount'] ?? 0,
      postDelayCount: json['postDelayCount'] ?? 0,
      preDelaySeconds: json['preDelaySeconds'] ?? 0,
      postDelaySeconds: json['postDelaySeconds'] ?? 0,
      preTotalSeconds: json['preTotalSeconds'] ?? 0,
      remindCount: json['remindCount'] ?? 0,
      warnCount: json['warnCount'] ?? 0,
      banCount: json['banCount'] ?? 0,
      banType: json['banType'] ?? 0,
      banReason: json['banReason'],
      authDelaySeconds: json['authDelaySeconds'],
      cancelAuthReason: json['cancelAuthReason'],
      violateCount: json['violateCount'] ?? 0,
      banMinutes: json['banMinutes'] ?? 0,
      resetDays: json['resetDays'] ?? 0,
    );
  }
}
