/// 系统相关Model
/// 
/// 包含翻译、国家配置等系统级接口的响应模型

// ==================== 翻译相关 ====================

/// 翻译文案响应
/// 
/// 获取App多语言翻译文案
/// 
/// 对应接口: GET /system/app/getTranslates
/// 可登录可不登录
/// 
/// 说明: 返回翻译文案的JSON文件URL，需要下载并解析该JSON文件获取完整的翻译内容
/// 
/// 响应示例:
/// ```json
/// {
///   "code": 0,
///   "message": "操作成功",
///   "timestamp": 1774846175444,
///   "data": "https://wss3.vipcallco.com/users/test/0/translate/sela100/en1765938887766.json"
/// }
/// ```
class AuvTranslateResponse {
  /// 翻译文案JSON文件的URL链接
  /// 类型: String
  /// 说明: 完整的翻译文案JSON文件下载地址
  /// 用途: 下载该文件后解析获取App界面的多语言文本
  /// 示例: "https://wss3.vipcallco.com/users/test/0/translate/sela100/en1765938887766.json"
  final String url;

  /// 时间戳
  /// 类型: int
  /// 说明: 服务器返回的时间戳（毫秒），可用于缓存控制
  final int timestamp;

  AuvTranslateResponse({
    required this.url,
    this.timestamp = 0,
  });

  /// 翻译文案是否有效
  bool get isValid => url.isNotEmpty;

  /// 获取语言类型
  /// 说明: 从URL中解析语言代码，如"en"、"zh"、"ja"等
  /// 返回: 语言代码（小写两字母），如"en"
  String? get languageCode {
    if (url.isEmpty) return null;
    final match = RegExp(r'/([a-z]{2})\d+\.json$').firstMatch(url);
    return match?.group(1);
  }

  /// 获取App渠道标识
  /// 说明: 从URL中解析App渠道，如"sela100"
  String? get appChannel {
    if (url.isEmpty) return null;
    final match = RegExp(r'/([a-z]+\d+)/').firstMatch(url);
    return match?.group(1);
  }

  /// 获取版本标识
  /// 说明: 从URL中获取翻译版本的时间戳部分
  String? get versionTag {
    if (url.isEmpty) return null;
    final match = RegExp(r'/([a-z]{2}\d+\.json)$').firstMatch(url);
    return match?.group(1);
  }

  factory AuvTranslateResponse.fromJson(Map<String, dynamic> json) {
    return AuvTranslateResponse(
      url: json is String ? json : (json['data'] ?? ''),
      timestamp: json['timestamp'] ?? 0,
    );
  }
}

// ==================== 违规处罚相关 ====================

/// 封禁类型枚举
enum AuvBanType {
  /// 未知
  unknown(0, '未知'),
  /// 临时封禁
  temporary(1, '临时封禁'),
  /// 永久封禁
  permanent(2, '永久封禁'),
  /// 部分功能封禁
  partial(3, '部分功能封禁'),
  /// 登录封禁
  loginBan(4, '登录封禁'),
  /// 通话封禁
  callBan(5, '通话封禁'),
  /// 消息封禁
  messageBan(6, '消息封禁'),
  /// 封禁提醒
  banReminder(7, '封禁提醒');

  final int value;
  final String label;
  const AuvBanType(this.value, this.label);

  static AuvBanType fromValue(int value) {
    return AuvBanType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvBanType.unknown,
    );
  }
}

/// 违规处罚配置
/// 
/// 获取用户违规处罚相关配置信息
/// 
/// 对应接口: GET /call/violate/getConfig
/// 需要登录
/// 
/// 说明: 包含高频/低频通话检测配置、处罚规则等
/// 
/// 响应示例:
/// ```json
/// {
///   "code": 0,
///   "message": "操作成功",
///   "timestamp": 1774846410387,
///   "data": {
///     "preFlag": 1,
///     "postFlag": 1,
///     "preRemind": 1,
///     "postRemind": 1,
///     "preDelayCount": 1,
///     "postDelayCount": 1,
///     "preDelaySeconds": 1,
///     "postDelaySeconds": 20,
///     "preTotalSeconds": 60,
///     "remindCount": 1,
///     "warnCount": 1,
///     "banCount": 1,
///     "banType": 7,
///     "banReason": "banReminder",
///     "authDelaySeconds": 60,
///     "cancelAuthReason": "cancelAuthReminder",
///     "violateCount": 0,
///     "banMinutes": 5,
///     "resetDays": 1
///   }
/// }
/// ```
class AuvViolateConfig {
  /// 高频检测开关
  /// 类型: int
  /// 说明: 0.关闭，1.打开
  /// 用途: 控制高频通话检测功能是否启用
  final int preFlag;

  /// 低频检测开关
  /// 类型: int
  /// 说明: 0.关闭，1.打开
  /// 用途: 控制低频通话检测功能是否启用
  final int postFlag;

  /// 高频提醒开关
  /// 类型: int
  /// 说明: 0.关闭，1.打开
  /// 用途: 高频检测触发时是否发送提醒
  final int preRemind;

  /// 低频提醒开关
  /// 类型: int
  /// 说明: 0.关闭，1.打开
  /// 用途: 低频检测触发时是否发送提醒
  final int postRemind;

  /// 高频通话间隔数量
  /// 类型: int
  /// 说明: 高频检测的通话间隔数量阈值
  final int preDelayCount;

  /// 低频通话间隔数量
  /// 类型: int
  /// 说明: 低频检测的通话间隔数量阈值
  final int postDelayCount;

  /// 高频检测间隔秒数
  /// 类型: int
  /// 说明: 高频检测的时间间隔（秒），如1表示每隔1秒检测一次
  final int preDelaySeconds;

  /// 低频检测间隔秒数
  /// 类型: int
  /// 说明: 低频检测的时间间隔（秒），如20表示每隔20秒检测一次
  final int postDelaySeconds;

  /// 高频检测秒数
  /// 类型: int
  /// 说明: 高频检测的总时长（秒），如60表示统计60秒内的通话情况
  final int preTotalSeconds;

  /// 提醒次数
  /// 类型: int
  /// 说明: 触发处罚前允许的提醒次数
  final int remindCount;

  /// 警告次数
  /// 类型: int
  /// 说明: 触发处罚前允许的警告次数
  final int warnCount;

  /// 封禁次数
  /// 类型: int
  /// 说明: 累计违规多少次后触发封禁
  final int banCount;

  /// 封禁类型
  /// 类型: int
  /// 说明: 封禁的类型，1.临时封禁，2.永久封禁，3.部分功能封禁，4.登录封禁，5.通话封禁，6.消息封禁，7.封禁提醒
  /// 参考: AuvBanType
  final int banType;

  /// 封禁理由
  /// 类型: String
  /// 说明: 封禁时显示给用户的理由描述
  /// 示例: "banReminder"
  final String banReason;

  /// 重新认证间隔秒数
  /// 类型: int
  /// 说明: 用户被取消认证后，重新认证需要等待的秒数
  final int authDelaySeconds;

  /// 取消认证理由
  /// 类型: String
  /// 说明: 取消认证时显示给用户的理由描述
  /// 示例: "cancelAuthReminder"
  final String cancelAuthReason;

  /// 今日违规次数
  /// 类型: int
  /// 说明: 用户当天的累计违规次数
  final int violateCount;

  /// 封禁分钟数
  /// 类型: int
  /// 说明: 临时封禁的时长（分钟），如5表示封禁5分钟
  final int banMinutes;

  /// 违规重置天数
  /// 类型: int
  /// 说明: 违规次数重置的周期（天），如1表示每天重置
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
    required this.banReason,
    required this.authDelaySeconds,
    required this.cancelAuthReason,
    required this.violateCount,
    required this.banMinutes,
    required this.resetDays,
  });

  /// 高频检测是否启用
  bool get isPreEnabled => preFlag == 1;

  /// 低频检测是否启用
  bool get isPostEnabled => postFlag == 1;

  /// 高频提醒是否启用
  bool get isPreRemindEnabled => preRemind == 1;

  /// 低频提醒是否启用
  bool get isPostRemindEnabled => postRemind == 1;

  /// 获取封禁类型枚举
  AuvBanType get banTypeEnum => AuvBanType.fromValue(banType);

  /// 获取封禁类型描述
  String get banTypeLabel => banTypeEnum.label;

  /// 获取剩余可用提醒次数
  int get remainingRemindCount => (remindCount - violateCount).clamp(0, remindCount);

  /// 获取剩余可用警告次数
  int get remainingWarnCount => (warnCount - violateCount).clamp(0, warnCount);

  /// 距离下次可重新认证还需等待的时间描述
  String get authDelayDescription {
    if (authDelaySeconds <= 0) return '无需等待';
    if (authDelaySeconds < 60) return '${authDelaySeconds}秒';
    final minutes = authDelaySeconds ~/ 60;
    final seconds = authDelaySeconds % 60;
    if (seconds == 0) return '$minutes分钟';
    return '$minutes分$seconds秒';
  }

  /// 获取违规严重程度描述
  String get severityDescription {
    if (violateCount == 0) return '正常';
    if (violateCount < remindCount) return '轻微';
    if (violateCount < warnCount) return '警告';
    if (violateCount < banCount) return '严重';
    return '已封禁';
  }

  /// 是否已触发封禁
  bool get isBanned => violateCount >= banCount;

  /// 获取封禁时长描述
  String get banDurationDescription {
    if (banMinutes <= 0) return '永久';
    if (banMinutes < 60) return '$banMinutes分钟';
    final hours = banMinutes ~/ 60;
    final minutes = banMinutes % 60;
    if (minutes == 0) return '$hours小时';
    return '$hours小时$minutes分钟';
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
      banReason: json['banReason'] ?? '',
      authDelaySeconds: json['authDelaySeconds'] ?? 0,
      cancelAuthReason: json['cancelAuthReason'] ?? '',
      violateCount: json['violateCount'] ?? 0,
      banMinutes: json['banMinutes'] ?? 0,
      resetDays: json['resetDays'] ?? 0,
    );
  }
}
