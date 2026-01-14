import 'dart:io';

import 'package:fin_smart/core/common/cubits/app_user/user_session_cubit.dart';
import 'package:fin_smart/core/common/widgets/sneak_bar.dart';
import 'package:fin_smart/core/local_data/secure_local_data_helper.dart';
import 'package:fin_smart/core/service/biometric_auth_service.dart';
import 'package:fin_smart/core/theme/app_colors.dart';
import 'package:fin_smart/core/utils/enums.dart';
import 'package:fin_smart/core/utils/extensions/extensions.dart';
import 'package:fin_smart/features/account/presentation/screens/account_home_screen.dart';
import 'package:fin_smart/features/authentication/domain/usecases/signup.dart';
import 'package:fin_smart/features/authentication/presentation/pages/create_account_and_biometric_screen.dart';
import 'package:flutter/material.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:vpn_detector/vpn_detector.dart';

import '/features/authentication/domain/usecases/login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserLogin _userLogin;
  final UserSignup _userSignUp;
  final BiometricAuthService _biometricAuth;
  final SecureLocalDataHelper _localDataHelper;
  final UserSessionCubit _userSession;

  AuthCubit({
    required UserLogin userLogin,
    required UserSignup userSignUp,
    required BiometricAuthService biometricAuth,
    required SecureLocalDataHelper localDataHelper,
    required UserSessionCubit userSession,
  }) : _userLogin = userLogin,
       _userSignUp = userSignUp,
       _biometricAuth = biometricAuth,
       _localDataHelper = localDataHelper,
       _userSession = userSession,
       super(const AuthState());

  /// Toggles password visibility in the UI
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  /// Handles user login
  Future<void> login({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final res = await _userLogin(
      UserLoginParams(username: username, password: password),
    );

    res.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) async {
        emit(state.copyWith(isLoading: false, isAuthenticated: true));

        await _localDataHelper.setRefreshToken(success['refresh_token']);

        context.read<UserSessionCubit>().setAppUserStatus(
          UserSessionStatus.authenticated,
          accessToken: success['access_token'],
        );

        context.push(AccountHomeScreen());
      },
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
        // TODO: call refresh token API to get new access token
        context.push(AccountHomeScreen());
      } else {
        if (context.mounted) {
          FinTecSneakBar.show(
            context: context,
            snackText: "Please login manually first to enable biometric login.",
          );
        }
      }
    } else {
      emit(state.copyWith(isAuthenticated: false));
    }
  }

  void securityChecks(BuildContext context) async {
    final isNotTrust = await JailbreakRootDetection.instance.isNotTrust;
    final isJailBroken = await JailbreakRootDetection.instance.isJailBroken;
    final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;
    final isOnExternalStorage =
        await JailbreakRootDetection.instance.isOnExternalStorage;
    final isDevMode = await JailbreakRootDetection.instance.isDevMode;
    final isVpnActive = await this.isVpnActive();

    String? message;

    if (isNotTrust) {
      message = "Device is not trusted.";
    } else if (isJailBroken) {
      message = "Device is rooted.";
    } else if (!isRealDevice) {
      message = "Device is not a real device.";
    } else if (isOnExternalStorage) {
      message = "App is running from external storage.";
    } else if (isDevMode) {
      message = "Device is in developer mode.";
    } else if (isVpnActive) {
      message = "VPN is active.";
    }

    if (isNotTrust ||
        isJailBroken ||
        !isRealDevice ||
        isOnExternalStorage ||
        isDevMode ||
        isVpnActive) {
      FinTecSneakBar.show(
        context: context,
        snackText: "$message The app will exit now.",
        snackBackgroundColor: AppColors.redColor,
      );
      await Future.delayed(const Duration(seconds: 3));
      exit(0);
    }
  }

  Future<bool> isVpnActive() async {
    final status = await VpnDetector().isVpnActive();
    if (status == VpnStatus.active) {
      return true;
    } else {
      return false;
    }
  }
}
