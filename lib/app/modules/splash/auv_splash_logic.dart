import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/services/auv_translate_service.dart';
import 'package:slea_auv/app/api/services/auv_system_service.dart';
import 'package:slea_auv/app/routes/auv_routes.dart';
import 'package:slea_auv/app/utils/auv_logger.dart';

class AuvSplashLogic extends GetxController {
  final AuvStorageService _storage = Get.find<AuvStorageService>();
  final AuvApiService _apiService = Get.find<AuvApiService>();
  final AuvSystemService _systemService = AuvSystemService.create();

  /// Loading status text
  final statusText = 'Initializing...'.obs;

  @override
  void onInit() {
    super.onInit();
    AuvLogger.info('Splash onInit called');
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Step 1: Initialize API Service
      AuvLogger.info('Step 1: Initializing API Service', tag: 'SPLASH');
      statusText.value = 'Loading...';
      AuvLogger.debug('Calling _apiService.init()', tag: 'SPLASH');
      _apiService.init();
      AuvLogger.success('API Service initialized', tag: 'SPLASH');

      // Step 2: Fetch App Config to get sign key (OK parameter)
      AuvLogger.info('Step 2: Fetching App Config...', tag: 'SPLASH');
      statusText.value = 'Loading config...';
      await _fetchAppConfig();

      // Step 2.5: Load translations (non-blocking, runs in parallel if possible)
      AuvLogger.info('Step 2.5: Loading translations...', tag: 'SPLASH');
      statusText.value = 'Loading translations...';
      AuvTranslateService.to.load();

      // Step 3: Check login status and navigate
      AuvLogger.info('Step 3: Checking login status', tag: 'SPLASH');
      statusText.value = 'Checking...';
      await Future.delayed(const Duration(milliseconds: 500));

      await _checkLoginStatus();
    } catch (e, stackTrace) {
      AuvLogger.error('Error during initialization', tag: 'SPLASH', error: e, stackTrace: stackTrace);
      // On error, still allow navigation based on stored session
      await _checkLoginStatus();
    }
  }

  Future<void> _fetchAppConfig() async {
    try {
      AuvLogger.info('Calling /app/config API...', tag: 'SPLASH');
      final result = await _systemService.getAppConfig();
      
      if (result.success && result.data?.ok != null) {
        final signKey = result.data!.ok!;
        AuvLogger.success('Got app config, sign key length: ${signKey.length}', tag: 'SPLASH');
        _apiService.setSignKey(signKey);
        AuvLogger.debug('Sign key set in API service', tag: 'SPLASH');
      } else {
        AuvLogger.warning('Failed to get app config or OK parameter is null', tag: 'SPLASH');
        AuvLogger.warning('Message: ${result.message}', tag: 'SPLASH');
      }
    } catch (e, stackTrace) {
      AuvLogger.error('Error fetching app config', tag: 'SPLASH', error: e, stackTrace: stackTrace);
      // Continue without sign key - some APIs might still work
    }
  }

  Future<void> _checkLoginStatus() async {
    AuvLogger.info('Checking login status...', tag: 'SPLASH');
    
    // Add small delay to ensure UI is ready
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final hasToken = _storage.getToken();
      final isVisitor = _storage.isVisitor();

      AuvLogger.debug('hasToken: ${hasToken != null}, isVisitor: $isVisitor', tag: 'SPLASH');
      AuvLogger.debug('Storage service available: ${_storage != null}', tag: 'SPLASH');

      if (hasToken != null && hasToken.isNotEmpty) {
        AuvLogger.success('User has token, navigating to home', tag: 'SPLASH');
        AuvLogger.route('splash', AuvRoutes.home);
        statusText.value = 'Going to Home...';
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAllNamed(AuvRoutes.home);
      } else if (isVisitor) {
        AuvLogger.success('User is visitor, navigating to home', tag: 'SPLASH');
        AuvLogger.route('splash', AuvRoutes.home);
        statusText.value = 'Going to Home...';
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAllNamed(AuvRoutes.home);
      } else {
        AuvLogger.info('No token or visitor session, navigating to login', tag: 'SPLASH');
        AuvLogger.route('splash', AuvRoutes.login);
        statusText.value = 'Going to Login...';
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAllNamed(AuvRoutes.login);
      }
    } catch (e, stackTrace) {
      AuvLogger.error('Error checking login status', tag: 'SPLASH', error: e, stackTrace: stackTrace);
      AuvLogger.warning('Navigating to login as fallback', tag: 'SPLASH');
      Get.offAllNamed(AuvRoutes.login);
    }
  }
}
