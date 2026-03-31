import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_net_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 主播服务
/// 
/// 处理主播相关接口：主播列表、动态、评论等
class AuvAnchorService extends AuvBaseService {
  /// 创建服务实例
  static AuvAnchorService create() {
    final service = AuvAnchorService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取主播列表
  /// 
  /// 分页获取主播列表，支持按分类筛选
  /// 
  /// [categoryId] 分类ID（可选），不传则返回全部
  /// [page] 页码（可选），默认1
  /// [pageSize] 每页数量（可选），默认20
  /// 
  /// 返回值: 主播列表
  Future<AuvBaseResponse<List<AuvAnchorResponse>>> getAnchorList({
    String? categoryId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.anchorList,
        queryParameters: {
          if (categoryId != null) 'category_id': categoryId,
          'page': page,
          'page_size': pageSize,
        },
      );
      return handleListResponse<AuvAnchorResponse>(
        response.data,
        (data) => AuvAnchorResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvAnchorResponse>>(e);
    }
  }

  /// 获取主播详情
  /// 
  /// 获取指定主播的详细信息
  /// 
  /// [anchorId] 主播ID（必填）
  /// 
  /// 返回值: 主播详情响应
  Future<AuvBaseResponse<AuvAnchorResponse>> getAnchorDetail({
    required String anchorId,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.anchorDetail,
        queryParameters: {'anchor_id': anchorId},
      );
      return handleResponse<AuvAnchorResponse>(
        response.data,
        (data) => AuvAnchorResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvAnchorResponse>(e);
    }
  }

  /// 主播端查其他主播动态
  /// 
  /// 主播查看其他主播发布的动态列表
  /// 
  /// [request] 查询请求参数（必填），包含主播ID等信息
  /// 
  /// 返回值: 主播动态列表数据响应
  Future<AuvBaseResponse<AuvAnchorMomentListDataResponse>> anchorGetOtherMoment({
    required AuvAnchorGetOtherMomentRequest request,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.anchorGetOtherMoment,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<AuvAnchorMomentListDataResponse>(
        response.data,
        (data) => AuvAnchorMomentListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvAnchorMomentListDataResponse>(e);
    }
  }

  /// 用户端查主播动态
  /// 
  /// 用户查看主播发布的动态列表
  /// 
  /// [request] 查询请求参数（必填），包含主播ID等信息
  /// 
  /// 返回值: 用户端主播动态列表数据响应
  Future<AuvBaseResponse<AuvUserMomentListDataResponse>> userGetMoment({
    required AuvUserGetMomentRequest request,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.userGetMoment,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<AuvUserMomentListDataResponse>(
        response.data,
        (data) => AuvUserMomentListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserMomentListDataResponse>(e);
    }
  }

  /// 获取动态评论
  /// 
  /// 获取指定动态的评论列表
  /// 
  /// [request] 评论查询请求参数（必填），包含动态ID、分页等信息
  /// 
  /// 返回值: 评论列表数据响应
  Future<AuvBaseResponse<AuvCommentListDataResponse>> getComments({
    required AuvGetCommentsRequest request,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getComments,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<AuvCommentListDataResponse>(
        response.data,
        (data) => AuvCommentListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvCommentListDataResponse>(e);
    }
  }
}
