import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slea_auv/app/core/auv_config.dart';

class AuvStorageService extends GetxService {
  late final GetStorage _box;

  Future<AuvStorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // Token
  String? getToken() => _box.read<String>(AuvConfig.tokenKey);
  Future<void> saveToken(String token) => _box.write(AuvConfig.tokenKey, token);

  // User Name
  String? getUserName() => _box.read<String>('${AuvConfig.userInfoKey}_name');

  // Visitor
  bool isVisitor() => _box.read<bool>(AuvConfig.isVisitorKey) ?? false;

  Future<void> saveVisitorSession() async {
    await _box.write(AuvConfig.isVisitorKey, true);
    await _box.write('${AuvConfig.userInfoKey}_name', 'Visitor');
  }

  Future<void> saveUserSession(String name, String token) async {
    await _box.write(AuvConfig.isVisitorKey, false);
    await _box.write('${AuvConfig.userInfoKey}_name', name);
    await _box.write(AuvConfig.tokenKey, token);
  }

  Future<void> clearSession() async {
    await _box.remove(AuvConfig.tokenKey);
    await _box.remove(AuvConfig.userInfoKey);
    await _box.remove(AuvConfig.isVisitorKey);
    await _box.remove('${AuvConfig.userInfoKey}_name');
  }
}
