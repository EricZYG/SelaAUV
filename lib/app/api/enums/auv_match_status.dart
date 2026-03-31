/// 匹配状态枚举
enum AuvMatchStatus {
  pending, // 待接受
  accepted, // 已接受
  rejected, // 已拒绝
  completed, // 已完成
  cancelled, // 已取消
  expired, // 已过期
}
