import '../enums/auv_moment.dart';
import 'auv_comment_model.dart';
import 'auv_user_model.dart';

/// 动态通知类型
enum AuvMomentNoticeType {
  momentLike(1),      // 动态点赞
  commentLike(2),     // 评论点赞
  momentComment(3),   // 动态评论
  replyComment(4);    // 回复评论

  final int value;
  const AuvMomentNoticeType(this.value);

  static AuvMomentNoticeType? fromValue(int value) {
    return AuvMomentNoticeType.values.where((e) => e.value == value).firstOrNull;
  }
}

/// 动态通知查询条件
class AuvMomentNoticeCondition {
  final List<int>? noticeTypes; // 通知类型列表

  AuvMomentNoticeCondition({this.noticeTypes});

  Map<String, dynamic> toJson() {
    return {
      if (noticeTypes != null) 'noticeTypes': noticeTypes,
    };
  }
}

/// 动态通知请求
class AuvMomentNoticeRequest {
  final int pageNum;
  final int pageSize;
  final AuvMomentNoticeCondition? condition;

  AuvMomentNoticeRequest({
    required this.pageNum,
    required this.pageSize,
    this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      if (condition != null) 'condition': condition!.toJson(),
    };
  }
}

/// 动态媒体信息
class AuvMomentNoticeMedia {
  final int scaleType;      // 资源尺度，1.正常尺度，2.大尺度，3.危险
  final String mediaUrl;    // 资源链接
  final int? imageWidth;    // 图片宽度
  final int? imageHeight;   // 图片高度

  AuvMomentNoticeMedia({
    required this.scaleType,
    required this.mediaUrl,
    this.imageWidth,
    this.imageHeight,
  });

  factory AuvMomentNoticeMedia.fromJson(Map<String, dynamic> json) {
    return AuvMomentNoticeMedia(
      scaleType: json['scaleType'] ?? 1,
      mediaUrl: json['mediaUrl'] ?? '',
      imageWidth: json['imageWidth'],
      imageHeight: json['imageHeight'],
    );
  }

  /// 是否正常尺度
  bool get isNormal => scaleType == 1;

  /// 是否大尺度
  bool get isLargeScale => scaleType == 2;

  /// 是否危险
  bool get isDangerous => scaleType == 3;
}

/// 动态通知项
class AuvMomentNoticeItem {
  final int noticeId;           // 通知id
  final int momentId;           // 动态id
  final int? commentId;         // 评论id
  final int noticeType;         // 动态通知类型，1.动态点赞，2.评论点赞，3.动态评论，4.回复评论
  final int momentUserId;       // 动态归属用户id
  final int actionUserId;       // 发起用户id
  final String actionNickname;  // 发起用户昵称
  final String actionPortrait;  // 发起用户头像
  final int actionIsOnline;     // 发起用户是否在线，0.离线，1.在线，2.忙线
  final String commentContent;  // 评论内容
  final int replyFlag;          // 是否已回复当前评论，0.否，1.是
  final int userLevel;          // 用户等级
  final bool vipFlag;           // 是否vip
  final int createdAt;          // 通知时间
  final AuvMomentNoticeMedia? medias; // 媒体信息

  AuvMomentNoticeItem({
    required this.noticeId,
    required this.momentId,
    this.commentId,
    required this.noticeType,
    required this.momentUserId,
    required this.actionUserId,
    required this.actionNickname,
    required this.actionPortrait,
    required this.actionIsOnline,
    required this.commentContent,
    required this.replyFlag,
    required this.userLevel,
    required this.vipFlag,
    required this.createdAt,
    this.medias,
  });

  factory AuvMomentNoticeItem.fromJson(Map<String, dynamic> json) {
    return AuvMomentNoticeItem(
      noticeId: json['noticeId'] ?? 0,
      momentId: json['momentId'] ?? 0,
      commentId: json['commentId'],
      noticeType: json['noticeType'] ?? 1,
      momentUserId: json['momentUserId'] ?? 0,
      actionUserId: json['actionUserId'] ?? 0,
      actionNickname: json['actionNickname'] ?? '',
      actionPortrait: json['actionPortrait'] ?? '',
      actionIsOnline: json['actionIsOnline'] ?? 0,
      commentContent: json['commentContent'] ?? '',
      replyFlag: json['replyFlag'] ?? 0,
      userLevel: json['userLevel'] ?? 0,
      vipFlag: json['vipFlag'] ?? false,
      createdAt: json['createdAt'] ?? 0,
      medias: json['medias'] != null ? AuvMomentNoticeMedia.fromJson(json['medias']) : null,
    );
  }

  /// 获取通知类型枚举
  AuvMomentNoticeType? get noticeTypeEnum => AuvMomentNoticeType.fromValue(noticeType);

  /// 获取通知类型描述
  String get noticeTypeName {
    switch (noticeType) {
      case 1: return '动态点赞';
      case 2: return '评论点赞';
      case 3: return '动态评论';
      case 4: return '回复评论';
      default: return '未知';
    }
  }

  /// 是否在线
  bool get isActionUserOnline => actionIsOnline == 1;

  /// 是否忙碌
  bool get isActionUserBusy => actionIsOnline == 2;

  /// 是否已回复
  bool get hasReplied => replyFlag == 1;

  /// 获取通知时间
  DateTime? get noticeTime {
    if (createdAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt);
  }

  /// 是否有媒体
  bool get hasMedia => medias != null && medias!.mediaUrl.isNotEmpty;
}

/// 动态通知列表响应
class AuvMomentNoticeResponse {
  final int total;
  final List<AuvMomentNoticeItem> list;
  final int pageNum;
  final int pageSize;
  final int pages;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final bool isFirstPage;
  final bool isLastPage;

  AuvMomentNoticeResponse({
    required this.total,
    required this.list,
    required this.pageNum,
    required this.pageSize,
    required this.pages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.isFirstPage,
    required this.isLastPage,
  });

  factory AuvMomentNoticeResponse.fromJson(Map<String, dynamic> json) {
    final listData = json['list'] ?? [];
    return AuvMomentNoticeResponse(
      total: json['total'] ?? 0,
      list: (listData as List).map((e) => AuvMomentNoticeItem.fromJson(e)).toList(),
      pageNum: json['pageNum'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      pages: json['pages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      isFirstPage: json['isFirstPage'] ?? true,
      isLastPage: json['isLastPage'] ?? true,
    );
  }

  bool get isEmpty => list.isEmpty;
}

/// 动态列表查询类型
enum AuvMomentQueryType {
  hot(1),    // 热门
  newMoment(2), // 最新
  follow(3); // 关注

  final int value;
  const AuvMomentQueryType(this.value);

  static AuvMomentQueryType? fromValue(int value) {
    return AuvMomentQueryType.values.where((e) => e.value == value).firstOrNull;
  }
}

/// 动态列表查询条件V2
class AuvMomentQueryConditionV2 {
  final int? queryType;      // 查询类型，1.hot，2.new，3.follow
  final int? anchorUserId;   // 查询单个主播id
  final int? topMomentId;    // 要置顶的动态id

  AuvMomentQueryConditionV2({
    this.queryType,
    this.anchorUserId,
    this.topMomentId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (queryType != null) 'queryType': queryType,
      if (anchorUserId != null) 'anchorUserId': anchorUserId,
      if (topMomentId != null) 'topMomentId': topMomentId,
    };
  }
}

/// 动态列表查询条件Hot
class AuvMomentQueryConditionHot {
  final int? firstQuery;     // 是否首次查询，0.非首次，1.首次
  final int? onlineQuery;    // 是否查在线主播，0.查离线，1.查在线
  final int? areaCode;       // 地区编码，-1为其他

  AuvMomentQueryConditionHot({
    this.firstQuery,
    this.onlineQuery,
    this.areaCode,
  });

  Map<String, dynamic> toJson() {
    return {
      if (firstQuery != null) 'firstQuery': firstQuery,
      if (onlineQuery != null) 'onlineQuery': onlineQuery,
      if (areaCode != null) 'areaCode': areaCode,
    };
  }
}

/// 动态列表请求基础类
class AuvMomentListRequest {
  final int pageNum;
  final int pageSize;
  final Map<String, dynamic>? condition;

  AuvMomentListRequest({
    required this.pageNum,
    required this.pageSize,
    this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      if (condition != null) 'condition': condition,
    };
  }
}

/// 用户端动态列表项
class AuvUserMomentItem {
  final int momentId;              // 动态id
  final int userId;               // 主播id
  final int? isOnline;            // 是否在线，0.离线，1.在线，2.忙线（仅hot接口返回）
  final String nickname;          // 昵称
  final String portrait;          // 头像
  final int countryCode;          // 国家编码
  final String countryPath;       // 国旗链接
  final String countryTitle;      // 国家名
  final AuvUserLevelConfig? levelConfig; // 等级信息
  final int visibleType;          // 可见范围，0.公开，1.仅付费用户
  final String content;          // 文字内容
  final int praiseCount;         // 点赞数
  final int commentCount;        // 评论数
  final int clickCount;          // 点击量
  final int createdAt;           // 发布时间
  final int praiseFlag;          // 是否点赞，0.否，1.是
  final AuvMomentNoticeMedia? medias; // 媒体信息

  AuvUserMomentItem({
    required this.momentId,
    required this.userId,
    this.isOnline,
    required this.nickname,
    required this.portrait,
    required this.countryCode,
    required this.countryPath,
    required this.countryTitle,
    this.levelConfig,
    required this.visibleType,
    required this.content,
    required this.praiseCount,
    required this.commentCount,
    required this.clickCount,
    required this.createdAt,
    required this.praiseFlag,
    this.medias,
  });

  factory AuvUserMomentItem.fromJson(Map<String, dynamic> json) {
    return AuvUserMomentItem(
      momentId: json['momentId'] ?? 0,
      userId: json['userId'] ?? 0,
      isOnline: json['isOnline'],
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      visibleType: json['visibleType'] ?? 0,
      content: json['content'] ?? '',
      praiseCount: json['praiseCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      clickCount: json['clickCount'] ?? 0,
      createdAt: json['createdAt'] ?? 0,
      praiseFlag: json['praiseFlag'] ?? 0,
      medias: json['medias'] != null ? AuvMomentNoticeMedia.fromJson(json['medias']) : null,
    );
  }

  /// 是否公开
  bool get isPublic => visibleType == 0;

  /// 是否仅付费可见
  bool get isPaidOnly => visibleType == 1;

  /// 是否已点赞
  bool get isPraised => praiseFlag == 1;

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙碌
  bool get isUserBusy => isOnline == 2;

  /// 获取发布时间
  DateTime? get publishTime {
    if (createdAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt);
  }

  /// 是否有媒体
  bool get hasMedia => medias != null && medias!.mediaUrl.isNotEmpty;
}

/// 动态列表响应
class AuvUserMomentListResponse {
  final int total;
  final List<AuvUserMomentItem> list;
  final int pageNum;
  final int pageSize;
  final int pages;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final bool isFirstPage;
  final bool isLastPage;

  AuvUserMomentListResponse({
    required this.total,
    required this.list,
    required this.pageNum,
    required this.pageSize,
    required this.pages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.isFirstPage,
    required this.isLastPage,
  });

  factory AuvUserMomentListResponse.fromJson(Map<String, dynamic> json) {
    final listData = json['list'] ?? [];
    return AuvUserMomentListResponse(
      total: json['total'] ?? 0,
      list: (listData as List).map((e) => AuvUserMomentItem.fromJson(e)).toList(),
      pageNum: json['pageNum'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      pages: json['pages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      isFirstPage: json['isFirstPage'] ?? true,
      isLastPage: json['isLastPage'] ?? true,
    );
  }

  bool get isEmpty => list.isEmpty;
}

/// 动态审核状态
enum AuvMomentStatus {
  pending(0),    // 待审核
  approved(1),    // 审核通过
  rejected(2);   // 审核失败

  final int value;
  const AuvMomentStatus(this.value);

  static AuvMomentStatus? fromValue(int value) {
    return AuvMomentStatus.values.where((e) => e.value == value).firstOrNull;
  }
}

/// 关注状态
enum AuvFollowFlag {
  notFollowed(1),   // 未关注
  followed(2),      // 已关注
  friend(3);        // 好友

  final int value;
  const AuvFollowFlag(this.value);

  static AuvFollowFlag? fromValue(int value) {
    return AuvFollowFlag.values.where((e) => e.value == value).firstOrNull;
  }
}

/// 单条动态详情（附带第一页评论）
class AuvMomentDetailWithComment {
  final int momentId;              // 动态id
  final int userId;               // 主播id
  final int momentStatus;         // 审核状态，0.待审核，1.审核通过，2.审核失败
  final String nickname;          // 昵称
  final String portrait;          // 头像
  final int countryCode;          // 国家编码
  final String countryPath;       // 国旗链接
  final String countryTitle;      // 国家名
  final AuvUserLevelConfig? levelConfig; // 等级信息
  final int visibleType;          // 可见范围，0.公开，1.仅付费用户
  final String content;           // 文字内容
  final int praiseCount;          // 点赞数
  final int commentCount;         // 评论数
  final int clickCount;           // 点击量
  final int showCount;            // 展示次数
  final int createdAt;            // 发布时间
  final int praiseFlag;           // 是否点赞，0.否，1.是
  final int followFlag;           // 是否关注，1.未关注，2.已关注，3.好友
  final List<AuvMomentNoticeMedia>? medias; // 媒体信息列表
  final bool commentHasNextPage;  // 是否有下一页评论
  final List<AuvCommentItem>? comments; // 评论列表

  AuvMomentDetailWithComment({
    required this.momentId,
    required this.userId,
    required this.momentStatus,
    required this.nickname,
    required this.portrait,
    required this.countryCode,
    required this.countryPath,
    required this.countryTitle,
    this.levelConfig,
    required this.visibleType,
    required this.content,
    required this.praiseCount,
    required this.commentCount,
    required this.clickCount,
    required this.showCount,
    required this.createdAt,
    required this.praiseFlag,
    required this.followFlag,
    this.medias,
    required this.commentHasNextPage,
    this.comments,
  });

  factory AuvMomentDetailWithComment.fromJson(Map<String, dynamic> json) {
    return AuvMomentDetailWithComment(
      momentId: json['momentId'] ?? 0,
      userId: json['userId'] ?? 0,
      momentStatus: json['momentStatus'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      visibleType: json['visibleType'] ?? 0,
      content: json['content'] ?? '',
      praiseCount: json['praiseCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      clickCount: json['clickCount'] ?? 0,
      showCount: json['showCount'] ?? 0,
      createdAt: json['createdAt'] ?? 0,
      praiseFlag: json['praiseFlag'] ?? 0,
      followFlag: json['followFlag'] ?? 1,
      medias: json['medias'] != null
          ? (json['medias'] as List).map((e) => AuvMomentNoticeMedia.fromJson(e)).toList()
          : null,
      commentHasNextPage: json['commentHasNextPage'] ?? false,
      comments: json['comments'] != null
          ? (json['comments'] as List).map((e) => AuvCommentItem.fromJson(e)).toList()
          : null,
    );
  }

  /// 获取审核状态枚举
  AuvMomentStatus? get status => AuvMomentStatus.fromValue(momentStatus);

  /// 获取关注状态枚举
  AuvFollowFlag? get followStatus => AuvFollowFlag.fromValue(followFlag);

  /// 是否公开
  bool get isPublic => visibleType == 0;

  /// 是否仅付费可见
  bool get isPaidOnly => visibleType == 1;

  /// 是否已点赞
  bool get isPraised => praiseFlag == 1;

  /// 是否已关注
  bool get isFollowed => followFlag >= 2;

  /// 是否是好友
  bool get isFriend => followFlag == 3;

  /// 获取发布时间
  DateTime? get publishTime {
    if (createdAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt);
  }

  /// 是否有媒体
  bool get hasMedia => medias != null && medias!.isNotEmpty;
}

/// 流量最高动态项
class AuvTopShowMomentItem {
  final int momentId;   // 动态id
  final int userId;     // 主播id
  final String nickname; // 昵称
  final int showCount;  // 展示次数

  AuvTopShowMomentItem({
    required this.momentId,
    required this.userId,
    required this.nickname,
    required this.showCount,
  });

  factory AuvTopShowMomentItem.fromJson(Map<String, dynamic> json) {
    return AuvTopShowMomentItem(
      momentId: json['momentId'] ?? 0,
      userId: json['userId'] ?? 0,
      nickname: json['nickname'] ?? '',
      showCount: json['showCount'] ?? 0,
    );
  }
}

/// 主播动态简单项
class AuvAnchorSimpleMomentVo {
  final int momentId;         // 动态id
  final int visibleType;      // 可见范围，0.公开，1.仅付费用户
  final int reviewScale;      // 审核模式尺度，1.正常尺度，2.大尺度
  final int scaleType;       // 资源尺度，1.正常尺度，2.大尺度，3.危险
  final String mediaUrl;      // 资源链接
  final int? imageWidth;      // 图片宽度
  final int? imageHeight;     // 图片高度

  AuvAnchorSimpleMomentVo({
    required this.momentId,
    required this.visibleType,
    required this.reviewScale,
    required this.scaleType,
    required this.mediaUrl,
    this.imageWidth,
    this.imageHeight,
  });

  factory AuvAnchorSimpleMomentVo.fromJson(Map<String, dynamic> json) {
    return AuvAnchorSimpleMomentVo(
      momentId: json['momentId'] ?? 0,
      visibleType: json['visibleType'] ?? 0,
      reviewScale: json['reviewScale'] ?? 1,
      scaleType: json['scaleType'] ?? 1,
      mediaUrl: json['mediaUrl'] ?? '',
      imageWidth: json['imageWidth'],
      imageHeight: json['imageHeight'],
    );
  }

  /// 是否公开
  bool get isPublic => visibleType == 0;

  /// 是否仅付费可见
  bool get isPaidOnly => visibleType == 1;

  /// 是否大尺度
  bool get isLargeScale => scaleType == 2;

  /// 是否危险
  bool get isDangerous => scaleType == 3;
}
