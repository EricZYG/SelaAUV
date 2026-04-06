/// 注销账号
///
/// 接口: /user/user/deleteUser
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
///   "timestamp": 1693470825013,
///   "data": null
/// }
/// ```
///
/// 请求示例:
/// ```dart
/// final result = await userService.deleteUser();
/// if (result.success) {
///   // 账号已注销，跳转到登录页
/// }
/// ```
