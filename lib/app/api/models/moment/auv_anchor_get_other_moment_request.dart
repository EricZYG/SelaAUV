import 'auv_query_anchor_moment_condition_request.dart';

/// 主播端查其他主播动态请求模型
class AuvAnchorGetOtherMomentRequest {
  final int pageNum;
  final int pageSize;
  final AuvQueryAnchorMomentConditionRequest? condition;

  AuvAnchorGetOtherMomentRequest({required this.pageNum, required this.pageSize, this.condition});

  Map<String, dynamic> toJson() => {
    'pageNum': pageNum,
    'pageSize': pageSize,
    if (condition != null) 'condition': condition!.toJson(),
  };
}
