/// 用户端-获取钻石/金币明细
library;

// API response data

///
/// 接口: /user/balance/getUserBalanceRecords
/// 请求方式: POST
/// 状态: success
/// code: 0
/// message: Operation succeeded
///
/// 实际API返回示例:
/// ```json
/// {
///   "code": 0,
///   "message": "Operation succeeded",
///   "timestamp": 1700204290322,
///   "data": {
///     "total": 1,
///     "list": [
///       {
///         "userId": 10001033,
///         "recordType": 301,
///         "recordTypeStr": "视频通话",
///         "action": 2,
///         "createTimes": 1700203761619,
///         "value": -10000
///       }
///     ],
///     "pageNum": 1,
///     "pageSize": 10,
///     "size": 1,
///     "startRow": 1,
///     "endRow": 1,
///     "pages": 1,
///     "prePage": 0,
///     "nextPage": 0,
///     "isFirstPage": true,
///     "isLastPage": true,
///     "hasPreviousPage": false,
///     "hasNextPage": false,
///     "navigatePages": 8,
///     "navigatepageNums": [1],
///     "navigateFirstPage": 1,
///     "navigateLastPage": 1
///   }
/// }
/// ```
///
/// 请求示例:
/// ```dart
/// final result = await userService.getUserBalanceRecords(
///   pageNum: 1,
///   pageSize: 10,
///   condition: AuvBalanceRecordCondition(
///     action: 2,
///     startTimes: 1631703224215,
///     endTimes: 1631703224215,
///   ),
/// );
/// ```
