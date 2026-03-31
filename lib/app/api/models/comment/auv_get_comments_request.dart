import 'auv_comment_request.dart';

/// 获取动态评论请求模型
class AuvGetCommentsRequest {
  /// 页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  /// 查询条件
  final AuvQueryCommentConditionRequest condition;

  AuvGetCommentsRequest({
    required this.pageNum,
    required this.pageSize,
    required this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      'condition': condition.toJson(),
    };
  }
}
