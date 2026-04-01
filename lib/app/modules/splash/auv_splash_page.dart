import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slea_auv/app/modules/splash/auv_splash_logic.dart';
import 'package:slea_auv/app/utils/auv_logger.dart';
import 'package:slea_auv/app/routes/auv_routes.dart';

class AuvSplashPage extends GetView<AuvSplashLogic> {
  const AuvSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuvLogger.info('Building splash page', tag: 'SPLASH-WIDGET');
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            _buildAnimatedLogo(),
            const SizedBox(height: 32),
            _buildAnimatedTitle(),
            const SizedBox(height: 8),
            _buildAnimatedSubtitle(),
            const Spacer(flex: 2),
            _buildLoadingIndicator(),
            const SizedBox(height: 24),
            _buildDebugButton(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        // 确保 opacity 值在有效范围内
        final safeOpacity = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: safeOpacity,
            child: child,
          ),
        );
      },
      child: _buildLogoContent(),
    );
  }

  Widget _buildLogoContent() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          'assets/images/logo.png',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            AuvLogger.warning('Logo image not found, using fallback icon', tag: 'SPLASH-WIDGET');
            return const Icon(
              Icons.message_outlined,
              size: 60,
              color: Color(0xFF667eea),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        // 确保 opacity 值在有效范围内
        final safeOpacity = value.clamp(0.0, 1.0);
        return Opacity(
          opacity: safeOpacity,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: const Text(
        'SleaAUV',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildAnimatedSubtitle() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        // 确保 opacity 值在有效范围内
        final safeOpacity = value.clamp(0.0, 1.0);
        return Opacity(
          opacity: safeOpacity,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: const Text(
        'Welcome to your new experience',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        Obx(() => Text(
          controller.statusText.value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white54,
          ),
        )),
        const SizedBox(height: 12),
        const SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildDebugButton() {
    return TextButton(
      onPressed: () {
        AuvLogger.warning('Debug button pressed, navigating to login', tag: 'SPLASH-WIDGET');
        Get.offAllNamed(AuvRoutes.login);
      },
      child: const Text(
        'Debug: Go to Login',
        style: TextStyle(
          color: Colors.white30,
          fontSize: 12,
        ),
      ),
    );
  }
}
