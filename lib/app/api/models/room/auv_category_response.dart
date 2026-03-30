/// 分类模型
/// 
/// 表示礼物或主播的分类
/// 
/// 字段说明:
/// - categoryId: 分类ID
/// - categoryName: 分类名称
/// - icon: 分类图标
/// - sort: 排序序号
class AuvCategoryResponse {
  /// 分类ID
  final int? categoryId;
  
  /// 分类名称
  final String? categoryName;
  
  /// 分类图标
  final String? icon;
  
  /// 排序序号
  final int? sort;

  AuvCategoryResponse({
    this.categoryId,
    this.categoryName,
    this.icon,
    this.sort,
  });

  factory AuvCategoryResponse.fromJson(Map<String, dynamic> json) {
    return AuvCategoryResponse(
      categoryId: json['category_id'] ?? json['categoryId'],
      categoryName: json['category_name'] ?? json['categoryName'],
      icon: json['icon'],
      sort: json['sort'],
    );
  }
}