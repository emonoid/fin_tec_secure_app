import 'package:fin_smart/core/utils/extensions/extensions.dart';
import 'package:fin_smart/features/authentication/domain/usecases/signup.dart';
import 'package:fin_smart/features/authentication/presentation/pages/create_account_and_biometric_screen.dart';
import 'package:flutter/material.dart';

import '/features/authentication/domain/usecases/login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserLogin _userLogin;
  final UserSignup _userSignUp;

  AuthCubit({required UserLogin userLogin, required UserSignup userSignUp})
    : _userLogin = userLogin,
      _userSignUp = userSignUp,
      super(const AuthState());

  /// Toggles password visibility in the UI
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  /// Handles user login
  Future<void> login({required String mobile, required String password}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final res = await _userLogin(
      UserLoginParams(mobile: mobile, password: password),
    );

    res.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) =>
          emit(state.copyWith(isLoading: false, isAuthenticated: true)),
    );
  }

  /// Handles user registration
  Future<void> register({
    required String username,
    required String fullname,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final res = await _userSignUp(
      UserSignupParams(
        username: username,
        fullname: fullname,
        email: email,
        password: password,
      ),
    );

    res.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) {
        emit(state.copyWith(isLoading: false, isAuthenticated: true));
        context.push(CreateAccountAndBiometricScreen());
      },
    );
  }
}
