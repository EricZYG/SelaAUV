/// 聊天服务
/// 
/// 处理私聊相关接口：聊天列表、聊天历史、发送消息等
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_api_routes.dart';
import 'package:slea_auv/app/models/auv_match_model.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/api/auv_api_result.dart';

class AuvChatService extends GetxService {
  final AuvApiService _api = AuvApiService();

  /// 获取聊天列表
  /// 
  /// 获取与所有用户的私聊会话列表
  /// 
  /// [page] 页码（可选），默认1
  /// [pageSize] 每页数量（可选），默认20
  /// 
  /// 返回值: 聊天消息列表
  Future<AuvApiResult<List<AuvChatMessage>>> getChatList({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _api.get(
        AuvApiRoutes.chatList,
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (response.data['code'] == 200) {
        final List<AuvChatMessage> list = (response.data['data']['list'] as List)
            .map((e) => AuvChatMessage.fromJson(e))
            .toList();
        return AuvApiResult.success(list);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to get chat list',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 获取聊天历史
  /// 
  /// 获取与指定用户的私聊消息历史记录
  /// 
  /// [oderId] 订单ID或会话ID（必填），用于标识聊天会话
  /// [page] 页码（可选），默认1
  /// [pageSize] 每页数量（可选），默认50
  /// 
  /// 返回值: 聊天消息列表
  Future<AuvApiResult<List<AuvChatMessage>>> getChatHistory(
    String oderId, {
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final response = await _api.get(
        AuvApiRoutes.chatHistory,
        queryParameters: {
          'oder_id': oderId,
          'page': page,
          'page_size': pageSize,
        },
      );

      if (response.data['code'] == 200) {
        final List<AuvChatMessage> list = (response.data['data']['list'] as List)
            .map((e) => AuvChatMessage.fromJson(e))
            .toList();
        return AuvApiResult.success(list);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to get chat history',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 发送消息
  /// 
  /// 向指定用户发送文本消息
  /// 
  /// [receiverId] 接收者用户ID（必填）
  /// [content] 消息内容（必填）
  /// [type] 消息类型（可选），默认文本消息
  /// 
  /// 返回值: 发送成功的消息对象
  Future<AuvApiResult<AuvChatMessage>> sendMessage({
    required String receiverId,
    required String content,
    AuvMessageType type = AuvMessageType.text,
  }) async {
    try {
      final response = await _api.post(
        AuvApiRoutes.sendMessage,
        data: {
          'receiver_id': receiverId,
          'content': content,
          'type': type.name,
        },
      );

      if (response.data['code'] == 200) {
        return AuvApiResult.success(AuvChatMessage.fromJson(response.data['data']));
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to send message',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 发送图片消息
  /// 
  /// 向指定用户发送图片消息
  /// 
  /// [receiverId] 接收者用户ID（必填）
  /// [filePath] 图片文件路径（必填），本地图片的绝对路径
  /// 
  /// 返回值: 发送成功的消息对象
  Future<AuvApiResult<AuvChatMessage>> sendImageMessage({
    required String receiverId,
    required String filePath,
  }) async {
    try {
      final formData = dio.FormData.fromMap({
        'receiver_id': receiverId,
        'type': AuvMessageType.image.name,
        'file': await dio.MultipartFile.fromFile(filePath),
      });

      final response = await _api.post(
        AuvApiRoutes.sendMessage,
        data: formData,
        options: dio.Options(contentType: 'multipart/form-data'),
      );

      if (response.data['code'] == 200) {
        return AuvApiResult.success(AuvChatMessage.fromJson(response.data['data']));
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to send image',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }
}
