/// 匹配服务
/// 
/// 处理1v1视频匹配相关接口：开始匹配、取消匹配、匹配历史等
import 'package:slea_auv/app/api/auv_api_routes.dart';
import 'package:slea_auv/app/api/models/auv_match_model.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/api/auv_api_result.dart';
import 'package:get/get.dart';

class AuvMatchService extends GetxService {
  final AuvApiService _api = AuvApiService();

  /// 开始匹配
  /// 
  /// 开始1v1视频匹配，查找可用的主播进行通话
  /// 
  /// 返回值: 匹配结果，包含matchId等信息
  Future<AuvApiResult<AuvMatchModel>> startMatch() async {
    try {
      final response = await _api.post(AuvApiRoutes.matchStart);

      if (response.data['code'] == 200) {
        return AuvApiResult.success(AuvMatchModel.fromJson(response.data['data']));
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to start match',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 取消匹配
  /// 
  /// 取消正在进行的匹配
  /// 
  /// [matchId] 匹配ID（必填）
  /// 
  /// 返回值: 空结果
  Future<AuvApiResult<void>> cancelMatch(String matchId) async {
    try {
      final response = await _api.post(
        AuvApiRoutes.matchCancel,
        data: {'match_id': matchId},
      );

      if (response.data['code'] == 200) {
        return AuvApiResult.success(null);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to cancel match',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 获取匹配历史
  /// 
  /// 分页获取用户的匹配历史记录
  /// 
  /// [page] 页码（可选），默认1
  /// [pageSize] 每页数量（可选），默认20
  /// 
  /// 返回值: 匹配历史列表
  Future<AuvApiResult<List<AuvMatchModel>>> getMatchHistory({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _api.get(
        AuvApiRoutes.matchHistory,
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (response.data['code'] == 200) {
        final List<AuvMatchModel> list = (response.data['data']['list'] as List)
            .map((e) => AuvMatchModel.fromJson(e))
            .toList();
        return AuvApiResult.success(list);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to get match history',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }
}
