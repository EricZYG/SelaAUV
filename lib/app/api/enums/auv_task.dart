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
