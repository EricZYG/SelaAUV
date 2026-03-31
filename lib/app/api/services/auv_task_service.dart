import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_api_routes.dart';
import 'package:slea_auv/app/api/models/auv_task_model.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/api/auv_api_result.dart';

/// 任务服务
class AuvTaskService extends GetxService {
  final AuvApiService _api = AuvApiService();

  /// 获取我的任务列表
  /// 返回任务列表，按 sortWeight 降序排列
  Future<AuvApiResult<List<AuvTaskItem>>> getUserTaskList() async {
    try {
      final response = await _api.get(AuvApiRoutes.getUserTaskList);
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success) {
        final List<dynamic> dataList = result.data as List<dynamic>;
        final tasks = dataList.map((e) => AuvTaskItem.fromJson(e)).toList();
        // 按 sortWeight 降序排列
        tasks.sort((a, b) => b.sortWeight.compareTo(a.sortWeight));
        return AuvApiResult.success(tasks);
      } else {
        return AuvApiResult.fail(result.errorMessage, code: result.code);
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 领取任务奖励
  /// 
  /// 领取已完成任务的奖励
  /// 
  /// [taskId] 任务ID（必填）
  /// 
  /// 返回值: 空结果
  Future<AuvApiResult<void>> claimTaskReward(int taskId) async {
    try {
      final response = await _api.post(
        AuvApiRoutes.claimTaskReward,
        data: {'taskId': taskId},
      );
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success) {
        return AuvApiResult.success(null);
      } else {
        return AuvApiResult.fail(result.errorMessage, code: result.code);
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 任务领取
  /// 
  /// 领取任务奖励并触发抽奖
  /// 
  /// [taskUnique] 任务唯一标识（必填）
  /// [round] 轮次（可选），默认1
  /// 
  /// 返回值: 抽奖结果
  Future<AuvApiResult<AuvTaskDrawResult>> userDraw({
    required String taskUnique,
    int round = 1,
  }) async {
    try {
      final response = await _api.post(
        AuvApiRoutes.userDraw,
        data: {
          'taskUnique': taskUnique,
          'round': round,
        },
      );
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success) {
        final drawResult = AuvTaskDrawResult.fromJson(result.data);
        return AuvApiResult.success(drawResult);
      } else {
        return AuvApiResult.fail(result.errorMessage, code: result.code);
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }
}
