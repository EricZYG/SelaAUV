/// ShowDoc 通用响应模型
/// 
/// 所有接口返回数据都遵循此格式
class AuvBaseResponse<T> {
  /// 状态码
  /// 
  /// 0表示成功，其他值表示失败
  final int code;
  
  /// 响应消息
  /// 
  /// 服务器返回的提示信息，成功时通常为"Operation succeeded"
  final String message;
  
  /// 服务器时间戳
  /// 
  /// 服务器处理请求的时间戳（毫秒）
  final int timestamp;
  
  /// 响应数据
  /// 
  /// 接口返回的业务数据，类型由泛型T决定
  final T? data;

  AuvBaseResponse({
    required this.code,
    required this.message,
    required this.timestamp,
    this.data,
  });

  /// 判断请求是否成功
  /// 
  /// true表示code=0，请求成功
  bool get success => code == 0;

  /// 从JSON创建响应对象
  /// 
  /// [json] 服务器返回的JSON数据
  /// [fromJsonT] 数据字段的解析函数
  factory AuvBaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return AuvBaseResponse(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
    );
  }
}
