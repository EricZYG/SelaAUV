import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_showdoc_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 通话服务
/// 
/// 处理通话相关接口：通话记录、创建通话、加入通话，心跳等
class AuvCallService extends AuvBaseService {
  /// 创建服务实例
  static AuvCallService create() {
    final service = AuvCallService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取通话记录
  /// 
  /// 获取用户的通话历史记录列表
  /// 
  /// [callType] 通话类型（可选），如视频通话、语音通话等
  /// [callFlag] 通话标识（可选），用于区分来电/去电
  /// [callTypes] 通话类型列表（可选），支持多类型筛选
  /// 
  /// 返回值: 通话记录列表
  Future<AuvShowDocResponse<List<AuvCallRecordResponse>>> getCallRecordList({
    int? callType,
    int? callFlag,
    List<int>? callTypes,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.getCallRecordList,
        data: {
          if (callType != null) 'callType': callType,
          if (callFlag != null) 'callFlag': callFlag,
          if (callTypes != null) 'callTypes': callTypes,
        },
        needSign: false,
      );
      return handleListResponse<AuvCallRecordResponse>(
        response.data,
        (data) => AuvCallRecordResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvCallRecordResponse>>(e);
    }
  }

  /// 创建通话频道
  /// 
  /// 创建一个新的通话频道，用于与目标用户建立通话
  /// 
  /// [type] 通话类型（必填），如视频通话、语音通话
  /// [targetUserId] 目标用户ID（必填）
  /// 
  /// 返回值: 通话频道响应，包含频道ID等信息
  Future<AuvShowDocResponse<AuvCallChannelResponse>> createCallChannel({
    required int type,
    required int targetUserId,
  }) async {
    try {
      final response = await post(
        '${AuvShowDocRoutes.createCallChannel}/$type/$targetUserId',
        needSign: false,
      );
      return handleResponse<AuvCallChannelResponse>(
        response.data,
        (data) => AuvCallChannelResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvCallChannelResponse>(e);
    }
  }

  /// 加入通话聊天室
  /// 
  /// 用户加入指定通话频道的聊天室
  /// 
  /// [channelId] 频道ID（必填）
  /// 
  /// 返回值: 通话聊天室响应，包含聊天室信息
  Future<AuvShowDocResponse<AuvCallChatRoomResponse>> joinCallChannel({
    required int channelId,
  }) async {
    try {
      final response = await post(
        '${AuvShowDocRoutes.joinCallChannel}/$channelId',
        needSign: false,
      );
      return handleResponse<AuvCallChatRoomResponse>(
        response.data,
        (data) => AuvCallChatRoomResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvCallChatRoomResponse>(e);
    }
  }

  /// 用户通话续费
  /// 
  /// 用户对当前通话进行续费，延长通话时长
  /// 
  /// [channelId] 频道ID（必填）
  /// 
  /// 返回值: 通话续费响应
  Future<AuvShowDocResponse<AuvCallRefreshResponse>> refreshCall({
    required int channelId,
  }) async {
    try {
      final response = await post(
        '${AuvShowDocRoutes.refreshCall}/$channelId',
        needSign: false,
      );
      return handleResponse<AuvCallRefreshResponse>(
        response.data,
        (data) => AuvCallRefreshResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvCallRefreshResponse>(e);
    }
  }

  /// 心跳请求
  /// 
  /// 通话过程中发送心跳包，保持通话连接状态
  /// 
  /// [isScreenOff] 屏幕是否关闭（可选），用于判断是否需要继续拉流
  /// [rtmStatus] RTM状态（可选），实时消息传输状态
  /// 
  /// 返回值: 空响应
  Future<AuvShowDocResponse<void>> heartbeat({
    bool? isScreenOff,
    int? rtmStatus,
  }) async {
    try {
      final data = {
        if (isScreenOff != null) 'isScreenOff': isScreenOff,
        if (rtmStatus != null) 'rtmStatus': rtmStatus,
      };
      final response = await post(
        AuvShowDocRoutes.heartbeat,
        data: data,
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取通话记录V2
  /// 
  /// 分页获取用户的通话记录列表V2版本
  /// 
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页数量（必填）
  /// [condition] 查询条件（可选），包含通话类型筛选等
  /// 
  /// 返回值: 通话记录列表数据响应
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.getCallRecordVoList(
  ///   pageNum: 1,
  ///   pageSize: 10,
  ///   condition: AuvCallRecordConditionRequest(callTypes: [0, 1, 3, 4]),
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final record in result.data!.list ?? []) {
  ///     print('${record.peerNickname}: ${record.callTypeDesc}');
  ///   }
  /// }
  /// ```
  Future<AuvShowDocResponse<AuvCallRecordListDataResponse>> getCallRecordVoList({
    required int pageNum,
    required int pageSize,
    AuvCallRecordConditionRequest? condition,
  }) async {
    try {
      final request = AuvGetCallRecordRequest(
        pageNum: pageNum,
        pageSize: pageSize,
        condition: condition,
      );
      final response = await post(
        AuvShowDocRoutes.getCallRecordVoList,
        data: request.toJson(),
        needSign: false,
      );
      return handleObjectResponse<AuvCallRecordListDataResponse>(
        response.data,
        (data) => AuvCallRecordListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvCallRecordListDataResponse>(e);
    }
  }

  /// 通话结束是否可打标签
  /// 
  /// 查询当前通话结束后是否可以给主播打标签
  /// 
  /// [channelId] 频道ID（必填）
  /// 
  /// 返回值: 是否可打标签数据响应，包含标签列表
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.isTagCall(channelId: 123456);
  /// if (result.success && result.data != null) {
  ///   print('Can tag: ${result.data!.isTagCall}');
  ///   for (final tag in result.data!.tags ?? []) {
  ///     print('Tag: ${tag.tagValue}');
  ///   }
  /// }
  /// ```
  Future<AuvShowDocResponse<AuvIsTagCallDataResponse>> isTagCall({
    required int channelId,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.isTagCall,
        data: {'channelId': channelId},
        needSign: false,
      );
      return handleObjectResponse<AuvIsTagCallDataResponse>(
        response.data,
        (data) => AuvIsTagCallDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvIsTagCallDataResponse>(e);
    }
  }
}
