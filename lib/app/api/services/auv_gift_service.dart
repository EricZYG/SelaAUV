import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_showdoc_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 送礼服务
///
/// 处理送礼相关接口：赠送礼物、幸运礼物等
class AuvGiftService extends AuvBaseService {
  /// 创建服务实例
  static AuvGiftService create() {
    final service = AuvGiftService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取普通礼物列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getUserGiftList();
  /// if (result.success && result.data != null) {
  ///   for (final gift in result.data!.list ?? []) {
  ///     print('${gift.name}: ${gift.diamonds}钻石');
  ///   }
  /// }
  /// ```
  Future<AuvShowDocResponse<AuvUserGiftListDataResponse>> getUserGiftList() async {
    try {
      final response = await get(AuvShowDocRoutes.getGiftList);
      return handleObjectResponse<AuvUserGiftListDataResponse>(
        response.data,
        (data) => AuvUserGiftListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserGiftListDataResponse>(e);
    }
  }

  /// 获取普通+VIP礼物列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getAllGifts();
  /// if (result.success && result.data != null) {
  ///   for (final gift in result.data!.list ?? []) {
  ///     final type = gift.isVipGift ? 'VIP礼物' : '普通礼物';
  ///     print('${gift.name} [$type]: ${gift.diamonds}钻石');
  ///   }
  /// }
  /// ```
  Future<AuvShowDocResponse<AuvUserGiftListDataResponse>> getAllGifts() async {
    try {
      final response = await get(AuvShowDocRoutes.getAllGifts);
      return handleObjectResponse<AuvUserGiftListDataResponse>(
        response.data,
        (data) => AuvUserGiftListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserGiftListDataResponse>(e);
    }
  }

  /// 获取单个礼物详情
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getOneGift(gid: 1001);
  /// if (result.success && result.data != null) {
  ///   print('${result.data!.name}: ${result.data!.diamonds}钻石');
  /// }
  /// ```
  Future<AuvShowDocResponse<AuvGiftDetailResponse>> getOneGift({required int gid}) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getOneGift,
        queryParameters: {'gid': gid},
      );
      return handleObjectResponse<AuvGiftDetailResponse>(
        response.data,
        (data) => AuvGiftDetailResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvGiftDetailResponse>(e);
    }
  }

  /// 获取礼物动作列表
  ///
  /// 示例:
  /// ```dart
  /// // 获取1v1动作
  /// final result1v1 = await giftService.getActions(type: AuvGiftActionType.oneVOne);
  ///
  /// // 获取直播间动作
  /// final resultLive = await giftService.getActions(type: AuvGiftActionType.liveRoom);
  ///
  /// if (result.success && result.data != null) {
  ///   for (final action in result.data!) {
  ///     print('${action.actionName}');
  ///   }
  /// }
  /// ```
  Future<AuvShowDocResponse<List<AuvGiftActionResponse>>> getActions({
    AuvGiftActionType? type,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getActions,
        queryParameters: type != null ? {'type': type.value} : null,
      );
      return handleListResponse<AuvGiftActionResponse>(
        response.data,
        (data) => AuvGiftActionResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvGiftActionResponse>>(e);
    }
  }

  /// 赠送礼物(真实礼物)
  /// 
  /// 向主播赠送真实礼物，消耗钻石
  /// 
  /// [giftId] 礼物ID（必填）
  /// [anchorId] 主播ID（必填）
  /// [roomId] 房间ID（必填）
  /// [num] 礼物数量（必填）
  /// 
  /// 返回值: 送礼结果响应
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvShowDocResponse<AuvGiftSendResultResponse>> sendRealGift({
    required String giftId,
    required String anchorId,
    required String roomId,
    required int num,
  }) async {
    try {
      final data = {
        'gift_id': giftId,
        'anchor_id': anchorId,
        'room_id': roomId,
        'num': num,
      };

      final response = await post(
        AuvShowDocRoutes.sendRealGift,
        data: data,
        needSign: true,
      );
      return handleResponse<AuvGiftSendResultResponse>(
        response.data,
        (data) => AuvGiftSendResultResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvGiftSendResultResponse>(e);
    }
  }

  /// 赠送幸运礼物
  /// 
  /// 向主播赠送幸运礼物，有概率触发额外奖励
  /// 
  /// [giftId] 礼物ID（必填）
  /// [anchorId] 主播ID（必填）
  /// [roomId] 房间ID（必填）
  /// [num] 礼物数量（必填）
  /// 
  /// 返回值: 送礼结果响应
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvShowDocResponse<AuvGiftSendResultResponse>> sendLuckyGift({
    required String giftId,
    required String anchorId,
    required String roomId,
    required int num,
  }) async {
    try {
      final data = {
        'gift_id': giftId,
        'anchor_id': anchorId,
        'room_id': roomId,
        'num': num,
      };

      final response = await post(
        AuvShowDocRoutes.sendLuckyGift,
        data: data,
        needSign: true,
      );
      return handleResponse<AuvGiftSendResultResponse>(
        response.data,
        (data) => AuvGiftSendResultResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvGiftSendResultResponse>(e);
    }
  }
}
