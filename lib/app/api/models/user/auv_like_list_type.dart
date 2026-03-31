/// 喜欢列表类型枚举
enum AuvLikeListType {
  like(1),
  likedMe(2);

  final int value;
  const AuvLikeListType(this.value);

  static AuvLikeListType fromValue(int value) {
    return AuvLikeListType.values.firstWhere((e) => e.value == value, orElse: () => AuvLikeListType.likedMe);
  }
}
