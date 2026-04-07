/// S3上传链接响应模型
/// 
/// 对应接口: GET /system/app/getS3UploadUrlV2
/// 
/// 用于获取S3预签名上传URL
class AuvS3UploadUrlResponse {
  /// 上传用的链接
  /// 
  /// 用于上传文件到S3的预签名URL
  final String uploadUrl;

  /// 访问用的链接
  /// 
  /// 文件上传成功后，可通过此URL公开访问文件
  final String publicUrl;

  /// 文件相对路径
  /// 
  /// 文件在S3中的相对路径，可用于拼接完整URL
  final String filePath;

  AuvS3UploadUrlResponse({
    required this.uploadUrl,
    required this.publicUrl,
    required this.filePath,
  });

  factory AuvS3UploadUrlResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvS3UploadUrlResponse(
        uploadUrl: '',
        publicUrl: '',
        filePath: '',
      );
    }
    return AuvS3UploadUrlResponse(
      uploadUrl: json['uploadUrl'] ?? '',
      publicUrl: json['publicUrl'] ?? '',
      filePath: json['filePath'] ?? '',
    );
  }

  /// 从publicUrl提取文件名
  String get fileName {
    final parts = publicUrl.split('/');
    return parts.isNotEmpty ? parts.last : '';
  }

  /// 从filePath提取文件扩展名
  String get extension {
    final parts = filePath.split('.');
    return parts.length > 1 ? parts.last : '';
  }
}
