/// 余额明细记录类型枚举
enum AuvBalanceRecordAction {
  income(1, '收入'),
  expense(2, '支出');

  final int value;
  final String label;
  const AuvBalanceRecordAction(this.value, this.label);

  static AuvBalanceRecordAction? fromValue(int value) {
    return AuvBalanceRecordAction.values
        .where((e) => e.value == value)
        .firstOrNull;
  }
}

/// 余额明细记录类型枚举（业务类型）
/// 
/// 用于区分不同的收入/支出来源
enum AuvBalanceRecordType {
  // 101-199: 游戏相关
  gameRecharge(101, '游戏充值'),
  withdrawal(102, '提现'),
  
  // 201-299: 充值相关
  recharge(201, '充值'),
  
  // 301-399: 消费相关
  videoCall(301, '视频通话'),
  voiceCall(302, '语音通话'),
  privateMessage(303, '私信消息'),
  gift(304, '礼物'),
  game(305, '游戏'),
  
  // 401-499: 奖励相关
  taskReward(401, '任务奖励'),
  signInReward(402, '签到奖励'),
  inviteReward(403, '邀请奖励'),
  exchange(404, '兑换');

  final int value;
  final String label;
  const AuvBalanceRecordType(this.value, this.label);

  static AuvBalanceRecordType? fromValue(int value) {
    return AuvBalanceRecordType.values
        .where((e) => e.value == value)
        .firstOrNull;
  }
}

/// 余额明细记录
/// 
/// 表示用户的单条钻石/金币变动记录
/// 
/// 示例数据:
/// ```json
/// {
///   "userId": 10208982,
///   "recordType": 301,
///   "recordTypeStr": "视频通话",
///   "action": 2,
///   "createTimes": 1774844271711,
///   "value": -100
/// }
/// ```
class AuvBalanceRecord {
  /// 用户ID
  /// 类型: long
  final int userId;

  /// 消费代码类型
  /// 类型: int
  /// 说明: 101-199游戏相关, 201-299充值相关, 301-399消费相关, 401-499奖励相关
  /// 参考: AuvBalanceRecordType
  final int recordType;

  /// 类型描述
  /// 类型: string
  /// 说明: 消费类型的文字描述，如"视频通话"、"充值"等
  final String recordTypeStr;

  /// 变动类型
  /// 类型: int
  /// 说明: 1.收入，2.支出
  final int action;

  /// 时间戳
  /// 类型: long
  /// 说明: 记录创建时间的毫秒时间戳
  final int createTimes;

  /// 变动值
  /// 类型: long
  /// 说明: 变动值，正数表示收入，负数表示支出（实际值，非分）
  final int value;

  AuvBalanceRecord({
    required this.userId,
    required this.recordType,
    required this.recordTypeStr,
    required this.action,
    required this.createTimes,
    required this.value,
  });

  /// 是否为收入
  bool get isIncome => action == AuvBalanceRecordAction.income.value;

  /// 是否为支出
  bool get isExpense => action == AuvBalanceRecordAction.expense.value;

  /// 获取变动类型枚举
  AuvBalanceRecordAction? get actionType => AuvBalanceRecordAction.fromValue(action);

  /// 获取业务类型枚举
  AuvBalanceRecordType? get type => AuvBalanceRecordType.fromValue(recordType);

  /// 获取变动类型描述
  String get actionLabel => actionType?.label ?? '未知';

  /// 获取业务类型描述
  String get typeLabel => type?.label ?? recordTypeStr;

  /// 获取带符号的金额
  String get signedAmount {
    final prefix = value >= 0 ? '+' : '';
    return '$prefix$value';
  }

  /// 获取记录时间
  DateTime? get recordTime {
    if (createTimes <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createTimes);
  }

  factory AuvBalanceRecord.fromJson(Map<String, dynamic> json) {
    return AuvBalanceRecord(
      userId: json['userId'] ?? 0,
      recordType: json['recordType'] ?? 0,
      recordTypeStr: json['recordTypeStr'] ?? '',
      action: json['action'] ?? 0,
      createTimes: json['createTimes'] ?? 0,
      value: json['value'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'recordType': recordType,
      'recordTypeStr': recordTypeStr,
      'action': action,
      'createTimes': createTimes,
      'value': value,
    };
  }
}

/// 余额明细查询条件
/// 
/// 用于筛选余额明细记录的条件
class AuvBalanceRecordCondition {
  /// 变动类型
  /// 类型: int?
  /// 说明: 1.收入，2.支出，不传表示全部
  final int? action;

  /// 开始时间
  /// 类型: long?
  /// 说明: 开始时间的毫秒时间戳，不传表示不限制
  final int? startTimes;

  /// 结束时间
  /// 类型: long?
  /// 说明: 结束时间的毫秒时间戳，不传表示不限制
  final int? endTimes;

  /// 是否查看游戏明细
  /// 类型: bool
  /// 说明: true查看游戏明细，false或不传查看全部
  final bool isGame;

  AuvBalanceRecordCondition({
    this.action,
    this.startTimes,
    this.endTimes,
    this.isGame = false,
  });

  Map<String, dynamic> toJson() {
    return {
      if (action != null) 'action': action,
      if (startTimes != null) 'startTimes': startTimes,
      if (endTimes != null) 'endTimes': endTimes,
      'isGame': isGame,
    };
  }

  /// 是否为空条件（未设置任何筛选条件）
  bool get isEmpty =>
      action == null && startTimes == null && endTimes == null && !isGame;
}

/// 余额明细分页请求
/// 
/// 用于分页查询余额明细记录
class AuvBalanceRecordRequest {
  /// 查询条件
  final AuvBalanceRecordCondition condition;

  /// 页码
  final int pageNum;

  /// 每页数量
  final int pageSize;

  AuvBalanceRecordRequest({
    required this.condition,
    required this.pageNum,
    required this.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'condition': condition.toJson(),
      'pageNum': pageNum,
      'pageSize': pageSize,
    };
  }
}

/// 余额明细分页响应
/// 
/// 余额明细分页查询返回的完整数据
/// 
/// 响应示例:
/// ```json
/// {
///   "total": 100,
///   "list": [...],
///   "pageNum": 1,
///   "pageSize": 10,
///   "size": 10,
///   "pages": 10,
///   "hasNextPage": true
/// }
/// ```
class AuvBalanceRecordPageResponse {
  /// 记录列表
  /// 类型: List<AuvBalanceRecord>
  /// 说明: 余额明细记录列表
  final List<AuvBalanceRecord> list;

  /// 总记录数
  /// 类型: int
  /// 说明: 符合条件的总记录数
  final int total;

  /// 当前页码
  /// 类型: int
  /// 说明: 当前查询的页码（从1开始）
  final int pageNum;

  /// 每页数量
  /// 类型: int
  /// 说明: 每页返回的记录数量
  final int pageSize;

  /// 当前页记录数
  /// 类型: int
  /// 说明: 当前页实际返回的记录数量
  final int size;

  /// 总页数
  /// 类型: int
  /// 说明: 总页数
  final int pages;

  /// 当前页起始行
  /// 类型: int
  final int startRow;

  /// 当前页结束行
  /// 类型: int
  final int endRow;

  /// 上一页页码
  /// 类型: int
  final int prePage;

  /// 下一页页码
  /// 类型: int
  final int nextPage;

  /// 是否第一页
  /// 类型: bool
  final bool isFirstPage;

  /// 是否最后一页
  /// 类型: bool
  final bool isLastPage;

  /// 是否存在上一页
  /// 类型: bool
  final bool hasPreviousPage;

  /// 是否存在下一页
  /// 类型: bool
  final bool hasNextPage;

  /// 导航页码数
  /// 类型: int
  final int navigatePages;

  /// 导航页码数组
  /// 类型: List<int>?
  /// 说明: 所有导航页的页码列表
  final List<int>? navigatepageNums;

  /// 导航首页码
  /// 类型: int
  final int navigateFirstPage;

  /// 导航末页码
  /// 类型: int
  final int navigateLastPage;

  AuvBalanceRecordPageResponse({
    required this.list,
    required this.total,
    required this.pageNum,
    required this.pageSize,
    required this.size,
    required this.pages,
    this.startRow = 0,
    this.endRow = 0,
    this.prePage = 0,
    this.nextPage = 0,
    this.isFirstPage = false,
    this.isLastPage = false,
    this.hasPreviousPage = false,
    this.hasNextPage = false,
    this.navigatePages = 0,
    this.navigatepageNums,
    this.navigateFirstPage = 0,
    this.navigateLastPage = 0,
  });

  /// 是否有更多数据
  bool get hasMore => pageNum < pages;

  /// 是否有数据
  bool get isEmpty => list.isEmpty;

  factory AuvBalanceRecordPageResponse.fromJson(Map<String, dynamic> json) {
    final listData = json['list'] ?? [];
    return AuvBalanceRecordPageResponse(
      list: (listData as List).map((e) => AuvBalanceRecord.fromJson(e)).toList(),
      total: json['total'] ?? 0,
      pageNum: json['pageNum'] ?? 1,
      pageSize: json['pageSize'] ?? 20,
      size: json['size'] ?? 0,
      pages: json['pages'] ?? 1,
      startRow: json['startRow'] ?? 0,
      endRow: json['endRow'] ?? 0,
      prePage: json['prePage'] ?? 0,
      nextPage: json['nextPage'] ?? 0,
      isFirstPage: json['isFirstPage'] ?? false,
      isLastPage: json['isLastPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      hasNextPage: json['hasNextPage'] ?? false,
      navigatePages: json['navigatePages'] ?? 0,
      navigatepageNums: json['navigatepageNums'] != null
          ? List<int>.from(json['navigatepageNums'])
          : null,
      navigateFirstPage: json['navigateFirstPage'] ?? 0,
      navigateLastPage: json['navigateLastPage'] ?? 0,
    );
  }
}

/// 余额信息
/// 
/// 表示用户的各种余额
class BalanceInfo {
  /// 钻石余额
  /// 类型: int
  /// 说明: 用户当前剩余钻石数（单位：个，非分）
  final int diamond;

  /// 金币余额
  /// 类型: int
  /// 说明: 用户当前剩余金币数（单位：个，非分）
  final int goldCoin;

  /// 公会金币余额
  /// 类型: int
  /// 说明: 用户当前剩余公会金币数（单位：个，非分）
  final int guildCoin;

  BalanceInfo({
    required this.diamond,
    required this.goldCoin,
    required this.guildCoin,
  });

  factory BalanceInfo.fromJson(Map<String, dynamic> json) {
    return BalanceInfo(
      diamond: json['diamond'] ?? json['diamond_balance'] ?? 0,
      goldCoin: json['gold_coin'] ?? json['goldCoin'] ?? 0,
      guildCoin: json['guild_coin'] ?? json['guildCoin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diamond': diamond,
      'gold_coin': goldCoin,
      'guild_coin': guildCoin,
    };
  }
}
