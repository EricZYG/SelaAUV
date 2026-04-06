import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:slea_auv/app/routes/auv_pages.dart';
import 'package:slea_auv/app/routes/auv_routes.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/services/auv_translate_service.dart';
import 'package:slea_auv/app/core/auv_theme.dart';
import 'package:slea_auv/app/utils/auv_logger.dart';

void main() async {
  // 确保 Flutter binding 在 root zone 中初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 设置错误处理（在 root zone 中）
  FlutterError.onError = (FlutterErrorDetails details) {
    AuvLogger.error('FlutterError caught!', tag: 'ERROR', error: details.exception, stackTrace: details.stack);
    FlutterError.presentError(details);
  };

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    AuvLogger.error('ErrorWidget built', tag: 'ERROR', error: errorDetails.exception, stackTrace: errorDetails.stack);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            Text(
              'Error: ${errorDetails.exception}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    AuvLogger.error('PlatformDispatcher error', tag: 'ERROR', error: error, stackTrace: stack);
    return true;
  };

  // 初始化 Logger
  AuvLogger.init();
  AuvLogger.info('Application starting...', tag: 'MAIN');

  // Initialize Storage Service
  AuvLogger.info('Initializing Storage Service...', tag: 'MAIN');
  await Get.putAsync(() => AuvStorageService().init());
  AuvLogger.success('Storage Service initialized', tag: 'MAIN');

  // Initialize API Service (singleton)
  AuvLogger.info('Initializing API Service...', tag: 'MAIN');
  final apiService = AuvApiService();
  apiService.init();
  Get.put<AuvApiService>(apiService);
  AuvLogger.success('API Service initialized', tag: 'MAIN');

  // Initialize Translate Service (singleton)
  AuvLogger.info('Initializing Translate Service...', tag: 'MAIN');
  await Get.putAsync(() => AuvTranslateService().init());
  AuvLogger.success('Translate Service initialized', tag: 'MAIN');

  AuvLogger.info('Running app...', tag: 'MAIN');

  _sleaAppSetting();

  AuvLogger.info('Starting GetMaterialApp with initial route: ${AuvRoutes.splash}', tag: 'MAIN');
  runApp(const SleaAUVApp());
}

void _sleaAppSetting() {
  // 关闭重力感应，禁止横屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 设置顶部statusBar背景色为透明
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class SleaAUVApp extends StatelessWidget {
  const SleaAUVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SleaAUV',
      debugShowCheckedModeBanner: false,
      theme: AuvTheme.lightTheme,
      initialRoute: AuvPages.initial,
      getPages: AuvPages.routes,
    );
  }
}
