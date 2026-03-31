import 'auv_query_moment_condition_request.dart';

/// 主播端查自己动态请求模型
class AuvGetMyMomentRequest {
  final int pageNum;
  final int pageSize;
  final AuvQueryMomentConditionRequest? condition;

  AuvGetMyMomentRequest({required this.pageNum, required this.pageSize, this.condition});

  Map<String, dynamic> toJson() => {
    'pageNum': pageNum,
    'pageSize': pageSize,
    if (condition != null) 'condition': condition!.toJson(),
  };
}
