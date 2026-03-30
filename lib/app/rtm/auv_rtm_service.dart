import 'dart:async';
import 'package:get/get.dart';
import 'package:slea_auv/app/rtm/auv_rtm_message.dart';
import 'package:slea_auv/app/rtm/auv_rtm_message_type.dart';

/// RTM 事件回调
abstract class AuvRtmListener {
  void onMessageReceived(AuvRtmMessage message);
  void onCallInviteReceived(AuvRtmMessage message);
  void onGiftReceived(AuvRtmMessage message);
  void onNotificationReceived(AuvRtmMessage message);
  void onConnectionStateChanged(int state, int reason);
  void onPeersOnlineStatusChanged(Map<String, bool> status);
}

/// RTM 服务
/// 负责声网 RTM 实时消息通信
class AuvRtmService extends GetxService {
  final _listeners = <AuvRtmListener>{};
  final _messageController = StreamController<AuvRtmMessage>.broadcast();
  final _onlineStatus = <String, bool>{}.obs;

  Stream<AuvRtmMessage> get messageStream => _messageController.stream;
  Map<String, bool> get onlineStatus => _onlineStatus;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// 初始化 RTM
  /// [userId] 用户ID
  /// [onSuccess] 初始化成功回调
  /// [onError] 初始化失败回调
  Future<bool> init(
    String userId, {
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    try {
      // TODO: 初始化声网 RTM SDK
      // RtmClient.create(appId);
      // await rtmClient.login(token, userId);

      _isInitialized = true;
      onSuccess?.call();
      return true;
    } catch (e) {
      _isInitialized = false;
      onError?.call(e.toString());
      return false;
    }
  }

  /// 发送点对点消息
  Future<bool> sendMessage(AuvSendMessageRequest request) async {
    if (!_isInitialized) return false;

    try {
      final message = AuvRtmMessage(
        messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        messageType: request.messageType.value,
        text: request.text,
        imageUrl: request.localPath,
        receiverId: request.receiverId,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        extra: request.extra,
      );

      // TODO: 调用声网 SDK 发送消息
      // await rtmClient.sendMessageToPeer(request.receiverId, rtmMessage);

      _messageController.add(message);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 发送文本消息
  Future<bool> sendTextMessage(String peerId, String text) {
    return sendMessage(AuvSendMessageRequest(
      receiverId: peerId,
      messageType: AuvRtmMessageType.text,
      text: text,
    ));
  }

  /// 发送图片消息
  Future<bool> sendImageMessage(String peerId, String localPath, {String? imageUrl}) {
    return sendMessage(AuvSendMessageRequest(
      receiverId: peerId,
      messageType: AuvRtmMessageType.image,
      localPath: localPath,
      extra: imageUrl != null ? {'imageUrl': imageUrl} : null,
    ));
  }

  /// 发送语音消息
  Future<bool> sendVoiceMessage(String peerId, String localPath, int duration) {
    return sendMessage(AuvSendMessageRequest(
      receiverId: peerId,
      messageType: AuvRtmMessageType.voice,
      localPath: localPath,
      extra: {'duration': duration},
    ));
  }

  /// 发送礼物消息
  Future<bool> sendGiftMessage(String peerId, AuvGiftExtra gift) {
    return sendMessage(AuvSendMessageRequest(
      receiverId: peerId,
      messageType: AuvRtmMessageType.gift,
      extra: gift.toJson(),
    ));
  }

  /// 发送通话消息
  Future<bool> sendCallMessage(String peerId, AuvCallExtra call) {
    return sendMessage(AuvSendMessageRequest(
      receiverId: peerId,
      messageType: AuvRtmMessageType.call,
      extra: call.toJson(),
    ));
  }

  /// 发送开始通话消息
  Future<bool> sendBeginCall(String peerId, String channelId, int callType) {
    return sendMessage(AuvSendMessageRequest(
      receiverId: peerId,
      messageType: AuvRtmMessageType.beginCall,
      extra: AuvCallExtra(
        channelId: channelId,
        callType: callType,
      ).toJson(),
    ));
  }

  /// 发送通话失败消息
  Future<bool> sendFailCall(String peerId, String channelId, int callType) {
    return sendMessage(AuvSendMessageRequest(
      receiverId: peerId,
      messageType: AuvRtmMessageType.failCall,
      extra: AuvCallExtra(
        channelId: channelId,
        callType: callType,
      ).toJson(),
    ));
  }

  /// 发送通话结算消息
  Future<bool> sendSettlementCall(
    String peerId,
    String channelId,
    int duration,
    int fee,
  ) {
    return sendMessage(AuvSendMessageRequest(
      receiverId: peerId,
      messageType: AuvRtmMessageType.settlementCall,
      extra: AuvCallExtra(
        channelId: channelId,
        callType: 0,
        duration: duration,
        fee: fee,
      ).toJson(),
    ));
  }

  /// 查询用户在线状态
  Future<Map<String, bool>> queryPeersOnlineStatus(List<String> peerIds) async {
    if (!_isInitialized) return {};

    try {
      // TODO: 调用声网 SDK 查询在线状态
      // final result = await rtmClient.queryPeersOnlineStatus(peerIds);
      // _onlineStatus.addAll(result);
      return _onlineStatus;
    } catch (e) {
      return {};
    }
  }

  /// 添加监听器
  void addListener(AuvRtmListener listener) {
    _listeners.add(listener);
  }

  /// 移除监听器
  void removeListener(AuvRtmListener listener) {
    _listeners.remove(listener);
  }

  /// 处理收到的消息（由 SDK 回调触发）
  void handleReceivedMessage(AuvRtmMessage message) {
    _messageController.add(message);

    for (final listener in _listeners) {
      final type = message.type;
      if (type.isCallMessage) {
        listener.onCallInviteReceived(message);
      } else if (type.isGiftMessage) {
        listener.onGiftReceived(message);
      } else if (type.isNotification || type.isLiveMessage) {
        listener.onNotificationReceived(message);
      } else {
        listener.onMessageReceived(message);
      }
    }
  }

  /// 处理连接状态变化（由 SDK 回调触发）
  void handleConnectionStateChanged(int state, int reason) {
    for (final listener in _listeners) {
      listener.onConnectionStateChanged(state, reason);
    }
  }

  /// 处理在线状态变化（由 SDK 回调触发）
  void handlePeersOnlineStatusChanged(Map<String, bool> status) {
    _onlineStatus.addAll(status);
    for (final listener in _listeners) {
      listener.onPeersOnlineStatusChanged(status);
    }
  }

  /// 登出
  Future<void> logout() async {
    if (!_isInitialized) return;

    try {
      // TODO: 调用声网 SDK 登出
      // await rtmClient.logout();
    } finally {
      _isInitialized = false;
    }
  }

  @override
  void onClose() {
    logout();
    _messageController.close();
    super.onClose();
  }
}
