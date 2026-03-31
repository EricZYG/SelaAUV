import '../enums/auv_match_status.dart';
import '../enums/auv_call.dart';
import '../enums/auv_msg_type.dart';
import '../enums/auv_message_type.dart';

/// 匹配模型
class AuvMatchModel {
  final String id;
  final String oderId;
  final String oderName;
  final String? oderAvatar;
  final int duration; // 通话时长(秒)
  final DateTime matchedAt;
  final AuvMatchStatus status;

  AuvMatchModel({
    required this.id,
    required this.oderId,
    required this.oderName,
    this.oderAvatar,
    required this.duration,
    required this.matchedAt,
    required this.status,
  });

  factory AuvMatchModel.fromJson(Map<String, dynamic> json) {
    return AuvMatchModel(
      id: json['id'] ?? '',
      oderId: json['oder_id'] ?? '',
      oderName: json['oder_name'] ?? '',
      oderAvatar: json['oder_avatar'],
      duration: json['duration'] ?? 0,
      matchedAt: json['matched_at'] != null
          ? DateTime.parse(json['matched_at'])
          : DateTime.now(),
      status: AuvMatchStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AuvMatchStatus.pending,
      ),
    );
  }
}

/// 聊天消息模型
class AuvChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final AuvMessageType type;
  final DateTime createdAt;
  final bool isRead;

  AuvChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });

  factory AuvChatMessage.fromJson(Map<String, dynamic> json) {
    return AuvChatMessage(
      id: json['id'] ?? '',
      senderId: json['sender_id'] ?? '',
      receiverId: json['receiver_id'] ?? '',
      content: json['content'] ?? '',
      type: AuvMessageType.values.firstWhere(
        (e) => e.value == json['type'],
        orElse: () => AuvMessageType.text,
      ),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      isRead: json['is_read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
      'type': type.value,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
    };
  }
}

/// 通话记录模型
class AuvCallRecord {
  final String id;
  final String callerId;
  final String callerName;
  final String? callerAvatar;
  final String calleeId;
  final String calleeName;
  final String? calleeAvatar;
  final AuvCallType type;
  final int duration; // 通话时长(秒)
  final AuvCallStatus status;
  final DateTime createdAt;

  AuvCallRecord({
    required this.id,
    required this.callerId,
    required this.callerName,
    this.callerAvatar,
    required this.calleeId,
    required this.calleeName,
    this.calleeAvatar,
    required this.type,
    required this.duration,
    required this.status,
    required this.createdAt,
  });

  factory AuvCallRecord.fromJson(Map<String, dynamic> json) {
    return AuvCallRecord(
      id: json['id'] ?? '',
      callerId: json['caller_id'] ?? '',
      callerName: json['caller_name'] ?? '',
      callerAvatar: json['caller_avatar'],
      calleeId: json['callee_id'] ?? '',
      calleeName: json['callee_name'] ?? '',
      calleeAvatar: json['callee_avatar'],
      type: AuvCallType.fromValue(json['type'] ?? 2),
      duration: json['duration'] ?? 0,
      status: AuvCallStatus.fromValue(json['status'] ?? 0),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }
}

/// 充值商品模型
class AuvProduct {
  final String id;
  final String name;
  final String description;
  final int coins;
  final int originalPrice; // 原价(分)
  final int price; // 现价(分)
  final bool isHot;
  final bool isRecommended;

  AuvProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.coins,
    required this.originalPrice,
    required this.price,
    this.isHot = false,
    this.isRecommended = false,
  });

  factory AuvProduct.fromJson(Map<String, dynamic> json) {
    return AuvProduct(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coins: json['coins'] ?? 0,
      originalPrice: json['original_price'] ?? 0,
      price: json['price'] ?? 0,
      isHot: json['is_hot'] ?? false,
      isRecommended: json['is_recommended'] ?? false,
    );
  }
}

/// 充值记录模型
class AuvRechargeRecord {
  final String id;
  final int coins;
  final int amount; // 金额(分)
  final String orderId;
  final String status;
  final DateTime createdAt;

  AuvRechargeRecord({
    required this.id,
    required this.coins,
    required this.amount,
    required this.orderId,
    required this.status,
    required this.createdAt,
  });

  factory AuvRechargeRecord.fromJson(Map<String, dynamic> json) {
    return AuvRechargeRecord(
      id: json['id'] ?? '',
      coins: json['coins'] ?? 0,
      amount: json['amount'] ?? 0,
      orderId: json['order_id'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }
}

/// VIP 套餐模型
class AuvVipPlan {
  final String id;
  final String name;
  final int months;
  final int originalPrice;
  final int price;
  final List<String> benefits;

  AuvVipPlan({
    required this.id,
    required this.name,
    required this.months,
    required this.originalPrice,
    required this.price,
    required this.benefits,
  });

  factory AuvVipPlan.fromJson(Map<String, dynamic> json) {
    return AuvVipPlan(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      months: json['months'] ?? 0,
      originalPrice: json['original_price'] ?? 0,
      price: json['price'] ?? 0,
      benefits: List<String>.from(json['benefits'] ?? []),
    );
  }
}
