/// 用户钻石/金币明细查询条件模型
///
/// 对应接口: /user/balance/getUserBalanceRecords
///
/// 字段说明:
/// - action: 变动类型，1.收入，2.支出
/// - startTimes: 开始时间毫秒时间戳
/// - endTimes: 结束时间毫秒时间戳
/// - isGame: true 是否查看游戏明细
class AuvBalanceRecordCondition {
  /// 变动类型，1.收入，2.支出
  final int? action;

  /// 开始时间毫秒时间戳
  final int? startTimes;

  /// 结束时间毫秒时间戳
  final int? endTimes;

  /// 是否查看游戏明细
  final bool? isGame;

  AuvBalanceRecordCondition({
    this.action,
    this.startTimes,
    this.endTimes,
    this.isGame,
  });

  Map<String, dynamic> toJson() {
    return {
      if (action != null) 'action': action,
      if (startTimes != null) 'startTimes': startTimes,
      if (endTimes != null) 'endTimes': endTimes,
      if (isGame != null) 'isGame': isGame,
    };
  }
}

/// 用户钻石/金币明细记录项模型
///
/// 实际API返回示例:
/// ```json
/// {
///   "userId": 10001033,
///   "recordType": 301,
///   "recordTypeStr": "视频通话",
///   "action": 2,
///   "createTimes": 1700203761619,
///   "value": -10000
/// }
/// ```
///
/// 字段说明:
/// - userId: 用户id
/// - recordType: 消费代码
/// - recordTypeStr: 类型描述
/// - action: 变动类型，1.收入，2.支出
/// - createTimes: 时间戳
/// - value: 钻石数or金币数（负数表示支出）
class AuvBalanceRecordItem {
  /// 用户id
  final int? userId;

  /// 消费代码
  /// BalanceRecordType 枚举值
  final int? recordType;

  /// 类型描述
  final String? recordTypeStr;

  /// 变动类型，1.收入，2.支出
  final int? action;

  /// 时间戳
  final int? createTimes;

  /// 钻石数or金币数（负数表示支出）
  final int? value;

  AuvBalanceRecordItem({
    this.userId,
    this.recordType,
    this.recordTypeStr,
    this.action,
    this.createTimes,
    this.value,
  });

  factory AuvBalanceRecordItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvBalanceRecordItem();
    return AuvBalanceRecordItem(
      userId: json['userId'],
      recordType: json['recordType'],
      recordTypeStr: json['recordTypeStr'],
      action: json['action'],
      createTimes: json['createTimes'],
      value: json['value'],
    );
  }

  /// 是否收入
  bool get isIncome => action == 1;

  /// 是否支出
  bool get isExpense => action == 2;

  /// 获取变动时间
  DateTime? get createTime {
    if (createTimes == null || createTimes == 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createTimes!);
  }
}

/// 用户钻石/金币明细分页响应模型
///
/// 对应接口: /user/balance/getUserBalanceRecords
class AuvBalanceRecordDataResponse {
  /// 总记录数
  final int? total;

  /// 记录列表
  final List<AuvBalanceRecordItem>? list;

  /// 当前页码
  final int? pageNum;

  /// 每页条数
  final int? pageSize;

  /// 当前页记录数
  final int? size;

  /// 起始行号
  final int? startRow;

  /// 结束行号
  final int? endRow;

  /// 总页数
  final int? pages;

  /// 是否有上一页
  final bool? hasPreviousPage;

  /// 是否有下一页
  final bool? hasNextPage;

  /// 是否第一页
  final bool? isFirstPage;

  /// 是否最后一页
  final bool? isLastPage;

  AuvBalanceRecordDataResponse({
    this.total,
    this.list,
    this.pageNum,
    this.pageSize,
    this.size,
    this.startRow,
    this.endRow,
    this.pages,
    this.hasPreviousPage,
    this.hasNextPage,
    this.isFirstPage,
    this.isLastPage,
  });

  factory AuvBalanceRecordDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvBalanceRecordDataResponse();
    return AuvBalanceRecordDataResponse(
      total: json['total'],
      list: (json['list'] as List?)
          ?.map((e) => AuvBalanceRecordItem.fromJson(e))
          .toList(),
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      size: json['size'],
      startRow: json['startRow'],
      endRow: json['endRow'],
      pages: json['pages'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      isFirstPage: json['isFirstPage'],
      isLastPage: json['isLastPage'],
    );
  }
}
