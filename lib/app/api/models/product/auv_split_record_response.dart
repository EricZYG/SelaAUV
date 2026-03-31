/// 分次领取状态枚举
enum AuvSplitStatus {
  locked(-1, '未解锁'),
  pending(0, '待领取'),
  claimed(1, '已领取'),
  expired(2, '已过期');

  const AuvSplitStatus(this.value, this.description);
  final int value;
  final String description;

  static AuvSplitStatus fromValue(int value) {
    return AuvSplitStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuvSplitStatus.pending,
    );
  }
}

/// 分次领取记录模型
class AuvSplitRecordResponse {
  /// 第几天
  final int? splitDay;

  /// 解锁时间（时间戳）
  final int? beginTime;

  /// 状态
  /// -1.未解锁
  /// 0.待领取
  /// 1.已领取
  /// 2.已过期
  final int? splitStatus;

  /// 钻石数（小数点后两位）
  final int? diamonds;

  AuvSplitRecordResponse({
    this.splitDay,
    this.beginTime,
    this.splitStatus,
    this.diamonds,
  });

  factory AuvSplitRecordResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvSplitRecordResponse();
    return AuvSplitRecordResponse(
      splitDay: json['splitDay'],
      beginTime: json['beginTime'],
      splitStatus: json['splitStatus'],
      diamonds: json['diamonds'],
    );
  }

  /// 获取状态枚举
  AuvSplitStatus get status => AuvSplitStatus.fromValue(splitStatus ?? 0);

  /// 是否可领取
  bool get canClaim => splitStatus == AuvSplitStatus.pending.value;

  /// 获取解锁时间描述
  String get unlockTimeDesc {
    if (beginTime == null || beginTime! <= 0) return '已解锁';
    final unlockDate = DateTime.fromMillisecondsSinceEpoch(beginTime!);
    final now = DateTime.now();
    if (unlockDate.isBefore(now)) {
      return '已解锁';
    }
    final diff = unlockDate.difference(now);
    if (diff.inDays > 0) {
      return '${diff.inDays}天后解锁';
    }
    if (diff.inHours > 0) {
      return '${diff.inHours}小时后解锁';
    }
    if (diff.inMinutes > 0) {
      return '${diff.inMinutes}分钟后解锁';
    }
    return '${diff.inSeconds}秒后解锁';
  }

  /// 获取钻石显示
  String get diamondsDisplay {
    if (diamonds == null) return '0';
    return (diamonds! / 100).toStringAsFixed(0);
  }
}
