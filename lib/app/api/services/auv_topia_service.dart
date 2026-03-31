import '../auv_net_routes.dart';
import '../models/auv_models.dart' hide AuvCommentItemResponse;
import 'auv_base_service.dart';
import '../models/topia/auv_topic_tag_response.dart';

/// Topia 相关 API 服务
class AuvTopiaService extends AuvBaseService {
  /// 获取标签列表
  ///
  /// 获取话题标签列表，包含用户关注状态
  ///
  /// 【返回值】
  /// 返回标签列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await topiaService.listTopicTag();
  /// if (result.success && result.data != null) {
  ///   for (final tag in result.data!) {
  ///     print('${tag.tag}: 是否关注${tag.isFollow == 1}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvTopicTagItemResponse>>> listTopicTag() async {
    try {
      final response = await post(AuvNetRoutes.listTopicTag);
      return handleListResponse<AuvTopicTagItemResponse>(
        response.data,
        (data) => AuvTopicTagItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvTopicTagItemResponse>>(e);
    }
  }

  /// 关注标签/调整标签顺序
  ///
  /// 关注某个标签或调整标签的排序顺序
  ///
  /// 【请求参数】
  /// [tagId] 标签ID（必填）
  /// [sort] 顺序（必填）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await topiaService.followTopicTag(
  ///   tagId: 2,
  ///   sort: 3,
  /// );
  /// if (result.success) {
  ///   print('关注成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> followTopicTag({
    required int tagId,
    required int sort,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.followTopicTag,
        data: {
          'tagId': tagId,
          'sort': sort,
        },
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 发布动态
  ///
  /// 发布新的动态
  ///
  /// 【请求参数】
  /// [content] 动态内容（必填）
  /// [topicIds] 话题id列表（必填）
  /// [medias] 媒体列表（可选）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// final result = await topiaService.publish(
  ///   content: '这是动态内容',
  ///   topicIds: [22222],
  ///   medias: [
  ///     AuvPublishMediaItem(
  ///       fingerPrint: 451212971076288771,
  ///       imageHeight: 296,
  ///       imageWidth: 245,
  ///       mediaUrl: 'https://example.com/image.jpeg',
  ///       videoCover: '',
  ///     ),
  ///   ],
  /// );
  /// if (result.success) {
  ///   print('发布成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> publish({
    required String content,
    required List<int> topicIds,
    List<AuvPublishMediaItem>? medias,
  }) async {
    try {
      final data = {
        'content': content,
        'topicIds': topicIds,
        if (medias != null && medias.isNotEmpty)
          'medias': medias.map((m) => m.toJson()).toList(),
      };
      final response = await post(
        AuvNetRoutes.publish,
        data: data,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取话题列表
  ///
  /// 获取话题列表，包含每个话题的动态信息
  ///
  /// 【请求参数】
  /// [tagId] 标签ID（可选，0表示全部）
  /// [order] 排序方式（0热门，1最新）
  /// [pageNum] 页码
  /// [pageSize] 每页数量
  ///
  /// 【返回值】
  /// 返回话题分页列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await topiaService.pageTopic(
  ///   condition: AuvTopicCondition(tagId: 2, order: 0),
  ///   pageNum: 1,
  ///   pageSize: 10,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final topic in result.data!.list) {
  ///     print('话题: ${topic.title}, 动态数: ${topic.momentCount}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvPageResponse<AuvTopicItemResponse>>> pageTopic({
    required AuvTopicCondition condition,
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.pageTopic,
        data: {
          'condition': condition.toJson(),
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
      );
      return handlePageResponse<AuvTopicItemResponse>(
        response.data,
        (data) => AuvTopicItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvPageResponse<AuvTopicItemResponse>>(e);
    }
  }

  /// 获取动态列表
  ///
  /// 获取某个话题下的动态列表
  ///
  /// 【请求参数】
  /// [topicId] 主题ID（必填）
  /// [order] 排序方式（0热门，1最新）
  /// [pageNum] 页码
  /// [pageSize] 每页数量
  ///
  /// 【返回值】
  /// 返回动态分页列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await topiaService.pageTopicMoment(
  ///   condition: AuvMomentCondition(topicId: 22222, order: 1),
  ///   pageNum: 1,
  ///   pageSize: 10,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final moment in result.data!.list) {
  ///     print('动态: ${moment.content}, 点赞: ${moment.praiseCount}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvPageResponse<AuvMomentItemResponse>>> pageTopicMoment({
    required AuvMomentCondition condition,
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.pageTopicMoment,
        data: {
          'condition': condition.toJson(),
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
      );
      return handlePageResponse<AuvMomentItemResponse>(
        response.data,
        (data) => AuvMomentItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvPageResponse<AuvMomentItemResponse>>(e);
    }
  }

  /// 点赞动态/评论
  ///
  /// 对动态或评论进行点赞
  ///
  /// 【请求参数】
  /// [momentId] 动态ID（必填）
  /// [commentId] 评论ID（必填，0表示点赞动态）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// // 点赞动态
  /// final result = await topiaService.praise(
  ///   momentId: 1892881882087985153,
  ///   commentId: 0,
  /// );
  /// if (result.success) {
  ///   print('点赞成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> praise({
    required int momentId,
    required int commentId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.praise,
        data: {
          'momentId': momentId,
          'commentId': commentId,
        },
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 取消点赞动态/评论
  ///
  /// 取消对动态或评论的点赞
  ///
  /// 【请求参数】
  /// [momentId] 动态ID（必填）
  /// [commentId] 评论ID（必填，0表示取消点赞动态）
  ///
  /// 【返回值】
  /// 返回操作结果
  ///
  /// 示例:
  /// ```dart
  /// // 取消点赞动态
  /// final result = await topiaService.praiseCancel(
  ///   momentId: 1892881882087985153,
  ///   commentId: 0,
  /// );
  /// if (result.success) {
  ///   print('取消点赞成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> praiseCancel({
    required int momentId,
    required int commentId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.praiseCancel,
        data: {
          'momentId': momentId,
          'commentId': commentId,
        },
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 评论/回复
  ///
  /// 对动态进行评论或回复其他评论
  ///
  /// 【请求参数】
  /// [momentId] 动态ID（必填）
  /// [replyCommentId] 回复的评论ID（评论动态时不用传）
  /// [content] 评论内容（必填）
  ///
  /// 【返回值】
  /// 返回新创建的评论ID
  ///
  /// 示例:
  /// ```dart
  /// // 评论动态
  /// final result = await topiaService.comment(
  ///   momentId: 1892881882087985153,
  ///   content: '这是评论内容',
  /// );
  /// if (result.success) {
  ///   print('评论成功, ID: ${result.data}');
  /// }
  ///
  /// // 回复评论
  /// final result = await topiaService.comment(
  ///   momentId: 1892881882087985153,
  ///   replyCommentId: 1892882628351135746,
  ///   content: '这是回复内容',
  /// );
  /// ```
  Future<AuvBaseResponse<int>> comment({
    required int momentId,
    int? replyCommentId,
    required String content,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.comment,
        data: {
          'momentId': momentId,
          if (replyCommentId != null) 'replyCommentId': replyCommentId,
          'content': content,
        },
      );
      return handleSingleValueResponse<int>(
        response.data,
        (data) => data is int ? data : int.tryParse(data.toString()) ?? 0,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }

  /// 获取评论列表
  ///
  /// 获取某个动态下的评论列表
  ///
  /// 【请求参数】
  /// [momentId] 动态ID（必填）
  /// [pageNum] 页码
  /// [pageSize] 每页数量
  ///
  /// 【返回值】
  /// 返回评论分页列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await topiaService.pageComments(
  ///   condition: AuvCommentCondition(momentId: 1892881882087985153),
  ///   pageNum: 1,
  ///   pageSize: 10,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final comment in result.data!.list) {
  ///     print('评论: ${comment.content}, 回复数: ${comment.replies?.length ?? 0}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvPageResponse<AuvCommentItemResponse>>> pageComments({
    required AuvCommentCondition condition,
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.pageComments,
        data: {
          'condition': condition.toJson(),
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
      );
      return handlePageResponse<AuvCommentItemResponse>(
        response.data,
        (data) => AuvCommentItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvPageResponse<AuvCommentItemResponse>>(e);
    }
  }
}

/// Topia 服务全局单例
final topiaService = AuvTopiaService();
