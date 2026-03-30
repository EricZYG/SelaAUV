/// ShowDoc 通用响应模型
/// 
/// 所有接口返回数据都遵循此格式
/// 
/// 字段说明:
/// - code: 状态码, 0表示成功, 其他值表示失败
/// - message: 响应消息, 成功时通常为"Operation succeeded"
/// - timestamp: 服务器时间戳(毫秒)
/// - data: 响应数据, 类型由泛型T决定
class AuvShowDocResponse<T> {
  /// 状态码, 0表示成功
  final int code;
  
  /// 响应消息
  final String message;
  
  /// 服务器时间戳(毫秒)
  final int timestamp;
  
  /// 响应数据
  final T? data;

  AuvShowDocResponse({
    required this.code,
    required this.message,
    required this.timestamp,
    this.data,
  });

  /// 判断请求是否成功
  bool get success => code == 0;

  /// 从JSON创建响应对象
  /// [json] 服务器返回的JSON数据
  /// [fromJsonT] 数据字段的解析函数
  factory AuvShowDocResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return AuvShowDocResponse(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
    );
  }
}
