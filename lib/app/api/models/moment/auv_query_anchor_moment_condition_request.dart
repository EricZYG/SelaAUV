/// 主播端查其他主播动态条件模型
class AuvQueryAnchorMomentConditionRequest {
  final int? queryType;
  final int? anchorUserId;
  final int? topMomentId;

  AuvQueryAnchorMomentConditionRequest({this.queryType, this.anchorUserId, this.topMomentId});

  Map<String, dynamic> toJson() => {
    if (queryType != null) 'queryType': queryType,
    if (anchorUserId != null) 'anchorUserId': anchorUserId,
    if (topMomentId != null) 'topMomentId': topMomentId,
  };
}
