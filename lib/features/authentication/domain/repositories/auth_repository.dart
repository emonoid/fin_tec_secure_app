import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, dynamic>> login({
    required String mobile,
    required String password,
  });
}
