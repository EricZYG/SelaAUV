/// 标签列表项
class AuvTopicTagItemResponse {
  /// 标签ID
  final int id;

  /// 标签名称
  final String tag;

  /// 排序
  final int sort;

  /// 是否关注（0 没关注，1 关注）
  final int isFollow;

  /// 用户设置的排序
  final int? userSort;

  AuvTopicTagItemResponse({
    required this.id,
    required this.tag,
    required this.sort,
    required this.isFollow,
    this.userSort,
  });

  factory AuvTopicTagItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopicTagItemResponse(
        id: 0,
        tag: '',
        sort: 0,
        isFollow: 0,
        userSort: null,
      );
    }
    return AuvTopicTagItemResponse(
      id: json['id'] as int? ?? 0,
      tag: json['tag'] as String? ?? '',
      sort: json['sort'] as int? ?? 0,
      isFollow: json['isFollow'] as int? ?? 0,
      userSort: json['userSort'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag': tag,
      'sort': sort,
      'isFollow': isFollow,
      if (userSort != null) 'userSort': userSort,
    };
  }
}

/// 话题媒体项
class AuvTopicMediaItem {
  /// 媒体ID
  final int mediaId;

  /// 媒体类型
  final int mediaType;

  /// 可见类型
  final int? visibleType;

  /// 缩放类型
  final int? scaleType;

  /// 媒体URL
  final String? mediaUrl;

  /// 视频封面
  final String? videoCover;

  /// 图片宽度
  final int? imageWidth;

  /// 图片高度
  final int? imageHeight;

  AuvTopicMediaItem({
    required this.mediaId,
    required this.mediaType,
    this.visibleType,
    this.scaleType,
    this.mediaUrl,
    this.videoCover,
    this.imageWidth,
    this.imageHeight,
  });

  factory AuvTopicMediaItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopicMediaItem(
        mediaId: 0,
        mediaType: 0,
      );
    }
    return AuvTopicMediaItem(
      mediaId: json['mediaId'] as int? ?? 0,
      mediaType: json['mediaType'] as int? ?? 0,
      visibleType: json['visibleType'] as int?,
      scaleType: json['scaleType'] as int?,
      mediaUrl: json['mediaUrl'] as String?,
      videoCover: json['videoCover'] as String?,
      imageWidth: json['imageWidth'] as int?,
      imageHeight: json['imageHeight'] as int?,
    );
  }
}

/// 话题动态项
class AuvTopicMomentItem {
  /// 动态ID
  final int momentId;

  /// 用户ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String? portrait;

  /// 年龄
  final int? age;

  /// 国家代码
  final String? countryCode;

  /// 国家标题
  final String? countryTitle;

  /// 内容
  final String? content;

  /// 点赞数量
  final int praiseCount;

  /// 评论数量
  final int commentCount;

  /// 点击量
  final int clickCount;

  /// 是否点赞（0否，1是）
  final int praiseFlag;

  /// 动态的主题列表
  final List<String>? topicIdList;

  /// 话题ID字符串
  final String? topicIds;

  /// 创建时间
  final int createdAt;

  /// 媒体列表
  final List<AuvTopicMediaItem>? medias;

  AuvTopicMomentItem({
    required this.momentId,
    required this.userId,
    required this.nickname,
    this.portrait,
    this.age,
    this.countryCode,
    this.countryTitle,
    this.content,
    required this.praiseCount,
    required this.commentCount,
    required this.clickCount,
    required this.praiseFlag,
    this.topicIdList,
    this.topicIds,
    required this.createdAt,
    this.medias,
  });

  factory AuvTopicMomentItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopicMomentItem(
        momentId: 0,
        userId: 0,
        nickname: '',
        praiseCount: 0,
        commentCount: 0,
        clickCount: 0,
        praiseFlag: 0,
        createdAt: 0,
      );
    }
    return AuvTopicMomentItem(
      momentId: json['momentId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String?,
      age: json['age'] as int?,
      countryCode: json['countryCode'] as String?,
      countryTitle: json['countryTitle'] as String?,
      content: json['content'] as String?,
      praiseCount: json['praiseCount'] as int? ?? 0,
      commentCount: json['commentCount'] as int? ?? 0,
      clickCount: json['clickCount'] as int? ?? 0,
      praiseFlag: json['praiseFlag'] as int? ?? 0,
      topicIdList: (json['topicIdList'] as List<dynamic>?)?.cast<String>(),
      topicIds: json['topicIds'] as String?,
      createdAt: json['createdAt'] as int? ?? 0,
      medias: (json['medias'] as List<dynamic>?)
          ?.map((e) => AuvTopicMediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 话题项
class AuvTopicItemResponse {
  /// 话题ID
  final int topicId;

  /// 标签ID
  final int tagId;

  /// 标题
  final String title;

  /// 状态
  final int status;

  /// 图标
  final String? icon;

  /// 内容
  final String? content;

  /// 动态数量
  final String? momentCount;

  /// 点击量
  final int? clickCount;

  /// 第一个动态ID
  final int? firstMomentId;

  /// 创建时间
  final int createdAt;

  /// 第一个动态
  final AuvTopicMomentItem? moment;

  AuvTopicItemResponse({
    required this.topicId,
    required this.tagId,
    required this.title,
    required this.status,
    this.icon,
    this.content,
    this.momentCount,
    this.clickCount,
    this.firstMomentId,
    required this.createdAt,
    this.moment,
  });

  factory AuvTopicItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopicItemResponse(
        topicId: 0,
        tagId: 0,
        title: '',
        status: 0,
        createdAt: 0,
      );
    }
    return AuvTopicItemResponse(
      topicId: json['topicId'] as int? ?? 0,
      tagId: json['tagId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      icon: json['icon'] as String?,
      content: json['content'] as String?,
      momentCount: json['momentCount'] as String?,
      clickCount: json['clickCount'] as int?,
      firstMomentId: json['firstMomentId'] as int?,
      createdAt: json['createdAt'] as int? ?? 0,
      moment: json['moment'] != null
          ? AuvTopicMomentItem.fromJson(json['moment'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// 话题分页查询条件
class AuvTopicCondition {
  /// 标签ID
  final int? tagId;

  /// 排序方式（0热门，1最新）
  final int order;

  AuvTopicCondition({
    this.tagId,
    required this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      if (tagId != null) 'tagId': tagId,
      'order': order,
    };
  }
}

/// 动态媒体项
class AuvMomentMediaItem {
  /// 媒体ID
  final int mediaId;

  /// 媒体类型
  final int mediaType;

  /// 可见类型
  final int? visibleType;

  /// 缩放类型
  final int? scaleType;

  /// 媒体URL
  final String? mediaUrl;

  /// 视频封面
  final String? videoCover;

  /// 图片宽度
  final int? imageWidth;

  /// 图片高度
  final int? imageHeight;

  AuvMomentMediaItem({
    required this.mediaId,
    required this.mediaType,
    this.visibleType,
    this.scaleType,
    this.mediaUrl,
    this.videoCover,
    this.imageWidth,
    this.imageHeight,
  });

  factory AuvMomentMediaItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvMomentMediaItem(
        mediaId: 0,
        mediaType: 0,
      );
    }
    return AuvMomentMediaItem(
      mediaId: json['mediaId'] as int? ?? 0,
      mediaType: json['mediaType'] as int? ?? 0,
      visibleType: json['visibleType'] as int?,
      scaleType: json['scaleType'] as int?,
      mediaUrl: json['mediaUrl'] as String?,
      videoCover: json['videoCover'] as String?,
      imageWidth: json['imageWidth'] as int?,
      imageHeight: json['imageHeight'] as int?,
    );
  }
}

/// 动态项
class AuvMomentItemResponse {
  /// 动态ID
  final int momentId;

  /// 用户ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String? portrait;

  /// 生日
  final int? birthday;

  /// 性别（1男，2女）
  final int? sex;

  /// 国家代码
  final String? countryCode;

  /// 国家标题
  final String? countryTitle;

  /// 内容
  final String? content;

  /// 点赞数量
  final int praiseCount;

  /// 评论数量
  final int commentCount;

  /// 点击量
  final int clickCount;

  /// 是否点赞（0否，1是）
  final int praiseFlag;

  /// 话题ID列表
  final List<String>? topicIdList;

  /// 话题ID字符串
  final String? topicIds;

  /// 创建时间
  final int createdAt;

  /// 媒体列表
  final List<AuvMomentMediaItem>? medias;

  AuvMomentItemResponse({
    required this.momentId,
    required this.userId,
    required this.nickname,
    this.portrait,
    this.birthday,
    this.sex,
    this.countryCode,
    this.countryTitle,
    this.content,
    required this.praiseCount,
    required this.commentCount,
    required this.clickCount,
    required this.praiseFlag,
    this.topicIdList,
    this.topicIds,
    required this.createdAt,
    this.medias,
  });

  factory AuvMomentItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvMomentItemResponse(
        momentId: 0,
        userId: 0,
        nickname: '',
        praiseCount: 0,
        commentCount: 0,
        clickCount: 0,
        praiseFlag: 0,
        createdAt: 0,
      );
    }
    return AuvMomentItemResponse(
      momentId: json['momentId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String?,
      birthday: json['birthday'] as int?,
      sex: json['sex'] as int?,
      countryCode: json['countryCode'] as String?,
      countryTitle: json['countryTitle'] as String?,
      content: json['content'] as String?,
      praiseCount: json['praiseCount'] as int? ?? 0,
      commentCount: json['commentCount'] as int? ?? 0,
      clickCount: json['clickCount'] as int? ?? 0,
      praiseFlag: json['praiseFlag'] as int? ?? 0,
      topicIdList: (json['topicIdList'] as List<dynamic>?)?.cast<String>(),
      topicIds: json['topicIds'] as String?,
      createdAt: json['createdAt'] as int? ?? 0,
      medias: (json['medias'] as List<dynamic>?)
          ?.map((e) => AuvMomentMediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 动态分页查询条件
class AuvMomentCondition {
  /// 主题ID（必填）
  final int topicId;

  /// 排序方式（0热门，1最新）
  final int order;

  AuvMomentCondition({
    required this.topicId,
    required this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'order': order,
    };
  }
}

/// 评论回复项
class AuvCommentReplyItem {
  /// 评论ID
  final int commentId;

  /// 用户ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String? portrait;

  /// 生日
  final int? birthday;

  /// 性别（1男，2女）
  final int? sex;

  /// 内容
  final String? content;

  /// 点赞数量
  final int praiseCount;

  /// 创建时间
  final int createdAt;

  /// 是否点赞（0否，1是）
  final int praiseFlag;

  /// 回复的评论ID
  final int? replyCommentId;

  AuvCommentReplyItem({
    required this.commentId,
    required this.userId,
    required this.nickname,
    this.portrait,
    this.birthday,
    this.sex,
    this.content,
    required this.praiseCount,
    required this.createdAt,
    required this.praiseFlag,
    this.replyCommentId,
  });

  factory AuvCommentReplyItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvCommentReplyItem(
        commentId: 0,
        userId: 0,
        nickname: '',
        praiseCount: 0,
        createdAt: 0,
        praiseFlag: 0,
      );
    }
    return AuvCommentReplyItem(
      commentId: json['commentId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String?,
      birthday: json['birthday'] as int?,
      sex: json['sex'] as int?,
      content: json['content'] as String?,
      praiseCount: json['praiseCount'] as int? ?? 0,
      createdAt: json['createdAt'] as int? ?? 0,
      praiseFlag: json['praiseFlag'] as int? ?? 0,
      replyCommentId: json['replyCommentId'] as int?,
    );
  }
}

/// 评论项
class AuvCommentItemResponse {
  /// 评论ID
  final int commentId;

  /// 用户ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String? portrait;

  /// 生日
  final int? birthday;

  /// 性别（1男，2女）
  final int? sex;

  /// 内容
  final String? content;

  /// 点赞数量
  final int praiseCount;

  /// 创建时间
  final int createdAt;

  /// 回复列表
  final List<AuvCommentReplyItem>? replies;

  /// 是否点赞（0否，1是）
  final int praiseFlag;

  AuvCommentItemResponse({
    required this.commentId,
    required this.userId,
    required this.nickname,
    this.portrait,
    this.birthday,
    this.sex,
    this.content,
    required this.praiseCount,
    required this.createdAt,
    this.replies,
    required this.praiseFlag,
  });

  factory AuvCommentItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvCommentItemResponse(
        commentId: 0,
        userId: 0,
        nickname: '',
        praiseCount: 0,
        createdAt: 0,
        praiseFlag: 0,
      );
    }
    return AuvCommentItemResponse(
      commentId: json['commentId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String?,
      birthday: json['birthday'] as int?,
      sex: json['sex'] as int?,
      content: json['content'] as String?,
      praiseCount: json['praiseCount'] as int? ?? 0,
      createdAt: json['createdAt'] as int? ?? 0,
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => AuvCommentReplyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      praiseFlag: json['praiseFlag'] as int? ?? 0,
    );
  }
}

/// 评论分页查询条件
class AuvCommentCondition {
  /// 动态ID（必填）
  final int momentId;

  AuvCommentCondition({
    required this.momentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'momentId': momentId,
    };
  }
}

/// 发布动态媒体项
class AuvPublishMediaItem {
  /// 指纹
  final int fingerPrint;

  /// 图片高度
  final int imageHeight;

  /// 图片宽度
  final int imageWidth;

  /// 媒体URL
  final String mediaUrl;

  /// 视频封面
  final String videoCover;

  AuvPublishMediaItem({
    required this.fingerPrint,
    required this.imageHeight,
    required this.imageWidth,
    required this.mediaUrl,
    required this.videoCover,
  });

  Map<String, dynamic> toJson() {
    return {
      'fingerPrint': fingerPrint,
      'imageHeight': imageHeight,
      'imageWidth': imageWidth,
      'mediaUrl': mediaUrl,
      'videoCover': videoCover,
    };
  }
}
