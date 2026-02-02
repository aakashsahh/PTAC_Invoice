import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';
import 'package:ptac_invoice/core/router/app_router.dart';
import 'package:ptac_invoice/shared/widgets/buttons.dart';
import 'package:ptac_invoice/shared/widgets/custom_textfield.dart';
import 'package:ptac_invoice/views/auth/presentation/bloc/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.unfocus();
      context.read<AuthBloc>().add(
        LoginEvent(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.trim().length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.trim().length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.showSuccessSnackBar('Login successful!');
            // Navigate to dashboard
            context.pushNamedAndRemoveUntil(
              AppRouter.dashboard,
              (route) => false,
            );
          } else if (state is AuthError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo Section
                      _buildLogoSection(),
                      const SizedBox(height: 48),

                      // Welcome Text
                      _buildWelcomeText(),
                      const SizedBox(height: 32),

                      // Login Card
                      _buildLoginCard(isLoading),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.receipt_long,
            size: 60,
            color: context.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'PTAC INVOICE',
          style: context.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: context.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue',
          style: context.bodyMedium?.copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildLoginCard(bool isLoading) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Username Field
          CustomTextField(
            hintText: 'Username',
            controller: _usernameController,
            focusNode: _usernameFocusNode,
            prefixIcon: Icon(
              Icons.person_outline,
              color: context.colorScheme.primary,
            ),
            textInputAction: TextInputAction.next,
            enabled: !isLoading,
            validator: _validateUsername,
            onSubmit: (_) {
              _passwordFocusNode.requestFocus();
            },
          ),
          const SizedBox(height: 20),

          // Password Field
          CustomTextField(
            hintText: 'Password',
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.colorScheme.primary,
            ),
            isPass: true,
            textInputAction: TextInputAction.done,
            enabled: !isLoading,
            validator: _validatePassword,
            onSubmit: (_) {
              _handleLogin();
            },
          ),
          // const SizedBox(height: 12),

          // Forgot Password (Optional)
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: TextButton(
          //     onPressed: isLoading
          //         ? null
          //         : () {
          //             context.showSnackBar(
          //               'Forgot password feature coming soon',
          //             );
          //           },
          //     style: TextButton.styleFrom(
          //       padding: EdgeInsets.zero,
          //       minimumSize: const Size(0, 0),
          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //     ),
          //     child: Text(
          //       'Forgot Password?',
          //       style: context.bodySmall?.copyWith(
          //         color: context.colorScheme.primary,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 24),

          // Login Button
          LoginButton(
            text: 'Sign In',
            onPress: isLoading ? null : _handleLogin,
            isLoading: isLoading,
            color: context.colorScheme.primary,
            isFull: false,
          ),
        ],
      ),
    );
  }
}
