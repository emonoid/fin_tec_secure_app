import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/authentication/presentation/cubit/auth_cubit.dart';
import '../../../../core/common/widgets/fintec_text.dart';
import '../../../../core/common/widgets/fintec_button.dart';
import '../../../../core/common/widgets/sneak_bar.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:fin_smart/l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _next() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        username: _usernameController.text,
        fullname: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocListener<AuthCubit, AuthState>(
          listenWhen: (prev, curr) =>
              prev.errorMessage != curr.errorMessage ||
              prev.isAuthenticated != curr.isAuthenticated,
          listener: (context, state) {
            if (state.errorMessage != null) {
              FinTecSneakBar.show(
                context: context,
                snackText: state.errorMessage!,
                snackBackgroundColor: AppColors.redColor,
              );
            }

            if (state.isAuthenticated) {
              // Navigate to home
              // context.push(const SideNavigation());
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FinTecTextWidget(
                      text: AppLocalizations.of(context)!.welcome,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter username'
                          : null,
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter Full Name'
                          : null,
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter Email' : null,
                    ),

                    const SizedBox(height: 12),

                    BlocSelector<AuthCubit, AuthState, bool>(
                      selector: (state) => state.isPasswordVisible,
                      builder: (context, isVisible) {
                        return TextFormField(
                          controller: _passwordController,
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => context
                                  .read<AuthCubit>()
                                  .togglePasswordVisibility(),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter password'
                              : null,
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    BlocSelector<AuthCubit, AuthState, bool>(
                      selector: (state) => state.isLoading,
                      builder: (context, isLoading) {
                        return FinTecButton(
                          buttonText: 'Next',
                          isLoading: isLoading,
                          buttonHeight: 50,
                          borderRadius: 15,
                          borderColor: AppColors.scaffoldBackGroundColor,
                          gradient: AppColors.blueButtonGradient,
                          textColor: AppColors.whiteColor,
                          fontSize: 16,
                          showIcon: false,
                          onTap: isLoading ? null : _next,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
