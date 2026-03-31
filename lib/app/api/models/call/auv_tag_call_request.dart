/// 通话打标签请求模型
/// 
/// 通话结束后给主播打标签时提交的数据
class AuvTagCallRequest {
  /// 通话频道id
  /// 
  /// 通话频道的唯一标识符
  final int channelId;
  
  /// 标签ID
  /// 
  /// 要打的标签的唯一标识符
  final int tagId;

  AuvTagCallRequest({
    required this.channelId,
    required this.tagId,
  });

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'tagId': tagId,
    };
  }
}
