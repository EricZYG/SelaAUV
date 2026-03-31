import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_net_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/models/room/auv_create_room_response.dart';
import 'package:slea_auv/app/api/models/room/auv_end_room_response.dart';
import 'package:slea_auv/app/api/models/room/auv_live_room_full_detail_response.dart';
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
  Future<AuvBaseResponse<AuvLiveRoomListDataResponse>> getLiveRoomList({
    int page = 1,
    int pageSize = 20,
    int? categoryId,
    int? userId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.liveRoomList,
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
  Future<AuvBaseResponse<AuvLiveRoomDetailResponse>> getLiveRoomDetail({
    required int roomId,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.liveRoomDetail,
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

  /// 创建直播间开始直播
  ///
  /// 创建直播间并开始直播
  ///
  /// 【请求参数】
  /// [title] 房间标题（必填）
  /// [notice] 房间公告
  /// [coverUrl] 封面地址
  /// [gameCode] 游戏编码
  ///
  /// 【返回值】
  /// 返回直播间信息
  /// - roomId: 房间ID
  /// - channelName: 房间频道号，用于连声网rtc
  /// - roomStatus: 房间状态（1.直播中，2.暂停，3.结束）
  ///
  /// 【错误码】
  /// - 1043: 直播间游戏挂载人数已满
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.createRoom(
  ///   title: '我的直播间',
  ///   notice: '欢迎来到我的直播间',
  ///   coverUrl: 'https://example.com/cover.jpg',
  /// );
  /// if (result.success && result.data != null) {
  ///   print('创建成功: ${result.data!.roomId}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvCreateRoomResponse>> createRoom({
    required String title,
    String? notice,
    String? coverUrl,
    String? gameCode,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomCreate,
        data: {
          'title': title,
          if (notice != null) 'notice': notice,
          if (coverUrl != null) 'coverUrl': coverUrl,
          if (gameCode != null) 'gameCode': gameCode,
        },
      );
      return handleResponse<AuvCreateRoomResponse>(
        response.data,
        (data) => AuvCreateRoomResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvCreateRoomResponse>(e);
    }
  }

  /// 用户点赞
  ///
  /// 用户对直播间进行点赞
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  /// [count] 连点次数（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.likeRoom(
  ///   roomId: 1698902146478649346,
  ///   count: 1,
  /// );
  /// if (result.success) {
  ///   print('点赞成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> likeRoom({
    required int roomId,
    required int count,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomLike.replaceAll('{roomId}', roomId.toString()),
        data: {'count': count},
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取直播间详细信息
  ///
  /// 获取指定直播间的详细信息
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回直播间详细信息，包含游戏信息、用户信息等
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.getRoomFullDetail(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success && result.data != null) {
  ///   final room = result.data!;
  ///   print('房间标题: ${room.title}');
  ///   print('观看人数: ${room.watchCount}');
  ///   print('点赞数: ${room.likeCount}');
  ///   print('直播时长: ${room.duration}毫秒');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvLiveRoomFullDetailResponse>> getRoomFullDetail({
    required int roomId,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.roomGetDetail,
        queryParameters: {'roomId': roomId},
      );
      return handleResponse<AuvLiveRoomFullDetailResponse>(
        response.data,
        (data) => AuvLiveRoomFullDetailResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLiveRoomFullDetailResponse>(e);
    }
  }

  /// 修改直播间信息
  ///
  /// 修改指定直播间的信息
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  /// [title] 房间标题
  /// [notice] 房间公告
  /// [coverUrl] 封面地址
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.updateRoom(
  ///   roomId: 1698902146478649346,
  ///   title: '新标题',
  ///   notice: '新公告',
  /// );
  /// if (result.success) {
  ///   print('修改成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> updateRoom({
    required int roomId,
    String? title,
    String? notice,
    String? coverUrl,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomUpdate.replaceAll('{roomId}', roomId.toString()),
        data: {
          if (title != null) 'title': title,
          if (notice != null) 'notice': notice,
          if (coverUrl != null) 'coverUrl': coverUrl,
        },
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 结束直播
  ///
  /// 结束指定直播间的直播
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回直播结束统计信息
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.endRoom(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success && result.data != null) {
  ///   final stats = result.data!;
  ///   print('礼物收益: ${stats.giftCoins}');
  ///   print('观看人数: ${stats.watchCount}');
  ///   print('直播时长: ${stats.duration}毫秒');
  ///   print('点赞数: ${stats.likeCount}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvEndRoomResponse>> endRoom({
    required int roomId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomEnd.replaceAll('{roomId}', roomId.toString()),
      );
      return handleResponse<AuvEndRoomResponse>(
        response.data,
        (data) => AuvEndRoomResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvEndRoomResponse>(e);
    }
  }

  /// 恢复直播
  ///
  /// 恢复暂停的直播
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.resumeRoom(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success) {
  ///   print('恢复成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> resumeRoom({
    required int roomId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomResume.replaceAll('{roomId}', roomId.toString()),
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 暂停直播
  ///
  /// 暂停直播
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.pauseRoom(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success) {
  ///   print('暂停成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> pauseRoom({
    required int roomId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomPause.replaceAll('{roomId}', roomId.toString()),
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 用户加入直播间
  ///
  /// 用户加入直播间
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.joinRoom(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success) {
  ///   print('加入成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> joinRoom({
    required int roomId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomJoin.replaceAll('{roomId}', roomId.toString()),
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 用户离开直播间
  ///
  /// 用户离开直播间
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.leaveRoom(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success) {
  ///   print('离开成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> leaveRoom({
    required int roomId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomLeave.replaceAll('{roomId}', roomId.toString()),
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 分页查询直播间列表
  ///
  /// 分页查询直播间列表，支持按房间类型和地区筛选
  ///
  /// 【请求参数】
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  /// [roomType] 房间类型（可选）：1.普通直播间，2.游戏直播间，3.私密直播间
  /// [areaCode] 用户首页地区编码（可选）
  ///
  /// 【返回值】
  /// 返回直播间分页列表数据
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.getRoomList(
  ///   pageNum: 1,
  ///   pageSize: 20,
  ///   roomType: 1,
  ///   areaCode: 86,
  /// );
  /// if (result.success && result.data != null) {
  ///   final list = result.data!.list;
  ///   final total = result.data!.total;
  ///   print('共 ${total} 个直播间');
  /// }
  /// ```
  Future<AuvBaseResponse<GetLiveRoomListDataResponse>> getRoomList({
    required int pageNum,
    required int pageSize,
    int? roomType,
    int? areaCode,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getLiveRoomList,
        data: {
          'pageNum': pageNum,
          'pageSize': pageSize,
          'condition': GetLiveRoomRequest(
            roomType: roomType,
            areaCode: areaCode,
          ).toJson(),
        },
        needSign: false,
      );
      return handleResponse<GetLiveRoomListDataResponse>(
        response.data,
        (data) => GetLiveRoomListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<GetLiveRoomListDataResponse>(e);
    }
  }

  /// 获取直播间topN用户
  ///
  /// 获取直播间贡献值排名前N的用户列表
  ///
  /// 【请求参数】
  /// [roomId] 房间id（必填）
  /// [size] 要获取的用户个数（必填）
  ///
  /// 【返回值】
  /// 返回Top用户列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.getTopUsers(
  ///   roomId: 1698902146478649346,
  ///   size: 10,
  /// );
  /// if (result.success && result.data != null) {
  ///   final users = result.data!;
  ///   for (final user in users) {
  ///     print('${user.nickname}: ${user.heatValue}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<GetTopUserItemResponse>>> getTopUsers({
    required int roomId,
    required int size,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getTopUsers,
        queryParameters: {
          'roomId': roomId,
          'size': size,
        },
      );
      return handleListResponse<GetTopUserItemResponse>(
        response.data,
        (data) => GetTopUserItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<GetTopUserItemResponse>>(e);
    }
  }

  /// 主播发送直播间心跳
  ///
  /// 主播发送直播间心跳，用于保持直播间活跃状态
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.sendHeartbeat(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success) {
  ///   print('心跳发送成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> sendHeartbeat({
    required int roomId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomHeartbeat.replaceAll('{roomId}', roomId.toString()),
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 主播设置直播中可接收电话
  ///
  /// 主播设置直播中可接收电话
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.openCall(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success) {
  ///   print('已开启接收电话');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> openCall({
    required int roomId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomOpenCall.replaceAll('{roomId}', roomId.toString()),
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 主播设置直播中不接收电话
  ///
  /// 主播设置直播中不接收电话
  ///
  /// 【请求参数】
  /// [roomId] 房间ID（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await liveRoomService.closeCall(
  ///   roomId: 1698902146478649346,
  /// );
  /// if (result.success) {
  ///   print('已关闭接收电话');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> closeCall({
    required int roomId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.roomCloseCall.replaceAll('{roomId}', roomId.toString()),
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }
}
