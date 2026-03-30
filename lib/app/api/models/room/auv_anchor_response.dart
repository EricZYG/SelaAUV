/// 主播模型
/// 
/// 表示主播信息
/// 
/// 字段说明:
/// - anchorId: 主播ID
/// - anchorName: 主播名称
/// - avatar: 主播头像
/// - coverUrl: 封面图
/// - categoryId: 所属分类ID
/// - categoryName: 所属分类名称
/// - followerCount: 粉丝数
/// - liveCount: 直播场次
/// - status: 状态 (1:在线, 2:离线)
class AuvAnchorResponse {
  /// 主播ID
  final int? anchorId;
  
  /// 主播名称
  final String? anchorName;
  
  /// 主播头像
  final String? avatar;
  
  /// 封面图
  final String? coverUrl;
  
  /// 所属分类ID
  final int? categoryId;
  
  /// 所属分类名称
  final String? categoryName;
  
  /// 粉丝数
  final int? followerCount;
  
  /// 直播场次
  final int? liveCount;
  
  /// 状态
  /// 1: 在线
  /// 2: 离线
  final int? status;

  AuvAnchorResponse({
    this.anchorId,
    this.anchorName,
    this.avatar,
    this.coverUrl,
    this.categoryId,
    this.categoryName,
    this.followerCount,
    this.liveCount,
    this.status,
  });

  factory AuvAnchorResponse.fromJson(Map<String, dynamic> json) {
    return AuvAnchorResponse(
      anchorId: json['anchor_id'] ?? json['anchorId'],
      anchorName: json['anchor_name'] ?? json['anchorName'],
      avatar: json['avatar'],
      coverUrl: json['cover_url'] ?? json['coverUrl'],
      categoryId: json['category_id'] ?? json['categoryId'],
      categoryName: json['category_name'] ?? json['categoryName'],
      followerCount: json['follower_count'] ?? json['followerCount'],
      liveCount: json['live_count'] ?? json['liveCount'],
      status: json['status'],
    );
  }
}