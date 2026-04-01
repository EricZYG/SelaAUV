import 'package:flutter/foundation.dart';

/// Simple logger utility for debugging
class AuvLogger {
  static const String _prefix = '[AuvApp]';

  static void init() {
    debugPrint('$AuvLogger _prefix Logger initialized');
  }

  static void log(String message, {String? tag}) {
    final timestamp = DateTime.now().toIso8601String();
    final tagStr = tag != null ? '[$tag] ' : '';
    debugPrint('$_prefix $tagStr$message | $timestamp');
  }

  static void info(String message, {String? tag}) {
    log('ℹ️ $message', tag: tag ?? 'INFO');
  }

  static void success(String message, {String? tag}) {
    log('✅ $message', tag: tag ?? 'SUCCESS');
  }

  static void warning(String message, {String? tag}) {
    log('⚠️ $message', tag: tag ?? 'WARNING');
  }

  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    final errorStr = error != null ? '\nError: $error' : '';
    final stackStr = stackTrace != null ? '\nStackTrace: $stackTrace' : '';
    debugPrint('$_prefix 🔴 [ERROR] $message$errorStr$stackStr | ${DateTime.now().toIso8601String()}');
  }

  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      log('🔍 $message', tag: tag ?? 'DEBUG');
    }
  }

  static void route(String from, String to) {
    log('🧭 Route: $from → $to', tag: 'ROUTER');
  }

  static void api(String endpoint, {String? method, int? statusCode, String? message}) {
    final methodStr = method ?? 'GET';
    final statusStr = statusCode != null ? ' [$statusCode]' : '';
    final msgStr = message != null ? ' - $message' : '';
    log('📡 API: $methodStr $endpoint$statusStr$msgStr', tag: 'API');
  }
}
