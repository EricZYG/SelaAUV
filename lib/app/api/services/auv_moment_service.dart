import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_showdoc_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 动态服务
/// 
/// 处理动态相关接口：发布动态、查看动态，管理动态等
class AuvMomentService extends AuvBaseService {
  /// 创建服务实例
  static AuvMomentService create() {
    final service = AuvMomentService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 发布动态
  /// 
  /// 发布新的动态内容，支持图片、视频等
  /// 
  /// [request] 发布动态请求参数（必填），包含动态内容、媒体文件等
  /// 
  /// 返回值: 发布成功的动态ID
  Future<AuvShowDocResponse<int>> publishMoment({
    required AuvPublishMomentRequest request,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.publishMoment,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<int>(
        response.data,
        (data) => data as int,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }

  /// 修改动态可见范围
  /// 
  /// 修改已发布动态的可见范围（公开/私密/仅粉丝）
  /// 
  /// [request] 更新可见范围请求参数（必填），包含动态ID和可见类型
  /// 
  /// 返回值: 空响应
  Future<AuvShowDocResponse<void>> updateMomentVisibleType({
    required AuvUpdateMomentVisibleRequest request,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.updateMomentVisibleType,
        data: request.toJson(),
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 主播端查自己动态
  /// 
  /// 主播查看自己发布的所有动态
  /// 
  /// [request] 查询请求参数（必填），包含分页信息等
  /// 
  /// 返回值: 我的动态列表数据响应
  Future<AuvShowDocResponse<AuvMyMomentListDataResponse>> getMyMoment({
    required AuvGetMyMomentRequest request,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.getMyMoment,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<AuvMyMomentListDataResponse>(
        response.data,
        (data) => AuvMyMomentListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvMyMomentListDataResponse>(e);
    }
  }

  /// 查单个主播动态
  /// 
  /// 查看指定动态的详细信息
  /// 
  /// [momentId] 动态ID（必填）
  /// 
  /// 返回值: 动态详情响应
  Future<AuvShowDocResponse<AuvMomentDetailResponse>> getOneMoment({
    required int momentId,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getOneMoment,
        queryParameters: {'momentId': momentId},
      );
      return handleResponse<AuvMomentDetailResponse>(
        response.data,
        (data) => AuvMomentDetailResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvMomentDetailResponse>(e);
    }
  }

  /// 关注主播是否有新的动态
  /// 
  /// 检查用户关注的主播是否有新发布的动态
  /// 
  /// 返回值: 新动态数量
  Future<AuvShowDocResponse<int>> hasNewFollowMoment() async {
    try {
      final response = await get(AuvShowDocRoutes.hasNewFollowMoment);
      return handleResponse<int>(
        response.data,
        (data) => data as int? ?? 0,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }
}
