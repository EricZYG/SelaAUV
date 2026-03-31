/// 查询动态条件模型
class AuvQueryMomentConditionRequest {
  final int? topMomentId;

  AuvQueryMomentConditionRequest({this.topMomentId});

  Map<String, dynamic> toJson() => {if (topMomentId != null) 'topMomentId': topMomentId};
}
