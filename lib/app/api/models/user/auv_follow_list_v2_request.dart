import 'auv_follow_list_request.dart';

/// 关注列表V2请求模型
class AuvFollowListV2Request {
  final int type;

  AuvFollowListV2Request({required this.type});

  Map<String, dynamic> toJson() => {'type': type};
}
