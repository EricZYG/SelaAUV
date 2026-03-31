/// 查询订单简要信息条件模型
class AuvGetOrderSimpleConditionRequest {
  /// 用户id
  final int userId;

  AuvGetOrderSimpleConditionRequest({
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}
