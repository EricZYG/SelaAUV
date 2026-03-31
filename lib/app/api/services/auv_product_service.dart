import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_net_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 商品服务
/// 
/// 处理商品相关接口：礼物列表等
class AuvProductService extends AuvBaseService {
  /// 创建服务实例
  static AuvProductService create() {
    final service = AuvProductService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取礼物列表
  /// 
  /// 分页获取礼物列表，支持按分类筛选
  /// 
  /// [categoryId] 分类ID（可选），不传则返回全部
  /// [page] 页码（可选），默认1
  /// [pageSize] 每页数量（可选），默认20
  /// 
  /// 返回值: 礼物列表
  Future<AuvBaseResponse<List<AuvGiftResponse>>> getGiftList({
    String? categoryId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.giftList,
        queryParameters: {
          if (categoryId != null) 'category_id': categoryId,
          'page': page,
          'page_size': pageSize,
        },
      );
      return handleListResponse<AuvGiftResponse>(
        response.data,
        (data) => AuvGiftResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvGiftResponse>>(e);
    }
  }

  /// 获取分类列表
  /// 
  /// 获取礼物分类列表
  /// 
  /// 返回值: 分类列表
  Future<AuvBaseResponse<List<AuvCategoryResponse>>> getCategoryList() async {
    try {
      final response = await get(AuvNetRoutes.categoryList);
      return handleListResponse<AuvCategoryResponse>(
        response.data,
        (data) => AuvCategoryResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvCategoryResponse>>(e);
    }
  }
}
