
import 'package:get/get.dart';

import '../auv_net_routes.dart';
import '../models/auv_models.dart';
import '../models/call/auv_call_channel_response.dart';
import '../../services/auv_api_service.dart';
import 'auv_base_service.dart';

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
  Future<AuvBaseResponse<List<AuvCallRecordResponse>>> getCallRecordList({
    int? callType,
    int? callFlag,
    List<int>? callTypes,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getCallRecordList,
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
  /// 【请求参数】
  /// [type] 通话类型（必填）
  ///   - 0.正常拨打
  ///   - 1.AIB唤起
  ///   - 2.匹配唤起
  ///   - 3.主播邀请
  ///   - 4.主播免费邀请
  ///   - 5.免费匹配
  ///   - 6.直播间内唤起
  /// [targetUserId] 目标用户ID（必填）
  /// 
  /// 【返回值】
  /// - 成功: 返回通话频道信息，包含频道ID等
  /// - 失败(code=1008): 余额不足
  /// 
  /// 【注意】此接口无需签名验证
  Future<AuvBaseResponse<AuvCallChannelResponse>> createCallChannel({
    required int type,
    required int targetUserId,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.createCallChannel}/$type/$targetUserId',
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
  /// 用户加入指定通话频道的聊天室，获取通话所需的信息
  /// 
  /// 【请求参数】
  /// [channelId] 频道ID（必填）
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - channelId: 频道ID
  ///   - callType: 通话类型（0-6）
  ///   - rtcToken: 声网token，用于加入实时通话
  ///   - imToken: IM连接令牌，用于即时通讯
  ///   - usedCallCard: 是否使用视频卡
  ///   - remainDiamonds: 用户剩余钻石
  ///   - chargePrice: 收费钻石单价
  ///   - chargePriceCoins: 收费金币单价
  /// 
  /// 【错误码】
  /// - code=1008: 余额不足
  /// 
  /// 【注意】此接口无需签名验证
  Future<AuvBaseResponse<AuvCallChatRoomResponse>> joinCallChannel({
    required int channelId,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.joinCallChannel}/$channelId',
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
  /// 【请求参数】
  /// [channelId] 频道ID（必填）
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - rtcToken: 新的声网token
  /// 
  /// 【错误码】
  /// - code=1008: 余额不足
  /// 
  /// 【注意】此接口无需签名验证
  Future<AuvBaseResponse<AuvCallRefreshResponse>> refreshCall({
    required int channelId,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.refreshCall}/$channelId',
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

  /// 挂断通话
  /// 
  /// 结束当前通话并获取结算信息
  /// 
  /// 【请求参数】
  /// [channelId] 频道ID（必填）
  /// [endType] 挂断原因（必填）
  ///   - 0.正常挂断
  ///   - 1.对方未接
  ///   - 2.对方拒绝
  ///   - 3.通话超时
  ///   - 4.网络异常
  ///   - 5.用户主动挂断
  ///   - 6.对方挂断
  ///   - 7.系统中断
  ///   - 8.余额不足
  /// [clientEndAt] 客户端挂断时间，毫秒数（可选）
  /// [clientDuration] 客户端通话时长，毫秒数（可选）
  /// [outDuration] 不在视频范围内的时长，毫秒数（可选）
  /// [outCount] 不在视频范围内的次数（可选）
  /// [requestCount] 请求次数（可选）
  /// [matchMode] 匹配模式，1.隐私模式（可选）
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - channelId: 频道id
  ///   - callTime: 通话时长，格式HH:mm:ss
  ///   - totalCallTime: 总通话时长
  ///   - usedMatchPropFlag: 是否使用了匹配卡
  ///   - usedCallPropFlag: 是否使用了视频卡
  ///   - callAmount: 通话费用
  ///   - giftAmount: 礼物费用
  ///   - remainAmount: 剩余余额
  ///   - callCardCount: 剩余视频卡数量
  /// 
  /// 【错误码】
  /// - code=1008: 余额不足
  /// 
  /// 【注意】此接口无需签名验证
  Future<AuvBaseResponse<AuvEndCallResponse>> endCall({
    required int channelId,
    required int endType,
    int? clientEndAt,
    int? clientDuration,
    int? outDuration,
    int? outCount,
    int? requestCount,
    int? matchMode,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.endCall,
        data: AuvEndCallRequest(
          channelId: channelId,
          endType: endType,
          clientEndAt: clientEndAt,
          clientDuration: clientDuration,
          outDuration: outDuration,
          outCount: outCount,
          requestCount: requestCount,
          matchMode: matchMode,
        ).toJson(),
        needSign: false,
      );
      return handleResponse<AuvEndCallResponse>(
        response.data,
        (data) => AuvEndCallResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvEndCallResponse>(e);
    }
  }

  /// 主叫取消通话
  /// 
  /// 主叫方在通话建立前取消通话
  /// 
  /// 【请求参数】
  /// [channelId] 频道ID（必填）
  /// [endType] 挂断原因（必填）
  ///   - 0.正常挂断
  ///   - 1.对方未接
  ///   - 2.对方拒绝
  ///   - 3.通话超时
  ///   - 4.网络异常
  ///   - 5.用户主动挂断
  ///   - 6.对方挂断
  ///   - 7.系统中断
  ///   - 8.余额不足
  /// [matchMode] 匹配模式，1.隐私模式（可选）
  /// 
  /// 【返回值】无
  /// 
  /// 【错误码】
  /// - code=1008: 余额不足
  /// 
  /// 【注意】此接口无需签名验证
  Future<AuvBaseResponse<void>> cancelCall({
    required int channelId,
    required int endType,
    int? matchMode,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.cancelCall,
        data: AuvCancelCallRequest(
          channelId: channelId,
          endType: endType,
          matchMode: matchMode,
        ).toJson(),
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 被叫拒绝通话
  /// 
  /// 被叫方拒绝接听来电
  /// 
  /// 【请求参数】
  /// [channelId] 频道ID（必填）
  /// [endType] 挂断原因（必填）
  ///   - 0.正常挂断
  ///   - 1.对方未接
  ///   - 2.对方拒绝
  ///   - 3.通话超时
  ///   - 4.网络异常
  ///   - 5.用户主动挂断
  ///   - 6.对方挂断
  ///   - 7.系统中断
  ///   - 8.余额不足
  /// 
  /// 【返回值】无
  /// 
  /// 【错误码】
  /// - code=1008: 余额不足
  /// 
  /// 【注意】此接口无需签名验证
  Future<AuvBaseResponse<void>> refuseCall({
    required int channelId,
    required int endType,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.refuseCall,
        data: AuvRefuseCallRequest(
          channelId: channelId,
          endType: endType,
        ).toJson(),
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 心跳请求
  /// 
  /// 通话过程中定时发送心跳包，保持通话连接状态
  /// 建议1-2分钟间隔请求一次
  /// 
  /// 【主播端参数】
  /// [isScreenOff] 屏幕是否关闭，用于判断是否需要继续拉流
  /// 
  /// 【用户端参数】
  /// [rtmStatus] RTM状态，0.离线，1.在线
  /// 
  /// 返回值: 空响应
  /// 
  /// 注意: 此接口无需签名验证
  Future<AuvBaseResponse<void>> heartbeat({
    bool? isScreenOff,
    int? rtmStatus,
  }) async {
    try {
      final data = {
        if (isScreenOff != null) 'isScreenOff': isScreenOff,
        if (rtmStatus != null) 'rtmStatus': rtmStatus,
      };
      final response = await post(
        AuvNetRoutes.heartbeat,
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
  Future<AuvBaseResponse<AuvCallRecordListDataResponse>> getCallRecordVoList({
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
        AuvNetRoutes.getCallRecordVoList,
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
  /// 【请求参数】
  /// [channelId] 频道ID（必填）
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - isTagCall: 是否可打标签
  ///   - tags: 标签列表
  ///     * id: 标签id
  ///     * classifyId: 分类id
  ///     * title: 分类名
  ///     * tagValue: 标签值
  ///     * tagType: 标签类型
  ///     * tagImg: 标签图片
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
  Future<AuvBaseResponse<AuvIsTagCallDataResponse>> isTagCall({
    required int channelId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.isTagCall,
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

  /// 通话结束打标签
  /// 
  /// 通话结束后给主播打标签
  /// 
  /// 【请求参数】
  /// [channelId] 通话频道ID（必填）
  /// [tagId] 标签ID（必填）
  /// 
  /// 【返回值】无
  /// 
  /// 【注意】此接口无需签名验证
  Future<AuvBaseResponse<void>> tagCall({
    required int channelId,
    required int tagId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.tagCall,
        data: AuvTagCallRequest(
          channelId: channelId,
          tagId: tagId,
        ).toJson(),
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 上报通话质量
  /// 
  /// 上报通话质量数据用于监控分析
  /// 
  /// 【请求参数】
  /// [channelId] 频道ID（必填）
  /// [rxQuality] 接收质量（必填）
  /// [time] 时间，毫秒数（必填）
  /// [txQuality] 发送质量（必填）
  /// [isRemote] 是否是对方，0.自己，1.对方（必填）
  /// 
  /// 【返回值】无
  /// 
  /// 【注意】此接口无需签名验证
  Future<AuvBaseResponse<void>> reportCall({
    required int channelId,
    required int rxQuality,
    required int time,
    required int txQuality,
    required int isRemote,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.reportCall,
        data: AuvReportCallRequest(
          channelId: channelId,
          rxQuality: rxQuality,
          time: time,
          txQuality: txQuality,
          isRemote: isRemote,
        ).toJson(),
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 查询对方免费邀请通话相关信息
  /// 
  /// 获取指定用户的免费邀请通话信息，包括免费时长、次数上限和剩余次数
  /// 
  /// 【请求参数】
  /// [userId] 用户ID（必填）
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - freeInviteSeconds: 免费邀请通话的免费时长，单位秒
  ///   - freeInviteCountLimit: 免费邀请通话次数上限
  ///   - freeInviteLeftCount: 免费邀请通话剩余次数
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.getFreeInviteCallInfo(userId: 123);
  /// if (result.success && result.data != null) {
  ///   print('Free seconds: ${result.data!.freeInviteSeconds}');
  ///   print('Left count: ${result.data!.freeInviteLeftCount}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvFreeInviteCallInfoResponse>> getFreeInviteCallInfo({
    required int userId,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getFreeInviteCallInfo,
        queryParameters: {'userId': userId},
      );
      return handleObjectResponse<AuvFreeInviteCallInfoResponse>(
        response.data,
        (data) => AuvFreeInviteCallInfoResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvFreeInviteCallInfoResponse>(e);
    }
  }

  /// 获取违规处罚配置
  /// 
  /// 获取通话违规处罚相关配置信息，包括高频/低频开关、提醒次数、封禁配置等
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - preFlag: 高频开关，0.关闭，1.打开
  ///   - postFlag: 低频开关，0.关闭，1.打开
  ///   - preRemind: 高频提醒开关，0.关闭，1.打开
  ///   - postRemind: 低频提醒开关，0.关闭，1.打开
  ///   - preDelayCount: 高频通话间隔数量
  ///   - postDelayCount: 低频通话间隔数量
  ///   - preDelaySeconds: 高频检测间隔秒数
  ///   - postDelaySeconds: 低频检测间隔秒数
  ///   - preTotalSeconds: 高频检测秒数
  ///   - remindCount: 提醒次数
  ///   - warnCount: 警告次数
  ///   - banCount: 封禁次数
  ///   - banType: 封禁类型
  ///   - banReason: 封禁理由
  ///   - authDelaySeconds: 重新认证间隔秒数
  ///   - cancelAuthReason: 取消认证理由
  ///   - violateCount: 今日违规次数
  ///   - banMinutes: 封禁分钟数
  ///   - resetDays: 违规重置天数
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.getViolationConfig();
  /// if (result.success && result.data != null) {
  ///   print('Remind count: ${result.data!.remindCount}');
  ///   print('Ban minutes: ${result.data!.banMinutes}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvViolationConfigResponse>> getViolationConfig() async {
    try {
      final response = await get(
        AuvNetRoutes.getViolationConfig,
      );
      return handleObjectResponse<AuvViolationConfigResponse>(
        response.data,
        (data) => AuvViolationConfigResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvViolationConfigResponse>(e);
    }
  }

  /// 获取违规处罚记录
  /// 
  /// 分页获取违规处罚记录列表
  /// 
  /// 【请求参数】
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  /// [condition] 查询条件（可选）
  ///   - recordType: 处罚类型，1.提醒，2.警告，3.封禁，4.取消认证
  ///   - recordStatus: 申诉状态，0.无申诉，1.申诉中，2.申诉成功，3.申诉失败
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - list: 违规记录列表
  ///   - pageNum: 当前页码
  ///   - pageSize: 每页条数
  ///   - total: 总记录数
  ///   - hasNextPage: 是否有下一页
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.getViolationRecordPage(
  ///   pageNum: 1,
  ///   pageSize: 10,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final record in result.data!.list ?? []) {
  ///     print('${record.nickname}: ${record.recordType}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvViolationRecordListDataResponse>> getViolationRecordPage({
    required int pageNum,
    required int pageSize,
    AuvViolationRecordConditionRequest? condition,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getViolationRecordPage,
        data: {
          'pageNum': pageNum,
          'pageSize': pageSize,
          if (condition != null) 'condition': condition.toJson(),
        },
        needSign: false,
      );
      return handleObjectResponse<AuvViolationRecordListDataResponse>(
        response.data,
        (data) => AuvViolationRecordListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvViolationRecordListDataResponse>(e);
    }
  }

  /// 上传违规处罚记录
  /// 
  /// 上报违规处罚记录信息
  /// 
  /// 【请求参数】
  /// [channelId] 频道ID（必填）
  /// [recordSeconds] 通话多少秒时违规（必填）
  /// [screenshotUrl] 违规截图（可选）
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - violateType: 处罚类型，1.提醒，2.警告，3.封禁，4.取消认证
  ///   - violateCount: 违规次数
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.uploadViolationRecord(
  ///   channelId: 123456,
  ///   recordSeconds: 30,
  ///   screenshotUrl: 'https://example.com/screenshot.png',
  /// );
  /// if (result.success && result.data != null) {
  ///   print('Violate type: ${result.data!.violateType}');
  ///   print('Violate count: ${result.data!.violateCount}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvUploadViolationRecordResponse>> uploadViolationRecord({
    required int channelId,
    required int recordSeconds,
    String? screenshotUrl,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.uploadViolationRecord,
        data: AuvUploadViolationRecordRequest(
          channelId: channelId,
          recordSeconds: recordSeconds,
          screenshotUrl: screenshotUrl,
        ).toJson(),
        needSign: false,
      );
      return handleObjectResponse<AuvUploadViolationRecordResponse>(
        response.data,
        (data) => AuvUploadViolationRecordResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUploadViolationRecordResponse>(e);
    }
  }

  /// 主播答题重新认证
  /// 
  /// 主播通过答题重新获取认证资格
  /// 
  /// 【返回值】无
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.reAuth();
  /// if (result.success) {
  ///   print('Re-auth successful');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> reAuth() async {
    try {
      final response = await post(
        AuvNetRoutes.reAuth,
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取挂机检测配置
  /// 
  /// 获取通话挂机检测相关配置信息
  /// 
  /// 【返回值】
  /// 返回数据为配置列表，每项包含:
  ///   - hangupType: 挂机类型，1.正常模式，2.匹配模式
  ///   - delaySeconds: 检测间隔，单位秒
  ///   - closeSeconds: 关闭弹窗时间，单位秒
  ///   - dailyBegin: 每日开始时间，格式HH:mm
  ///   - dailyEnd: 每日结束时间，格式HH:mm
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.getHangupConfigs();
  /// if (result.success && result.data != null) {
  ///   for (final config in result.data!) {
  ///     print('${config.hangupType}: delay=${config.delaySeconds}s');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvHangupConfigItemResponse>>> getHangupConfigs() async {
    try {
      final response = await get(
        AuvNetRoutes.getHangupConfigs,
      );
      return handleListResponse<AuvHangupConfigItemResponse>(
        response.data,
        (data) => AuvHangupConfigItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvHangupConfigItemResponse>>(e);
    }
  }

  /// 获取挂机记录
  /// 
  /// 分页获取挂机记录列表
  /// 
  /// 【请求参数】
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  /// [condition] 查询条件（可选）
  ///   - hangupType: 挂机类型，1.正常模式，2.匹配模式，3.连续超时挂断
  /// 
  /// 【返回值】
  /// 返回数据包含:
  ///   - list: 挂机记录列表
  ///   - pageNum: 当前页码
  ///   - pageSize: 每页条数
  ///   - total: 总记录数
  ///   - hasNextPage: 是否有下一页
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.getHangupRecordPage(
  ///   pageNum: 1,
  ///   pageSize: 10,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final record in result.data!.list ?? []) {
  ///     print('${record.recordId}: ${record.hangupType}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvHangupRecordListDataResponse>> getHangupRecordPage({
    required int pageNum,
    required int pageSize,
    AuvHangupRecordConditionRequest? condition,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getHangupRecordPage,
        data: {
          'pageNum': pageNum,
          'pageSize': pageSize,
          if (condition != null) 'condition': condition.toJson(),
        },
        needSign: false,
      );
      return handleObjectResponse<AuvHangupRecordListDataResponse>(
        response.data,
        (data) => AuvHangupRecordListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvHangupRecordListDataResponse>(e);
    }
  }

  /// 上传挂机记录
  /// 
  /// 上报用户挂机行为记录
  /// 
  /// 【请求参数】
  /// [hangupType] 挂机类型（必填）
  ///   - 1.正常模式
  ///   - 2.匹配模式
  ///   - 3.连续超时挂断
  /// 
  /// 【返回值】
  /// 返回数据为空
  /// 
  /// 示例:
  /// ```dart
  /// final result = await callService.uploadHangupRecord(
  ///   hangupType: 1,
  /// );
  /// if (result.success) {
  ///   print('上传成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> uploadHangupRecord({
    required int hangupType,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.uploadHangupRecord,
        data: {'hangupType': hangupType},
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }
}
