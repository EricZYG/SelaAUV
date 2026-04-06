import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slea_auv/app/core/auv_config.dart';
import 'package:slea_auv/app/api/models/user/auv_login_response.dart';
import 'package:slea_auv/app/utils/auv_logger.dart';

class AuvStorageService extends GetxService {
  late final GetStorage _box;

  Future<AuvStorageService> init() async {
    AuvLogger.info('Initializing GetStorage...', tag: 'STORAGE');
    await GetStorage.init();
    _box = GetStorage();
    AuvLogger.debug('GetStorage initialized, box: $_box', tag: 'STORAGE');
    return this;
  }

  // Token
  String? getToken() {
    final token = _box.read<String>(AuvConfig.tokenKey);
    AuvLogger.debug('getToken() = ${token != null ? "***${token.substring(token.length > 8 ? token.length - 8 : 0)}" : "null"}', tag: 'STORAGE');
    return token;
  }

  Future<void> saveToken(String token) {
    AuvLogger.debug('Saving token', tag: 'STORAGE');
    return _box.write(AuvConfig.tokenKey, token);
  }

  // User ID
  String? getUserId() => _box.read<String>('${AuvConfig.userInfoKey}_userId');
  Future<void> saveUserId(String userId) => _box.write('${AuvConfig.userInfoKey}_userId', userId);

  // User Name
  String? getUserName() => _box.read<String>('${AuvConfig.userInfoKey}_name');

  // Visitor
  bool isVisitor() {
    final visitor = _box.read<bool>(AuvConfig.isVisitorKey) ?? false;
    AuvLogger.debug('isVisitor() = $visitor', tag: 'STORAGE');
    return visitor;
  }

  Future<void> saveVisitorSession() async {
    AuvLogger.info('Saving visitor session', tag: 'STORAGE');
    await _box.write(AuvConfig.isVisitorKey, true);
    await _box.write('${AuvConfig.userInfoKey}_name', 'Visitor');
  }

  /// 保存登录响应数据
  Future<void> saveLoginResponse(AuvLoginResponse response) async {
    AuvLogger.info('Saving login response for user: ${response.username}', tag: 'STORAGE');
    await _box.write(AuvConfig.isVisitorKey, false);
    await _box.write('${AuvConfig.userInfoKey}_name', response.username);
    await _box.write('${AuvConfig.userInfoKey}_userId', response.userId);
    if (response.authorization != null) {
      await _box.write(AuvConfig.tokenKey, response.authorization);
    }
    AuvLogger.success('Login response saved', tag: 'STORAGE');
  }

  Future<void> saveUserSession(String name, String token) async {
    AuvLogger.info('Saving user session for: $name', tag: 'STORAGE');
    await _box.write(AuvConfig.isVisitorKey, false);
    await _box.write('${AuvConfig.userInfoKey}_name', name);
    await _box.write(AuvConfig.tokenKey, token);
  }

  Future<void> clearSession() async {
    AuvLogger.warning('Clearing session', tag: 'STORAGE');
    await _box.remove(AuvConfig.tokenKey);
    await _box.remove(AuvConfig.userInfoKey);
    await _box.remove(AuvConfig.isVisitorKey);
    await _box.remove('${AuvConfig.userInfoKey}_name');
    await _box.remove('${AuvConfig.userInfoKey}_userId');
  }

  // ========== 通用读写方法（供其他Service使用）==========

  T? read<T>(String key) => _box.read<T>(key);

  Future<void> write(String key, dynamic value) => _box.write(key, value);

  Future<void> remove(String key) => _box.remove(key);
}
