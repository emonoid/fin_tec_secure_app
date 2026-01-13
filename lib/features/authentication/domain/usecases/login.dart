import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class UserLogin implements UseCase<dynamic, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, dynamic>> call(UserLoginParams params) async {
    return await authRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String username;
  final String password;

  UserLoginParams({
    required this.username,
    required this.password,
  });
}
