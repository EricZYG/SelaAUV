import 'package:get/get.dart';
import 'package:slea_auv/app/routes/auv_routes.dart';
import 'package:flutter/material.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';

class AuvHomeLogic extends GetxController {
  final AuvStorageService _storage = Get.find<AuvStorageService>();
  final userName = ''.obs;
  final isVisitor = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    userName.value = _storage.getUserName() ?? 'User';
    isVisitor.value = _storage.isVisitor();
  }

  Future<void> logout() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _storage.clearSession();
      Get.offAllNamed(AuvRoutes.login);
    }
  }
}
