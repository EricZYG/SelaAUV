/// 关注列表请求模型
class AuvFollowListRequest {
  final int type;

  AuvFollowListRequest({required this.type});

  Map<String, dynamic> toJson() => {'type': type};
}
