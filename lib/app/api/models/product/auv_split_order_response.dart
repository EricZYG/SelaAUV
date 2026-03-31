import 'auv_split_record_response.dart';

/// 分次订单领取记录模型
class AuvSplitOrderResponse {
  /// 订单id
  final int? orderId;

  /// 折扣（10表示10% OFF）
  final int? discount;

  /// 总钻石数（小数点后两位）
  final int? diamonds;

  /// 分次领取记录列表
  final List<AuvSplitRecordResponse>? records;

  AuvSplitOrderResponse({
    this.orderId,
    this.discount,
    this.diamonds,
    this.records,
  });

  factory AuvSplitOrderResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvSplitOrderResponse();
    return AuvSplitOrderResponse(
      orderId: json['orderId'],
      discount: json['discount'],
      diamonds: json['diamonds'],
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => AuvSplitRecordResponse.fromJson(e))
          .toList(),
    );
  }

  /// 获取总钻石显示
  String get totalDiamondsDisplay {
    if (diamonds == null) return '0';
    return (diamonds! / 100).toStringAsFixed(0);
  }

  /// 获取折扣描述
  String get discountDesc {
    if (discount == null || discount! <= 0) return '无折扣';
    return '${discount}% OFF';
  }

  /// 获取可领取记录数
  int get claimableCount {
    if (records == null) return 0;
    return records!.where((r) => r.canClaim).length;
  }

  /// 获取已领取记录数
  int get claimedCount {
    if (records == null) return 0;
    return records!.where((r) => r.splitStatus == AuvSplitStatus.claimed.value).length;
  }
}
