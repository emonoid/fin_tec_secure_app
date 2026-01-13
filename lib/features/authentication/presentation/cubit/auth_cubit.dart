import 'package:fin_smart/core/common/widgets/sneak_bar.dart';
import 'package:fin_smart/core/local_data/secure_local_data_helper.dart';
import 'package:fin_smart/core/service/biometric_auth_service.dart';
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
  final BiometricAuthService _biometricAuth;
  final LocalDataHelper _localDataHelper;

  AuthCubit({
    required UserLogin userLogin,
    required UserSignup userSignUp,
    required BiometricAuthService biometricAuth,
    required LocalDataHelper localDataHelper,
  }) : _userLogin = userLogin,
       _userSignUp = userSignUp,
       _biometricAuth = biometricAuth,
       _localDataHelper = localDataHelper,
       super(const AuthState());

  /// Toggles password visibility in the UI
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  /// Handles user login
  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final res = await _userLogin(
      UserLoginParams(mobile: username, password: password),
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

  Future<void> loginWithFingerprint(BuildContext context) async {
    final success = await _biometricAuth.authenticate();

    if (success) {
      final refreshToken = await _localDataHelper.getRefreshToken();
      if (refreshToken.isNotEmpty) {
        emit(state.copyWith(isAuthenticated: true));
      } else {
        FinTecSneakBar.show(
          context: context,
          snackText: "Please login manually first to enable biometric login.",
        );
      }
    } else {
      emit(state.copyWith(isAuthenticated: false));
    }
  }
}
