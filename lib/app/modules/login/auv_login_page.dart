import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slea_auv/app/modules/login/auv_login_logic.dart';

class AuvLoginPage extends GetView<AuvLoginLogic> {
  const AuvLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                _buildLogo(),
                const SizedBox(height: 48),
                _buildLoginCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.message_outlined,
            size: 50,
            color: Color(0xFF667eea),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'SleaAUV',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Sign in to continue',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildVisitorButton(),
          const SizedBox(height: 16),
          _buildDivider(),
          const SizedBox(height: 24),
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 24),
          _buildLoginButton(),
          const SizedBox(height: 24),
          _buildGoogleButton(),
          const SizedBox(height: 16),
          _buildTermsText(),
        ],
      ),
    );
  }

  Widget _buildVisitorButton() {
    return Obx(() => _LoginButton(
          onPressed: controller.isLoading.value ? null : controller.loginAsVisitor,
          isLoading: controller.isLoading.value,
          text: 'Continue as Visitor',
          icon: Icons.person_outline,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade400,
          ],
          textColor: Colors.grey.shade800,
        ));
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or sign in with',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email address',
        prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF667eea)),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock_outlined, color: Color(0xFF667eea)),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ));
  }

  Widget _buildLoginButton() {
    return Obx(() => _LoginButton(
          onPressed: controller.isLoading.value ? null : controller.loginWithEmail,
          isLoading: controller.isLoading.value,
          text: 'Sign In',
          icon: Icons.login,
          colors: const [Color(0xFF667eea), Color(0xFF764ba2)],
          textColor: Colors.white,
        ));
  }

  Widget _buildGoogleButton() {
    return Obx(() => _LoginButton(
          onPressed: controller.isGoogleLoading.value ? null : controller.loginWithGoogle,
          isLoading: controller.isGoogleLoading.value,
          text: 'Continue with Google',
          icon: Icons.g_mobiledata,
          colors: const [Colors.white],
          textColor: Colors.grey.shade800,
          borderColor: Colors.grey.shade300,
          isOutlined: true,
        ));
  }

  Widget _buildTermsText() {
    return Text(
      'By continuing, you agree to our Terms of Service and Privacy Policy',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade500,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;
  final IconData icon;
  final List<Color> colors;
  final Color textColor;
  final Color? borderColor;
  final bool isOutlined;

  const _LoginButton({
    required this.onPressed,
    required this.isLoading,
    required this.text,
    required this.icon,
    required this.colors,
    required this.textColor,
    this.borderColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        gradient: isOutlined ? null : LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        color: isOutlined ? Colors.white : null,
        borderRadius: BorderRadius.circular(14),
        border: isOutlined ? Border.all(color: borderColor ?? Colors.grey.shade300) : null,
        boxShadow: isOutlined
            ? null
            : [
                BoxShadow(
                  color: (colors.first).withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: textColor, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
