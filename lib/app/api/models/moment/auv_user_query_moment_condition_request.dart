/// 用户端查主播动态条件模型
class AuvUserQueryMomentConditionRequest {
  final int? queryType;
  final int? anchorUserId;
  final int? topMomentId;

  AuvUserQueryMomentConditionRequest({this.queryType, this.anchorUserId, this.topMomentId});

  Map<String, dynamic> toJson() => {
    if (queryType != null) 'queryType': queryType,
    if (anchorUserId != null) 'anchorUserId': anchorUserId,
    if (topMomentId != null) 'topMomentId': topMomentId,
  };
}
