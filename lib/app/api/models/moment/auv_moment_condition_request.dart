/// 查询动态条件模型
///
/// 主播端查自己动态接口的查询条件
///
/// 字段说明:
/// - topMomentId: 要置顶的动态id，从动态通知跳转的时候传
class AuvQueryMomentConditionRequest {
  /// 要置顶的动态id
  final int? topMomentId;

  AuvQueryMomentConditionRequest({
    this.topMomentId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (topMomentId != null) 'topMomentId': topMomentId,
    };
  }
}

/// 主播端查其他主播动态条件模型
///
/// 字段说明:
/// - queryType: 查询类型 1.hot 2.new
/// - anchorUserId: 查询单个主播id
/// - topMomentId: 要置顶的动态id
class AuvQueryAnchorMomentConditionRequest {
  /// 查询类型 1.hot 2.new
  final int? queryType;

  /// 查询单个主播id
  final int? anchorUserId;

  /// 要置顶的动态id
  final int? topMomentId;

  AuvQueryAnchorMomentConditionRequest({
    this.queryType,
    this.anchorUserId,
    this.topMomentId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (queryType != null) 'queryType': queryType,
      if (anchorUserId != null) 'anchorUserId': anchorUserId,
      if (topMomentId != null) 'topMomentId': topMomentId,
    };
  }
}

/// 用户端查主播动态条件模型
///
/// 字段说明:
/// - queryType: 查询类型 1.hot 2.new 3.follow
/// - anchorUserId: 查询单个主播id
/// - topMomentId: 要置顶的动态id
class AuvUserQueryMomentConditionRequest {
  /// 查询类型 1.hot 2.new 3.follow
  final int? queryType;

  /// 查询单个主播id
  final int? anchorUserId;

  /// 要置顶的动态id
  final int? topMomentId;

  AuvUserQueryMomentConditionRequest({
    this.queryType,
    this.anchorUserId,
    this.topMomentId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (queryType != null) 'queryType': queryType,
      if (anchorUserId != null) 'anchorUserId': anchorUserId,
      if (topMomentId != null) 'topMomentId': topMomentId,
    };
  }
}

/// 主播端查自己动态请求模型
class AuvGetMyMomentRequest {
  /// 页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  /// 查询条件
  final AuvQueryMomentConditionRequest? condition;

  AuvGetMyMomentRequest({
    required this.pageNum,
    required this.pageSize,
    this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      if (condition != null) 'condition': condition!.toJson(),
    };
  }
}

/// 主播端查其他主播动态请求模型
class AuvAnchorGetOtherMomentRequest {
  /// 页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  /// 查询条件
  final AuvQueryAnchorMomentConditionRequest? condition;

  AuvAnchorGetOtherMomentRequest({
    required this.pageNum,
    required this.pageSize,
    this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      if (condition != null) 'condition': condition!.toJson(),
    };
  }
}

/// 用户端查主播动态请求模型
class AuvUserGetMomentRequest {
  /// 页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  /// 查询条件
  final AuvUserQueryMomentConditionRequest? condition;

  AuvUserGetMomentRequest({
    required this.pageNum,
    required this.pageSize,
    this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      if (condition != null) 'condition': condition!.toJson(),
    };
  }
}