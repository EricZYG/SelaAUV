import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_showdoc_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 直播间服务
/// 
/// 处理直播间相关接口：直播间列表、详情等
class AuvLiveRoomService extends AuvBaseService {
  /// 创建服务实例
  static AuvLiveRoomService create() {
    final service = AuvLiveRoomService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取直播间列表（分页）
  /// 
  /// 分页获取直播间列表，支持按分类或用户筛选
  /// 
  /// [page] 页码（可选），默认1
  /// [pageSize] 每页数量（可选），默认20
  /// [categoryId] 分类ID（可选），用于筛选特定分类的直播间
  /// [userId] 用户ID（可选），用于筛选特定用户创建的直播间
  /// 
  /// 返回值: 直播间列表数据响应
  Future<AuvShowDocResponse<AuvLiveRoomListDataResponse>> getLiveRoomList({
    int page = 1,
    int pageSize = 20,
    int? categoryId,
    int? userId,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.liveRoomList,
        data: {
          'page': page,
          'pageSize': pageSize,
          if (categoryId != null) 'categoryId': categoryId,
          if (userId != null) 'userId': userId,
        },
        needSign: false,
      );
      return handleResponse<AuvLiveRoomListDataResponse>(
        response.data,
        (data) => AuvLiveRoomListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLiveRoomListDataResponse>(e);
    }
  }

  /// 获取直播间详情
  /// 
  /// 获取指定直播间的详细信息
  /// 
  /// [roomId] 直播间ID（必填）
  /// 
  /// 返回值: 直播间详情响应
  Future<AuvShowDocResponse<AuvLiveRoomDetailResponse>> getLiveRoomDetail({
    required int roomId,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.liveRoomDetail,
        queryParameters: {'roomId': roomId},
      );
      return handleResponse<AuvLiveRoomDetailResponse>(
        response.data,
        (data) => AuvLiveRoomDetailResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLiveRoomDetailResponse>(e);
    }
  }
}
