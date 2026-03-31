/// 更新喜欢状态请求模型
class AuvUpdateLikeStatRequest {
  final List<int> likeMeUserIds;
  final int stat;

  AuvUpdateLikeStatRequest({required this.likeMeUserIds, required this.stat});

  Map<String, dynamic> toJson() => {'likeMeUserIds': likeMeUserIds, 'stat': stat};
}
