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
