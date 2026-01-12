import '/features/authentication/domain/usecases/login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserLogin _userLogin;

  AuthCubit({required UserLogin userLogin})
      : _userLogin = userLogin,
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
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) => emit(state.copyWith(isLoading: false, isAuthenticated: true)),
    );
  }
}
