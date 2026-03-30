/// 通话标签模型
///
/// 表示可打的通话标签信息
class AuvCallTagResponse {
  /// 标签id
  final String? id;

  /// 分类id
  final int? classifyId;

  /// 分类名
  final String? title;

  /// 标签值
  final String? tagValue;

  /// 标签类型
  final int? tagType;

  /// 标签图片
  final String? tagImg;

  AuvCallTagResponse({
    this.id,
    this.classifyId,
    this.title,
    this.tagValue,
    this.tagType,
    this.tagImg,
  });

  factory AuvCallTagResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCallTagResponse();
    return AuvCallTagResponse(
      id: json['id']?.toString(),
      classifyId: json['classifyId'],
      title: json['title'],
      tagValue: json['tagValue'],
      tagType: json['tagType'],
      tagImg: json['tagImg'],
    );
  }
}

/// 通话是否可打标签响应数据模型
class AuvIsTagCallDataResponse {
  /// 是否可打标签
  final bool? isTagCall;

  /// 标签列表
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