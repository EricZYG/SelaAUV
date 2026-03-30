import 'package:get/get.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';

class AuvSplashLogic extends GetxController {
  final AuvStorageService _storage = Get.find<AuvStorageService>();

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    
    final hasToken = _storage.getToken() != null;
    final isVisitor = _storage.isVisitor();

    if (hasToken || isVisitor) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
