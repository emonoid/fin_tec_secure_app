part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isAuthenticated;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.isAuthenticated = false,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isAuthenticated,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isPasswordVisible, isAuthenticated, errorMessage];
}
