/// 主播获取心动用户列表响应模型
class AuvHeartbeatUserItemResponse {
  /// 用户ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String portrait;

  /// 在线状态
  final int isOnline;

  /// 心动值
  final double score;

  /// 心动值进度（0-100）
  final int progress;

  /// 心动等级
  final int level;

  /// 用户等级
  final int userLevel;

  /// 是否VIP
  final bool vipFlag;

  /// 是否是高级用户（0否，1是）
  final int isAdvanceUser;

  AuvHeartbeatUserItemResponse({
    required this.userId,
    required this.nickname,
    required this.portrait,
    required this.isOnline,
    required this.score,
    required this.progress,
    required this.level,
    required this.userLevel,
    required this.vipFlag,
    required this.isAdvanceUser,
  });

  factory AuvHeartbeatUserItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatUserItemResponse(
        userId: 0,
        nickname: '',
        portrait: '',
        isOnline: 0,
        score: 0,
        progress: 0,
        level: 0,
        userLevel: 0,
        vipFlag: false,
        isAdvanceUser: 0,
      );
    }
    return AuvHeartbeatUserItemResponse(
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String? ?? '',
      isOnline: json['isOnline'] as int? ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0,
      progress: json['progress'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      userLevel: json['userLevel'] as int? ?? 0,
      vipFlag: json['vipFlag'] as bool? ?? false,
      isAdvanceUser: json['isAdvanceUser'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'portrait': portrait,
      'isOnline': isOnline,
      'score': score,
      'progress': progress,
      'level': level,
      'userLevel': userLevel,
      'vipFlag': vipFlag,
      'isAdvanceUser': isAdvanceUser,
    };
  }
}

/// 主播获取心动用户列表数据响应
class AuvHeartbeatUsersDataResponse {
  /// 总记录数
  final int total;

  /// 用户列表
  final List<AuvHeartbeatUserItemResponse> list;

  /// 当前页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  /// 实际条数
  final int size;

  /// 开始行号
  final int startRow;

  /// 结束行号
  final int endRow;

  /// 总页数
  final int pages;

  /// 上一页页码
  final int prePage;

  /// 下一页页码
  final int nextPage;

  /// 是否第一页
  final bool isFirstPage;

  /// 是否最后一页
  final bool isLastPage;

  /// 是否有上一页
  final bool hasPreviousPage;

  /// 是否有下一页
  final bool hasNextPage;

  /// 导航页码数
  final int navigatePages;

  /// 导航页码列表
  final List<int> navigatepageNums;

  /// 导航首页码
  final int navigateFirstPage;

  /// 导航末页码
  final int navigateLastPage;

  AuvHeartbeatUsersDataResponse({
    required this.total,
    required this.list,
    required this.pageNum,
    required this.pageSize,
    required this.size,
    required this.startRow,
    required this.endRow,
    required this.pages,
    required this.prePage,
    required this.nextPage,
    required this.isFirstPage,
    required this.isLastPage,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.navigatePages,
    required this.navigatepageNums,
    required this.navigateFirstPage,
    required this.navigateLastPage,
  });

  factory AuvHeartbeatUsersDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatUsersDataResponse(
        total: 0,
        list: [],
        pageNum: 0,
        pageSize: 0,
        size: 0,
        startRow: 0,
        endRow: 0,
        pages: 0,
        prePage: 0,
        nextPage: 0,
        isFirstPage: false,
        isLastPage: false,
        hasPreviousPage: false,
        hasNextPage: false,
        navigatePages: 0,
        navigatepageNums: [],
        navigateFirstPage: 0,
        navigateLastPage: 0,
      );
    }
    return AuvHeartbeatUsersDataResponse(
      total: json['total'] as int? ?? 0,
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => AuvHeartbeatUserItemResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pageNum: json['pageNum'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 0,
      size: json['size'] as int? ?? 0,
      startRow: json['startRow'] as int? ?? 0,
      endRow: json['endRow'] as int? ?? 0,
      pages: json['pages'] as int? ?? 0,
      prePage: json['prePage'] as int? ?? 0,
      nextPage: json['nextPage'] as int? ?? 0,
      isFirstPage: json['isFirstPage'] as bool? ?? false,
      isLastPage: json['isLastPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      navigatePages: json['navigatePages'] as int? ?? 0,
      navigatepageNums: (json['navigatepageNums'] as List<dynamic>?)?.cast<int>() ?? [],
      navigateFirstPage: json['navigateFirstPage'] as int? ?? 0,
      navigateLastPage: json['navigateLastPage'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'list': list.map((e) => e.toJson()).toList(),
      'pageNum': pageNum,
      'pageSize': pageSize,
      'size': size,
      'startRow': startRow,
      'endRow': endRow,
      'pages': pages,
      'prePage': prePage,
      'nextPage': nextPage,
      'isFirstPage': isFirstPage,
      'isLastPage': isLastPage,
      'hasPreviousPage': hasPreviousPage,
      'hasNextPage': hasNextPage,
      'navigatePages': navigatePages,
      'navigatepageNums': navigatepageNums,
      'navigateFirstPage': navigateFirstPage,
      'navigateLastPage': navigateLastPage,
    };
  }
}

/// 批量查询主播心动信息响应项
class AuvHeartbeatAnchorItemResponse {
  /// 主播ID
  final int anchorId;

  /// 在线状态
  final int isOnline;

  /// 心动值
  final int score;

  /// 心动等级
  final int level;

  /// 是否在直播中（0否，1是）
  final int inLiveRoom;

  /// 房间ID
  final int roomId;

  AuvHeartbeatAnchorItemResponse({
    required this.anchorId,
    required this.isOnline,
    required this.score,
    required this.level,
    required this.inLiveRoom,
    required this.roomId,
  });

  factory AuvHeartbeatAnchorItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatAnchorItemResponse(
        anchorId: 0,
        isOnline: 0,
        score: 0,
        level: 0,
        inLiveRoom: 0,
        roomId: 0,
      );
    }
    return AuvHeartbeatAnchorItemResponse(
      anchorId: json['anchorId'] as int? ?? 0,
      isOnline: json['isOnline'] as int? ?? 0,
      score: json['score'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      inLiveRoom: json['inLiveRoom'] as int? ?? 0,
      roomId: json['roomId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anchorId': anchorId,
      'isOnline': isOnline,
      'score': score,
      'level': level,
      'inLiveRoom': inLiveRoom,
      'roomId': roomId,
    };
  }
}

/// 心动等级规则列表响应
class AuvHeartbeatRuleListResponse {
  /// 语言
  final String language;

  /// 规则列表
  final List<String> rules;

  /// 总规则说明
  final String masterRule;

  AuvHeartbeatRuleListResponse({
    required this.language,
    required this.rules,
    required this.masterRule,
  });

  factory AuvHeartbeatRuleListResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatRuleListResponse(
        language: '',
        rules: [],
        masterRule: '',
      );
    }
    return AuvHeartbeatRuleListResponse(
      language: json['language'] as String? ?? '',
      rules: (json['rules'] as List<dynamic>?)?.cast<String>() ?? [],
      masterRule: json['masterRule'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'rules': rules,
      'masterRule': masterRule,
    };
  }
}

/// 批量获取主播心动值响应项
class AuvHeartbeatValueItemResponse {
  /// 心动值
  final int score;

  /// 心动等级
  final int level;

  /// 用户ID
  final int userId;

  /// 主播ID
  final int anchorId;

  AuvHeartbeatValueItemResponse({
    required this.score,
    required this.level,
    required this.userId,
    required this.anchorId,
  });

  factory AuvHeartbeatValueItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatValueItemResponse(
        score: 0,
        level: 0,
        userId: 0,
        anchorId: 0,
      );
    }
    return AuvHeartbeatValueItemResponse(
      score: json['score'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      anchorId: json['anchorId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'level': level,
      'userId': userId,
      'anchorId': anchorId,
    };
  }
}

/// 心动主播列表项
class AuvHeartbeatListItemResponse {
  /// 主播ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String portrait;

  /// 在线状态
  final int isOnline;

  /// 性别，1.男，2.女
  final int sex;

  /// 生日时间戳
  final int birthday;

  /// 国家编码
  final int countryCode;

  /// 国旗链接
  final String countryPath;

  /// 国家名
  final String countryTitle;

  /// 心动值（小数点后两位）
  final double score;

  /// 心动等级
  final int level;

  /// 是否在直播中（0否，1是）
  final int inLiveRoom;

  /// 房间ID
  final int roomId;

  AuvHeartbeatListItemResponse({
    required this.userId,
    required this.nickname,
    required this.portrait,
    required this.isOnline,
    required this.sex,
    required this.birthday,
    required this.countryCode,
    required this.countryPath,
    required this.countryTitle,
    required this.score,
    required this.level,
    required this.inLiveRoom,
    required this.roomId,
  });

  factory AuvHeartbeatListItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatListItemResponse(
        userId: 0,
        nickname: '',
        portrait: '',
        isOnline: 0,
        sex: 0,
        birthday: 0,
        countryCode: 0,
        countryPath: '',
        countryTitle: '',
        score: 0,
        level: 0,
        inLiveRoom: 0,
        roomId: 0,
      );
    }
    return AuvHeartbeatListItemResponse(
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String? ?? '',
      isOnline: json['isOnline'] as int? ?? 0,
      sex: json['sex'] as int? ?? 0,
      birthday: json['birthday'] as int? ?? 0,
      countryCode: json['countryCode'] as int? ?? 0,
      countryPath: json['countryPath'] as String? ?? '',
      countryTitle: json['countryTitle'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0,
      level: json['level'] as int? ?? 0,
      inLiveRoom: json['inLiveRoom'] as int? ?? 0,
      roomId: json['roomId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'portrait': portrait,
      'isOnline': isOnline,
      'sex': sex,
      'birthday': birthday,
      'countryCode': countryCode,
      'countryPath': countryPath,
      'countryTitle': countryTitle,
      'score': score,
      'level': level,
      'inLiveRoom': inLiveRoom,
      'roomId': roomId,
    };
  }
}

/// 心动主播列表分页数据
class AuvHeartbeatListDataResponse {
  /// 总记录数
  final int total;

  /// 主播列表
  final List<AuvHeartbeatListItemResponse> list;

  /// 当前页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  /// 实际条数
  final int size;

  /// 开始行号
  final int startRow;

  /// 结束行号
  final int endRow;

  /// 总页数
  final int pages;

  /// 上一页页码
  final int prePage;

  /// 下一页页码
  final int nextPage;

  /// 是否第一页
  final bool isFirstPage;

  /// 是否最后一页
  final bool isLastPage;

  /// 是否有上一页
  final bool hasPreviousPage;

  /// 是否有下一页
  final bool hasNextPage;

  /// 导航页码数
  final int navigatePages;

  /// 导航页码列表
  final List<int> navigatepageNums;

  /// 导航首页码
  final int navigateFirstPage;

  /// 导航末页码
  final int navigateLastPage;

  AuvHeartbeatListDataResponse({
    required this.total,
    required this.list,
    required this.pageNum,
    required this.pageSize,
    required this.size,
    required this.startRow,
    required this.endRow,
    required this.pages,
    required this.prePage,
    required this.nextPage,
    required this.isFirstPage,
    required this.isLastPage,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.navigatePages,
    required this.navigatepageNums,
    required this.navigateFirstPage,
    required this.navigateLastPage,
  });

  factory AuvHeartbeatListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatListDataResponse(
        total: 0,
        list: [],
        pageNum: 0,
        pageSize: 0,
        size: 0,
        startRow: 0,
        endRow: 0,
        pages: 0,
        prePage: 0,
        nextPage: 0,
        isFirstPage: false,
        isLastPage: false,
        hasPreviousPage: false,
        hasNextPage: false,
        navigatePages: 0,
        navigatepageNums: [],
        navigateFirstPage: 0,
        navigateLastPage: 0,
      );
    }
    return AuvHeartbeatListDataResponse(
      total: json['total'] as int? ?? 0,
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => AuvHeartbeatListItemResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pageNum: json['pageNum'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 0,
      size: json['size'] as int? ?? 0,
      startRow: json['startRow'] as int? ?? 0,
      endRow: json['endRow'] as int? ?? 0,
      pages: json['pages'] as int? ?? 0,
      prePage: json['prePage'] as int? ?? 0,
      nextPage: json['nextPage'] as int? ?? 0,
      isFirstPage: json['isFirstPage'] as bool? ?? false,
      isLastPage: json['isLastPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      navigatePages: json['navigatePages'] as int? ?? 0,
      navigatepageNums: (json['navigatepageNums'] as List<dynamic>?)?.cast<int>() ?? [],
      navigateFirstPage: json['navigateFirstPage'] as int? ?? 0,
      navigateLastPage: json['navigateLastPage'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'list': list.map((e) => e.toJson()).toList(),
      'pageNum': pageNum,
      'pageSize': pageSize,
      'size': size,
      'startRow': startRow,
      'endRow': endRow,
      'pages': pages,
      'prePage': prePage,
      'nextPage': nextPage,
      'isFirstPage': isFirstPage,
      'isLastPage': isLastPage,
      'hasPreviousPage': hasPreviousPage,
      'hasNextPage': hasNextPage,
      'navigatePages': navigatePages,
      'navigatepageNums': navigatepageNums,
      'navigateFirstPage': navigateFirstPage,
      'navigateLastPage': navigateLastPage,
    };
  }
}

/// 常驻心动主播项
class AuvFixHeartbeatAnchorItemResponse {
  /// 主播ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String portrait;

  /// 在线状态
  final int isOnline;

  /// 心动值（小数点后两位）
  final double score;

  AuvFixHeartbeatAnchorItemResponse({
    required this.userId,
    required this.nickname,
    required this.portrait,
    required this.isOnline,
    required this.score,
  });

  factory AuvFixHeartbeatAnchorItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvFixHeartbeatAnchorItemResponse(
        userId: 0,
        nickname: '',
        portrait: '',
        isOnline: 0,
        score: 0,
      );
    }
    return AuvFixHeartbeatAnchorItemResponse(
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String? ?? '',
      isOnline: json['isOnline'] as int? ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'portrait': portrait,
      'isOnline': isOnline,
      'score': score,
    };
  }
}
