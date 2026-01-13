import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class UserSignup implements UseCase<dynamic, UserSignupParams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, dynamic>> call(UserSignupParams params) async {
    return await authRepository.signUp(
      username: params.username,
      fullname: params.fullname,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String username;
  final String fullname;
  final String email;
  final String password;

  UserSignupParams({
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
  });
}
