import 'dart:async';

/// A web implementation of the AgoraRtcRawdata plugin.
/// This is a stub implementation for web platform.
class AgoraRtcRawdataWeb {
  static void registerWithRegistrar(/* ignore: undefined_class */) {
    // Web implementation stub - no-op for now
  }
}

/// Stub method channel for web compatibility.
class MethodChannel {
  final String name;
  const MethodChannel(this.name);
}

/// Stub standard method codec for web compatibility.
class StandardMethodCodec {
  const StandardMethodCodec();
}

/// Stub platform exception for web compatibility.
class PlatformException implements Exception {
  final String code;
  final String message;
  const PlatformException({required this.code, required this.message});
}

/// Stub method call for web compatibility.
class MethodCall {
  final String method;
  const MethodCall(this.method);
}
