/// 用户媒体信息模型
/// 
/// 表示用户的相册或视频资源
/// 
/// 字段说明:
/// - id: 相册ID
/// - sourceId: 待替换ID
/// - value: 相对路径
/// - videoCover: 视频封面相对路径(资源类型为视频时)
/// - status: 状态
/// - fingerPrint: 图片hash值
class AuvUserMediaInfoResponse {
  /// 相册ID
  final int? id;
  
  /// 待替换ID
  final int? sourceId;
  
  /// 相对路径
  final String? value;
  
  /// 视频封面相对路径(资源类型为视频时)
  final String? videoCover;
  
  /// 状态
  final int? status;
  
  /// 图片hash值
  final int? fingerPrint;

  AuvUserMediaInfoResponse({
    this.id,
    this.sourceId,
    this.value,
    this.videoCover,
    this.status,
    this.fingerPrint,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (sourceId != null) 'sourceId': sourceId,
      if (value != null) 'value': value,
      if (videoCover != null) 'videoCover': videoCover,
      if (status != null) 'status': status,
      if (fingerPrint != null) 'fingerPrint': fingerPrint,
    };
  }

  factory AuvUserMediaInfoResponse.fromJson(Map<String, dynamic> json) {
    return AuvUserMediaInfoResponse(
      id: json['id'],
      sourceId: json['sourceId'],
      value: json['value'],
      videoCover: json['videoCover'],
      status: json['status'],
      fingerPrint: json['fingerPrint'],
    );
  }
}