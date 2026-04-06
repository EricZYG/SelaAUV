/// 举报/反馈
///
/// 接口: /user/feedback/save
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
///   "timestamp": 1701409293601,
///   "data": null
/// }
/// ```
///
/// 请求示例:
/// ```dart
/// final result = await userService.feedbackSave(
///   request: AuvFeedbackRequest(
///     type: AuvFeedbackType.report,
///     topicType: AuvFeedbackTopicType.abuse,
///     content: '该用户多次进行人身攻击',
///     anchorUserId: 12345,
///     linkId: 67890,
///     path: 'https://example.com/img1.jpg',
///   ),
/// );
/// ```
