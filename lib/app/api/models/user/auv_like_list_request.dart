/// 喜欢列表请求模型
class AuvLikeListRequest {
  final int type;

  AuvLikeListRequest({required this.type});

  Map<String, dynamic> toJson() => {'type': type};
}
