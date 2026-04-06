import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:slea_auv/app/core/auv_config.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';
import 'package:slea_auv/app/api/services/auv_system_service.dart';
import 'package:slea_auv/app/utils/auv_logger.dart';

/// 翻译服务（国际化工具）
///
/// 在开屏页调用 [load] 方法加载翻译文案到本地，之后可通过 [tr] / [t] 方法获取翻译文本
///
/// 在 [main.dart] 中通过 [Get.putAsync] 初始化：
/// ```dart
/// Get.putAsync(() => AuvTranslateService().init());
/// ```
///
/// 在开屏页中等待加载完成后再跳转：
/// ```dart
/// await AuvTranslateService.to.load();
/// ```
///
/// 获取翻译文本：
/// ```dart
/// // 使用静态方法
/// AuvTranslateService.t('hello');
/// ```
class AuvTranslateService extends GetxService {
  /// 翻译Map，key为原文，value为译文
  final Map<String, String> _translations = {};

  /// 当前翻译版本号（时间戳）
  final Rx<int?> version = Rx<int?>(null);

  /// 翻译加载状态
  final RxBool isLoaded = false.obs;

  /// 是否正在加载中
  final RxBool isLoading = false.obs;

  /// 最后加载失败的错误信息
  final Rx<String?> lastError = Rx<String?>(null);

  late final AuvStorageService _storage;

  /// 静态访问入口（便捷方法）
  static AuvTranslateService get to => Get.find<AuvTranslateService>();

  /// 翻译方法 - 通过 key 获取翻译文本
  ///
  /// 等同于 `'key'.tr`
  ///
  /// ```dart
  /// AuvTranslateService.t('welcome_message'); // "欢迎消息"
  /// AuvTranslateService.t('missing_key');    // "missing_key" (找不到时返回原key)
  /// ```
  static String t(String key, {Map<String, String>? args}) {
    final service = Get.find<AuvTranslateService>();
    final translated = service._translations[key] ?? key;
    if (args == null || args.isEmpty) return translated;
    return _replaceArgs(translated, args);
  }

  /// 静态构造（供 Get.putAsync 使用）
  factory AuvTranslateService() => AuvTranslateService._();
  AuvTranslateService._();

  /// 初始化方法（供 Get.putAsync 使用）
  ///
  /// 会尝试从本地存储加载已缓存的翻译文案
  Future<AuvTranslateService> init() async {
    AuvLogger.info('Initializing AuvTranslateService', tag: 'TRANSLATE');
    _storage = Get.find<AuvStorageService>();
    _loadFromStorage();
    return this;
  }

  /// 加载翻译文案
  ///
  /// 流程：
  /// 1. 获取翻译配置（版本号 + URL）
  /// 2. 对比本地版本号，若一致则跳过下载
  /// 3. 下载翻译JSON文件
  /// 4. 解析并缓存到本地
  ///
  /// 可在开屏页调用：
  /// ```dart
  /// await AuvTranslateService.to.load();
  /// ```
  ///
  /// 强制重新加载（忽略本地缓存）：
  /// ```dart
  /// await AuvTranslateService.to.load(forceRefresh: true);
  /// ```
  Future<bool> load({bool forceRefresh = false}) async {
    if (isLoading.value) {
      AuvLogger.debug('Translation loading already in progress, skipping', tag: 'TRANSLATE');
      return false;
    }

    isLoading.value = true;
    lastError.value = null;

    try {
      // Step 1: 获取翻译配置（版本号 + URL）
      AuvLogger.info('Step 1: Fetching translate config...', tag: 'TRANSLATE');
      final configResult = await AuvSystemService.create().getTranslatesV2();

      if (!configResult.success || configResult.data == null) {
        lastError.value = configResult.message;
        AuvLogger.error('Failed to get translate config: ${configResult.message}', tag: 'TRANSLATE');
        isLoading.value = false;
        return false;
      }

      final config = configResult.data!;
      final remoteVersion = config.version ?? 0;
      final url = config.url;

      if (url == null || url.isEmpty) {
        lastError.value = 'Translate URL is empty';
        AuvLogger.error('Translate URL is empty', tag: 'TRANSLATE');
        isLoading.value = false;
        return false;
      }

      // Step 2: 检查是否需要更新
      final currentVersion = _storage.read<int>(AuvConfig.translateVersionKey) ?? 0;

      if (!forceRefresh && remoteVersion <= currentVersion) {
        AuvLogger.info('Translate version not changed (local: $currentVersion, remote: $remoteVersion), using cache', tag: 'TRANSLATE');
        version.value = remoteVersion;
        _loadFromStorage();
        isLoading.value = false;
        return _translations.isNotEmpty;
      }

      AuvLogger.info('Step 2: Downloading translate JSON from $url', tag: 'TRANSLATE');

      // Step 3: 下载翻译JSON文件
      final dio = Dio(BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 30000,
      ));
      // 翻译文件返回的是纯JSON文本（可能是gzip压缩后传输）
      // 需要以 plain 方式接收，由上层 jsonDecode 解析
      final response = await dio.get<String>(url);

      if (response.statusCode != 200 || response.data == null || response.data!.isEmpty) {
        lastError.value = 'Failed to download translate JSON: ${response.statusCode}';
        AuvLogger.error('Failed to download translate JSON: ${response.statusCode}', tag: 'TRANSLATE');
        isLoading.value = false;
        return false;
      }

      // Step 4: 解析翻译JSON
      AuvLogger.info('Step 3: Parsing translate JSON...', tag: 'TRANSLATE');
      final rawData = response.data!;
      _translations.clear();
      _parseTranslations(rawData);

      // Step 5: 保存到本地存储
      version.value = remoteVersion;
      await _saveToStorage();

      isLoaded.value = true;
      isLoading.value = false;
      AuvLogger.success('Translate loaded successfully, ${_translations.length} entries, version: $remoteVersion', tag: 'TRANSLATE');
      return true;
    } catch (e, stackTrace) {
      lastError.value = e.toString();
      AuvLogger.error('Failed to load translations', tag: 'TRANSLATE', error: e, stackTrace: stackTrace);
      isLoading.value = false;
      return false;
    }
  }

  /// 获取翻译文本
  String translate(String key) => _translations[key] ?? key;

  /// 获取翻译文本，支持参数替换
  ///
  /// ```dart
  /// AuvTranslateService.tr('hello_user', args: {'name': 'John'});
  /// // 如果翻译文案为 "你好，{name}"
  /// // 返回 "你好，John"
  /// ```
  String tr(String key, {Map<String, String>? args}) {
    final translated = _translations[key] ?? key;
    if (args == null || args.isEmpty) return translated;
    return _replaceArgs(translated, args);
  }

  /// 检查翻译key是否存在
  bool containsKey(String key) => _translations.containsKey(key);

  /// 获取所有翻译key列表
  List<String> get keys => _translations.keys.toList();

  /// 获取翻译条目数量
  int get count => _translations.length;

  /// 清除所有翻译缓存
  Future<void> clear() async {
    _translations.clear();
    version.value = null;
    isLoaded.value = false;
    lastError.value = null;
    _storage.remove(AuvConfig.translateDataKey);
    _storage.remove(AuvConfig.translateVersionKey);
    AuvLogger.info('Translations cleared', tag: 'TRANSLATE');
  }

  /// 从本地存储加载翻译数据
  void _loadFromStorage() {
    try {
      final data = _storage.read<Map<String, dynamic>>(AuvConfig.translateDataKey);
      if (data != null) {
        _translations.clear();
        _translations.addAll(data.cast<String, String>());
        version.value = _storage.read<int>(AuvConfig.translateVersionKey);
        isLoaded.value = _translations.isNotEmpty;
        AuvLogger.debug('Loaded ${_translations.length} translations from storage', tag: 'TRANSLATE');
      }
    } catch (e) {
      AuvLogger.error('Failed to load translations from storage', tag: 'TRANSLATE', error: e);
    }
  }

  /// 保存翻译数据到本地存储
  Future<void> _saveToStorage() async {
    try {
      await _storage.write(AuvConfig.translateDataKey, _translations);
      await _storage.write(AuvConfig.translateVersionKey, version.value);
      AuvLogger.debug('Saved ${_translations.length} translations to storage', tag: 'TRANSLATE');
    } catch (e) {
      AuvLogger.error('Failed to save translations to storage', tag: 'TRANSLATE', error: e);
    }
  }

  /// 解析翻译JSON字符串到_translations Map
  ///
  /// 支持两种格式：
  /// - 数组格式: [{"configKey": "...", "configValue": "..."}, ...]  (服务器实际返回格式)
  /// - 嵌套Map格式: {"hello": "你好", "login": {"title": "登录"}}
  void _parseTranslations(String rawJson) {
    try {
      final data = jsonDecode(rawJson);
      if (data is List) {
        // 数组格式: [{configKey: "...", configValue: "..."}, ...]
        for (final item in data) {
          if (item is Map) {
            final key = item['configKey'] as String?;
            final value = item['configValue'] as String?;
            if (key != null && value != null) {
              _translations[key] = value;
            }
          }
        }
      } else if (data is Map) {
        // 嵌套Map格式
        _parseMap(data.cast<String, dynamic>());
      }
    } catch (e) {
      AuvLogger.error('Failed to parse translate JSON', tag: 'TRANSLATE', error: e);
    }
  }

  /// 递归解析Map格式的翻译JSON到_translations Map
  void _parseMap(Map<String, dynamic> data, [String prefix = '']) {
    data.forEach((key, value) {
      final fullKey = prefix.isEmpty ? key : '$prefix.$key';
      if (value is String) {
        _translations[fullKey] = value;
        _translations[key] = value;
      } else if (value is Map) {
        _parseMap(value.cast<String, dynamic>(), fullKey);
      }
    });
  }

  static String _replaceArgs(String text, Map<String, String> args) {
    var result = text;
    args.forEach((k, v) {
      result = result.replaceAll('{$k}', v);
      result = result.replaceAll('%$k%', v);
    });
    return result;
  }
}
