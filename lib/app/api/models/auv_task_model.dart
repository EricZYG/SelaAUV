import '../enums/auv_task.dart';

/// 任务奖励配置
class TaskRewardConfig {
  final int rewardType;    // 1钻石奖励 2道具奖励 3优惠券奖励 4金币奖励
  final int num;           // 钻石奖励个数
  final String numStr;     // 奖励数量字符串
  final int callCardNum;   // 通话卡片数量
  final int matchCardNum;  // 匹配卡片数量
  final int chatCardNum;   // 聊天卡片数量

  TaskRewardConfig({
    required this.rewardType,
    required this.num,
    this.numStr = '',
    this.callCardNum = 0,
    this.matchCardNum = 0,
    this.chatCardNum = 0,
  });

  factory TaskRewardConfig.fromJson(Map<String, dynamic> json) {
    return TaskRewardConfig(
      rewardType: json['rewardType'] ?? 1,
      num: int.tryParse(json['num']?.toString() ?? '0') ?? 0,
      numStr: json['numStr'] ?? '',
      callCardNum: json['callCardNum'] ?? 0,
      matchCardNum: json['matchCardNum'] ?? 0,
      chatCardNum: json['chatCardNum'] ?? 0,
    );
  }

  /// 是否钻石奖励
  bool get isDiamondReward => rewardType == 1;

  /// 是否道具奖励
  bool get isPropReward => rewardType == 2;

  /// 是否优惠券奖励
  bool get isCouponReward => rewardType == 3;

  /// 是否金币奖励
  bool get isGoldReward => rewardType == 4;
}

/// 任务完成进度配置
class TaskCompleteConfig {
  final int total;  // 完成进度配置目标值

  TaskCompleteConfig({required this.total});

  factory TaskCompleteConfig.fromJson(Map<String, dynamic> json) {
    return TaskCompleteConfig(
      total: json['total'] ?? 0,
    );
  }
}

/// 任务奖励展示VO
class TaskRewardVo {
  final int diamondNum;     // 钻石数量
  final int goldNum;         // 金币数量
  final int callCardNum;     // 通话卡片数量
  final int chatCardNum;     // 聊天卡片数量
  final int matchCardNum;    // 匹配卡片数量
  final int couponNum;       // 优惠券数量

  TaskRewardVo({
    this.diamondNum = 0,
    this.goldNum = 0,
    this.callCardNum = 0,
    this.chatCardNum = 0,
    this.matchCardNum = 0,
    this.couponNum = 0,
  });

  factory TaskRewardVo.fromJson(Map<String, dynamic> json) {
    return TaskRewardVo(
      diamondNum: json['diamondNum'] ?? 0,
      goldNum: json['goldNum'] ?? 0,
      callCardNum: json['callCardNum'] ?? 0,
      chatCardNum: json['chatCardNum'] ?? 0,
      matchCardNum: json['matchCardNum'] ?? 0,
      couponNum: json['couponNum'] ?? 0,
    );
  }
}

/// 任务类型
enum TaskType {
  newUser(1),    // 新手任务
  daily(2),      // 日常任务
  vip(3);        // VIP任务

  final int value;
  const TaskType(this.value);

  static TaskType fromValue(int value) {
    return TaskType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TaskType.newUser,
    );
  }
}

/// 任务状态
enum TaskStatus {
  unfinished(-1),              // 未完成
  completedNotClaimed(1),      // 已完成未领取
  claimed(2);                  // 已领取

  final int value;
  const TaskStatus(this.value);

  static TaskStatus fromValue(int value) {
    return TaskStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TaskStatus.unfinished,
    );
  }
}

/// 跳转类型
enum JumpType {
  webPage(0),   // 网页
  appPage(1);   // APP内页

  final int value;
  const JumpType(this.value);

  static JumpType fromValue(int value) {
    return JumpType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => JumpType.webPage,
    );
  }
}

/// 任务项
class AuvTaskItem {
  final int taskId;                    // 任务ID
  final String title;                   // 任务标题
  final List<TaskRewardConfig> rewardJson; // 任务完成奖励配置
  final TaskRewardVo rewardVo;          // 奖励展示VO
  final TaskType taskType;             // 1新手任务 2日常任务 3vip任务
  final String jumpUrl;                 // 跳转链接
  final JumpType target;               // 跳转类型，0网页 1APP内页
  final String dateFormat;              // 时间格式
  final TaskStatus taskStatus;         // -1未完成 1已完成未领取 2已领取
  final int remainDuration;             // 任务剩余时长
  final String taskUnique;              // 任务唯一标识
  final int sortWeight;                 // 排序权重
  final String icon;                    // 任务图标
  final TaskCompleteConfig completeConfig; // 完成进度配置

  AuvTaskItem({
    required this.taskId,
    required this.title,
    required this.rewardJson,
    required this.rewardVo,
    required this.taskType,
    required this.jumpUrl,
    required this.target,
    required this.dateFormat,
    required this.taskStatus,
    required this.remainDuration,
    required this.taskUnique,
    required this.sortWeight,
    required this.icon,
    required this.completeConfig,
  });

  factory AuvTaskItem.fromJson(Map<String, dynamic> json) {
    return AuvTaskItem(
      taskId: json['taskId'] ?? 0,
      title: json['title'] ?? '',
      rewardJson: (json['rewardJson'] as List?)
              ?.map((e) => TaskRewardConfig.fromJson(e))
              .toList() ??
          [],
      rewardVo: json['rewardVo'] != null
          ? TaskRewardVo.fromJson(json['rewardVo'])
          : TaskRewardVo(),
      taskType: TaskType.fromValue(json['taskType'] ?? 1),
      jumpUrl: json['jumpUrl'] ?? '',
      target: JumpType.fromValue(json['target'] ?? 0),
      dateFormat: json['dateFormat'] ?? '',
      taskStatus: TaskStatus.fromValue(json['taskStatus'] ?? -1),
      remainDuration: json['remainDuration'] ?? 0,
      taskUnique: json['taskUnique'] ?? '',
      sortWeight: json['sortWeight'] ?? 0,
      icon: json['icon'] ?? '',
      completeConfig: json['completeConfigJson'] != null
          ? TaskCompleteConfig.fromJson(json['completeConfigJson'])
          : TaskCompleteConfig(total: 0),
    );
  }

  /// 是否新手任务
  bool get isNewUserTask => taskType == TaskType.newUser;

  /// 是否日常任务
  bool get isDailyTask => taskType == TaskType.daily;

  /// 是否VIP任务
  bool get isVipTask => taskType == TaskType.vip;

  /// 是否已完成
  bool get isCompleted => taskStatus == TaskStatus.completedNotClaimed;

  /// 是否已领取
  bool get isClaimed => taskStatus == TaskStatus.claimed;

  /// 是否可领取
  bool get canClaim => taskStatus == TaskStatus.completedNotClaimed;

  /// 提取标题中的进度
  /// 例如："新手任务-关注（0/3）个主播" -> (0, 3)
  (int current, int total) get progress {
    final regex = RegExp(r'（(\d+)/(\d+)）');
    final match = regex.firstMatch(title);
    if (match != null) {
      return (int.parse(match.group(1)!), int.parse(match.group(2)!));
    }
    return (0, completeConfig.total);
  }
}

/// 任务领取结果
class AuvTaskDrawResult {
  final List<TaskRewardConfig> rewardJson;  // 奖励配置列表
  final TaskRewardVo rewardVo;             // 奖励展示VO
  final String taskUnique;                 // 任务唯一标识

  AuvTaskDrawResult({
    required this.rewardJson,
    required this.rewardVo,
    required this.taskUnique,
  });

  factory AuvTaskDrawResult.fromJson(Map<String, dynamic> json) {
    return AuvTaskDrawResult(
      rewardJson: (json['rewardJson'] as List?)
              ?.map((e) => TaskRewardConfig.fromJson(e))
              .toList() ??
          [],
      rewardVo: json['rewardVo'] != null
          ? TaskRewardVo.fromJson(json['rewardVo'])
          : TaskRewardVo(),
      taskUnique: json['taskUnique'] ?? '',
    );
  }

  /// 获取钻石奖励数量
  int get diamondReward => rewardVo.diamondNum;

  /// 获取金币奖励数量
  int get goldReward => rewardVo.goldNum;
}
