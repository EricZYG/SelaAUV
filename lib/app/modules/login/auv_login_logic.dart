import 'package:get/get.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';
import 'package:slea_auv/app/routes/auv_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:slea_auv/app/api/services/auv_auth_service.dart';
import 'package:slea_auv/app/core/auv_config.dart';

class AuvLoginLogic extends GetxController {
  final AuvStorageService _storage = Get.find<AuvStorageService>();
  final AuvAuthService _authService = AuvAuthService.create();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isGoogleLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// 游客登录 - 调用真实API
  Future<void> loginAsVisitor() async {
    isLoading.value = true;
    try {
      // Generate a simple device identifier for guest login
      final deviceId = AuvConfig.debugDeviceId;
      
      // Call the real guest login API
      final result = await _authService.guestLogin(
        password: deviceId,
      );

      if (result.success && result.data != null) {
        // Save the login response to storage
        await _storage.saveLoginResponse(result.data!);
        
        // Show success message
        Get.snackbar(
          'Success',
          'Welcome, ${result.data!.username}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
        
        // Navigate to home
        Get.offAllNamed(AuvRoutes.home);
      } else {
        // API returned error
        Get.snackbar(
          'Login Failed',
          result.message ?? 'Unable to login as visitor',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      }
    } catch (e) {
      // Network or other error
      Get.snackbar(
        'Error',
        'Network error. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithEmail() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter email and password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    if (!_isValidEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      await _storage.saveUserSession('user_$email', 'token_${DateTime.now().millisecondsSinceEpoch}');
      Get.offAllNamed(AuvRoutes.home);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    isGoogleLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        await _storage.saveUserSession(googleUser.email, 'google_token_${DateTime.now().millisecondsSinceEpoch}');
        Get.offAllNamed(AuvRoutes.home);
      }
    } on Exception {
      Get.snackbar(
        'Google Sign-In Failed',
        'Unable to sign in with Google. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } finally {
      isGoogleLoading.value = false;
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
