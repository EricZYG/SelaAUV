import 'auv_query_comment_condition_request.dart';

/// 获取动态评论请求模型
class AuvGetCommentsRequest {
  final int pageNum;
  final int pageSize;
  final AuvQueryCommentConditionRequest condition;

  AuvGetCommentsRequest({
    required this.pageNum,
    required this.pageSize,
    required this.condition,
  });

  Map<String, dynamic> toJson() => {
    'pageNum': pageNum,
    'pageSize': pageSize,
    'condition': condition.toJson(),
  };
}
