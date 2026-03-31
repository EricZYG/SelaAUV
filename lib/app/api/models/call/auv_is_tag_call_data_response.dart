import 'auv_call_tag_response.dart';

/// 通话是否可打标签响应数据模型
class AuvIsTagCallDataResponse {
  /// 是否可打标签
  /// 
  /// true表示该通话结束后可以打标签
  final bool? isTagCall;
  
  /// 标签列表
  /// 
  /// 可供选择的标签列表
  final List<AuvCallTagResponse>? tags;

  AuvIsTagCallDataResponse({
    this.isTagCall,
    this.tags,
  });

  factory AuvIsTagCallDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvIsTagCallDataResponse();
    return AuvIsTagCallDataResponse(
      isTagCall: json['isTagCall'],
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => AuvCallTagResponse.fromJson(e))
          .toList(),
    );
  }
}
