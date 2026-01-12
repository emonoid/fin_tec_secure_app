import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local_data/secure_local_data_helper.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalDataHelper localDataHelper;
  const AuthRepositoryImpl(this.remoteDataSource, this.localDataHelper);

  @override
  Future<Either<Failure, dynamic>> login({
    required String mobile,
    required String password,
  }) async {
    try {
      // await Future.delayed(const Duration(seconds: 3));
      var response = await remoteDataSource.login(mobile, password);
      if (response['success']) {
        await localDataHelper.setToken(response['accessToken']);
        await localDataHelper.setLoginFlag(true);
        return Right(response);
      } else {
        return Left(Failure(response['message'].toString()));
      }
    } catch (exception) {
      return Left(Failure(exception.toString()));
    }
  }
}
