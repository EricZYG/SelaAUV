import 'auv_user_query_moment_condition_request.dart';

/// 用户端查主播动态请求模型
class AuvUserGetMomentRequest {
  final int pageNum;
  final int pageSize;
  final AuvUserQueryMomentConditionRequest? condition;

  AuvUserGetMomentRequest({required this.pageNum, required this.pageSize, this.condition});

  Map<String, dynamic> toJson() => {
    'pageNum': pageNum,
    'pageSize': pageSize,
    if (condition != null) 'condition': condition!.toJson(),
  };
}
