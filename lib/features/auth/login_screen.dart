import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/config/app_env.dart';
import 'models/auth_session.dart';
import 'services/auth_service.dart';

enum _AuthMode { login, signUp }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLoginSuccess});

  final ValueChanged<AuthSession> onLoginSuccess;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _signupHandleController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _authService = AuthService();

  _AuthMode _mode = _AuthMode.login;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupHandleController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _authService.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      final session = await _authService.login(
        email: _loginEmailController.text,
        password: _loginPasswordController.text,
      );
      if (!mounted) return;
      widget.onLoginSuccess(session);
    } on AuthApiException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = error.message);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage =
            'Cannot connect to backend (${AppEnv.apiBaseUrl}). Please start API first.';
      });
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _submitSignUp() async {
    if (!_signupFormKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      final session = await _authService.register(
        handle: _signupHandleController.text,
        email: _signupEmailController.text,
        password: _signupPasswordController.text,
      );
      if (!mounted) return;
      widget.onLoginSuccess(session);
    } on AuthApiException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = error.message);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage =
            'Cannot connect to backend (${AppEnv.apiBaseUrl}). Please start API first.';
      });
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _switchMode(_AuthMode nextMode) {
    if (_mode == nextMode) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _mode = nextMode;
      _errorMessage = null;
    });
  }

  void _showComingSoon(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider login is coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    // hint color: slightly between bg and line for placeholder feel
    final hintColor = Color.lerp(colors.bg, colors.line, 0.8)!;

    return Scaffold(
      backgroundColor: colors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: _mode == _AuthMode.login
                    ? _buildLoginLayout(colors, hintColor)
                    : _buildSignupLayout(colors, hintColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _monoLabel(AppColors colors) => TextStyle(
    color: colors.muted,
    letterSpacing: 2.2,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  Widget _buildLoginLayout(AppColors colors, Color hintColor) {
    return Column(
      key: const ValueKey('login'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'FILMEDME',
              style: TextStyle(
                color: colors.ink,
                fontSize: 46,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.2,
                height: 0.95,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => _showComingSoon('Menu'),
              icon: Icon(Icons.menu_rounded, color: colors.ink),
            ),
            IconButton(
              onPressed: () => _showComingSoon('Settings'),
              icon: Icon(Icons.settings, color: colors.ink),
            ),
          ],
        ),
        const SizedBox(height: 52),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'FILMEDME',
            style: TextStyle(
              color: colors.ink,
              fontSize: 74,
              fontWeight: FontWeight.w900,
              letterSpacing: -2.4,
              height: 0.95,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('THE MONOCHROMATIC LENS / ACCESS PORTAL', style: _monoLabel(colors)),
        const SizedBox(height: 46),
        Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGhostField(
                label: 'EMAIL ADDRESS',
                hint: 'user@monochrome.com',
                controller: _loginEmailController,
                keyboardType: TextInputType.emailAddress,
                colors: colors,
                hintColor: hintColor,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Please enter email';
                  if (!text.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
              const SizedBox(height: 28),
              _buildGhostField(
                label: 'PASSWORD',
                hint: '••••••••',
                controller: _loginPasswordController,
                obscureText: true,
                colors: colors,
                hintColor: hintColor,
                validator: (value) {
                  final text = value ?? '';
                  if (text.length < 8) return 'Password must be at least 8 characters';
                  return null;
                },
                onSubmitted: (_) => _submitLogin(),
              ),
            ],
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 14),
          Text(
            _errorMessage!,
            style: const TextStyle(color: Color(0xFFFF7E7E), fontSize: 13),
          ),
        ],
        const SizedBox(height: 28),
        _buildPrimaryButton(label: 'SIGN IN', onPressed: _isSubmitting ? null : _submitLogin, colors: colors),
        const SizedBox(height: 34),
        _buildSectionDivider('IDENTITY VERIFICATION', colors),
        const SizedBox(height: 20),
        _buildLoginProviders(colors),
        const SizedBox(height: 52),
        Center(
          child: Wrap(
            spacing: 8,
            children: [
              Text("DON'T HAVE AN ACCOUNT?", style: _monoLabel(colors)),
              GestureDetector(
                onTap: () => _switchMode(_AuthMode.signUp),
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: colors.ink,
                    letterSpacing: 2,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: colors.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignupLayout(AppColors colors, Color hintColor) {
    return Column(
      key: const ValueKey('signup'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILMEDME',
          style: TextStyle(
            color: colors.ink,
            fontSize: 46,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.2,
            height: 0.95,
          ),
        ),
        const SizedBox(height: 56),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'JOIN THE ARCHIVE',
            style: TextStyle(
              color: colors.ink,
              fontSize: 64,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
              height: 0.95,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('V2.0 REGISTRATION // INTERNAL ACCESS', style: _monoLabel(colors)),
        const SizedBox(height: 44),
        Form(
          key: _signupFormKey,
          child: Column(
            children: [
              _buildUnderlinedField(
                label: 'USERNAME',
                hint: 'IDENTITY_REF',
                controller: _signupHandleController,
                colors: colors,
                hintColor: hintColor,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  final valid = RegExp(r'^[a-zA-Z0-9_]{3,24}$').hasMatch(text);
                  if (!valid) return 'Use 3-24 chars (a-z, 0-9, _)';
                  return null;
                },
              ),
              const SizedBox(height: 26),
              _buildUnderlinedField(
                label: 'EMAIL ADDRESS',
                hint: 'COMM_CHANNEL@NODE.COM',
                controller: _signupEmailController,
                keyboardType: TextInputType.emailAddress,
                colors: colors,
                hintColor: hintColor,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Please enter email';
                  if (!text.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
              const SizedBox(height: 26),
              _buildUnderlinedField(
                label: 'PASSWORD',
                hint: '••••••••••',
                controller: _signupPasswordController,
                obscureText: true,
                colors: colors,
                hintColor: hintColor,
                validator: (value) {
                  final text = value ?? '';
                  if (text.length < 8) return 'Password must be at least 8 characters';
                  return null;
                },
                onSubmitted: (_) => _submitSignUp(),
              ),
            ],
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 14),
          Text(
            _errorMessage!,
            style: const TextStyle(color: Color(0xFFFF7E7E), fontSize: 13),
          ),
        ],
        const SizedBox(height: 28),
        _buildPrimaryButton(label: 'CREATE ACCOUNT', onPressed: _isSubmitting ? null : _submitSignUp, colors: colors),
        const SizedBox(height: 34),
        _buildSectionDivider('EXTERNAL AUTH PROTOCOLS', colors),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildSquareProvider('IG', () => _showComingSoon('Instagram'), colors)),
            const SizedBox(width: 12),
            Expanded(child: _buildSquareProvider('FB', () => _showComingSoon('Facebook'), colors)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildSquareProvider('GOOG', () => _showComingSoon('Google'), colors)),
            const SizedBox(width: 12),
            Expanded(child: _buildSquareProvider('MSFT', () => _showComingSoon('Microsoft'), colors)),
          ],
        ),
        const SizedBox(height: 36),
        Divider(color: colors.line),
        const SizedBox(height: 20),
        Center(
          child: Wrap(
            spacing: 8,
            children: [
              Text('ALREADY HAVE AN ACCOUNT?', style: _monoLabel(colors)),
              GestureDetector(
                onTap: () => _switchMode(_AuthMode.login),
                child: Text(
                  'LOG IN',
                  style: TextStyle(
                    color: colors.ink,
                    letterSpacing: 2,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGhostField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required AppColors colors,
    required Color hintColor,
    TextInputType? keyboardType,
    bool obscureText = false,
    void Function(String)? onSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _monoLabel(colors)),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          style: TextStyle(color: colors.ink, fontSize: 20),
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: hintColor, fontSize: 20),
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorStyle: const TextStyle(color: Color(0xFFFF7E7E)),
          ),
        ),
      ],
    );
  }

  Widget _buildUnderlinedField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required AppColors colors,
    required Color hintColor,
    TextInputType? keyboardType,
    bool obscureText = false,
    void Function(String)? onSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _monoLabel(colors)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: TextStyle(color: colors.ink, fontSize: 20),
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: '',
            contentPadding: const EdgeInsets.only(bottom: 10),
            hintStyle: TextStyle(color: hintColor, fontSize: 20),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.line, width: 1.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.ink, width: 1.5),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF7E7E), width: 1.5),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF7E7E), width: 1.5),
            ),
            errorStyle: const TextStyle(color: Color(0xFFFF7E7E)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(hint, style: TextStyle(color: hintColor, fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback? onPressed,
    required AppColors colors,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.ink,
          foregroundColor: colors.bg,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        onPressed: onPressed,
        child: _isSubmitting
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: colors.bg),
              )
            : Text(label),
      ),
    );
  }

  Widget _buildSectionDivider(String label, AppColors colors) {
    return Row(
      children: [
        Expanded(child: Divider(color: colors.line)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label, style: _monoLabel(colors).copyWith(fontSize: 12)),
        ),
        Expanded(child: Divider(color: colors.line)),
      ],
    );
  }

  Widget _buildLoginProviders(AppColors colors) {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Text(
              'FM',
              style: TextStyle(
                fontSize: 240,
                fontWeight: FontWeight.w900,
                color: colors.ink.withValues(alpha: 0.05),
                height: 0.8,
              ),
            ),
          ),
        ),
        Column(
          children: [
            _buildProviderRow(label: 'CONTINUE WITH INSTAGRAM', icon: Icons.camera_alt_outlined, onTap: () => _showComingSoon('Instagram'), colors: colors),
            const SizedBox(height: 10),
            _buildProviderRow(label: 'CONTINUE WITH FACEBOOK', icon: Icons.groups_2_outlined, onTap: () => _showComingSoon('Facebook'), colors: colors),
            const SizedBox(height: 10),
            _buildProviderRow(label: 'CONTINUE WITH GOOGLE', icon: Icons.search, onTap: () => _showComingSoon('Google'), colors: colors),
            const SizedBox(height: 10),
            _buildProviderRow(label: 'CONTINUE WITH MICROSOFT', icon: Icons.grid_view_rounded, onTap: () => _showComingSoon('Microsoft'), colors: colors),
          ],
        ),
      ],
    );
  }

  Widget _buildProviderRow({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required AppColors colors,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: colors.line),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(label, style: _monoLabel(colors).copyWith(color: colors.ink, fontSize: 12)),
              ),
              Icon(icon, color: colors.ink),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquareProvider(String label, VoidCallback onTap, AppColors colors) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 74,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: colors.line),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: colors.ink,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
