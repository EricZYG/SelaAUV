/// 修改动态可见范围请求模型
class AuvUpdateMomentVisibleRequest {
  final int momentId;
  final int visibleType;

  AuvUpdateMomentVisibleRequest({required this.momentId, required this.visibleType});

  Map<String, dynamic> toJson() => {'momentId': momentId, 'visibleType': visibleType};
}
