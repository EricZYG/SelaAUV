/// 用户在线状态枚举
enum AuvUserOnlineStatus {
  offline(0, '离线'),
  online(1, '在线'),
  busy(2, '忙线');

  final int value;
  final String label;
  const AuvUserOnlineStatus(this.value, this.label);

  static AuvUserOnlineStatus fromValue(int value) {
    return AuvUserOnlineStatus.values
        .where((e) => e.value == value)
        .firstOrNull ?? AuvUserOnlineStatus.offline;
  }
}

/// 关注状态枚举
enum AuvFollowStatus {
  unknown(0, '未知'),
  notFollowed(1, '未关注'),
  followed(2, '已关注'),
  friends(3, '好友');

  final int value;
  final String label;
  const AuvFollowStatus(this.value, this.label);

  static AuvFollowStatus fromValue(int value) {
    return AuvFollowStatus.values
        .where((e) => e.value == value)
        .firstOrNull ?? AuvFollowStatus.unknown;
  }
}

/// 喜欢状态枚举
enum AuvLikeStatus {
  unknown(0, '未知'),
  notLiked(1, '未喜欢'),
  liked(2, '已喜欢');

  final int value;
  final String label;
  const AuvLikeStatus(this.value, this.label);

  static AuvLikeStatus fromValue(int value) {
    return AuvLikeStatus.values
        .where((e) => e.value == value)
        .firstOrNull ?? AuvLikeStatus.unknown;
  }
}

/// 主播认证状态枚举
enum AuvAnchorAuthStatus {
  maleUser(0, '男用户'),
  pending(1, '待认证主播'),
  certified(2, '已认证主播'),
  rejected(3, '认证失败主播'),
  violated(4, '违规主播');

  final int value;
  final String label;
  const AuvAnchorAuthStatus(this.value, this.label);

  static AuvAnchorAuthStatus fromValue(int value) {
    return AuvAnchorAuthStatus.values
        .where((e) => e.value == value)
        .firstOrNull ?? AuvAnchorAuthStatus.maleUser;
  }
}
