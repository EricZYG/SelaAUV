import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_showdoc_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/models/auv_msg_model.dart';

/// 消息服务
/// 
/// 处理消息相关接口：发送消息、通话中消息，游戏房间消息、聊天记录等
class AuvMsgService extends AuvBaseService {
  /// 创建服务实例
  static AuvMsgService create() {
    final service = AuvMsgService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 发送消息
  /// 
  /// 发送聊天消息
  /// 
  /// [request] 发送消息请求参数（必填），包含接收者ID、消息内容等
  /// 
  /// 返回值: 发送结果响应
  Future<AuvShowDocResponse<AuvSendMsgResponse>> sendMsg({
    required AuvSendMsgRequest request,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.sendMsg,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<AuvSendMsgResponse>(
        response.data,
        (data) => AuvSendMsgResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvSendMsgResponse>(e);
    }
  }

  /// 通话中发送消息
  /// 
  /// 在通话过程中发送实时消息
  /// 
  /// [request] 通话中发送消息请求参数（必填），包含频道ID、消息内容等
  /// 
  /// 返回值: 发送结果响应
  Future<AuvShowDocResponse<AuvSendMsgResponse>> sendMsgInCall({
    required AuvSendMsgInCallRequest request,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.sendMsgInCall,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<AuvSendMsgResponse>(
        response.data,
        (data) => AuvSendMsgResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvSendMsgResponse>(e);
    }
  }

  /// 游戏房间中发送消息
  /// 
  /// 在游戏房间内发送实时消息
  /// 
  /// [request] 游戏房间发送消息请求参数（必填），包含房间ID、消息内容等
  /// 
  /// 返回值: 发送结果响应
  Future<AuvShowDocResponse<AuvSendMsgResponse>> sendMsgInGameRoom({
    required AuvSendMsgInGameRoomRequest request,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.sendMsgInGameRoom,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<AuvSendMsgResponse>(
        response.data,
        (data) => AuvSendMsgResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvSendMsgResponse>(e);
    }
  }

  /// 分页查询聊天记录
  /// 
  /// 分页获取与指定用户的聊天历史记录
  /// 
  /// [params] 查询参数（必填），包含用户ID、房间ID、分页信息等
  /// 
  /// 返回值: 消息记录列表
  Future<AuvShowDocResponse<List<AuvMsgRecord>>> getMsgRecords({
    required AuvGetMsgRecordsParams params,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getMsgRecords,
        queryParameters: params.toQueryParams(),
      );
      return handleListResponse<AuvMsgRecord>(
        response.data,
        (data) => AuvMsgRecord.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvMsgRecord>>(e);
    }
  }
}
