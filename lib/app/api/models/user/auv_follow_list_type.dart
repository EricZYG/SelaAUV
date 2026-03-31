/// 关注列表类型枚举
enum AuvFollowListType {
  friend(1),
  friendRequest(2),
  following(3);

  final int value;
  const AuvFollowListType(this.value);

  static AuvFollowListType fromValue(int value) {
    return AuvFollowListType.values.firstWhere((e) => e.value == value, orElse: () => AuvFollowListType.friend);
  }
}
