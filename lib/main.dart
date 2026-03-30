import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:slea_auv/app/routes/auv_pages.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';
import 'package:slea_auv/app/core/auv_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Storage Service
  await Get.putAsync(() => AuvStorageService().init());

  runZonedGuarded(() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      return true;
    };

    _sleaAppSetting();
  }, (Object error, StackTrace stack) {
  });
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
