/// 设置用户广告归因
///
/// 接口: /user/user/updateAdFlag
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
///   "timestamp": 1693826271387,
///   "data": null
/// }
/// ```
///
/// 请求示例:
/// ```dart
/// final result = await userService.updateAdFlag(
///   network: 'google',
///   campaign: 'summer_promo',
///   adid: 'abc123',
/// );
/// ```
