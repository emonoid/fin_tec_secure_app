import 'package:fin_smart/core/service/biometric_auth_service.dart';
import 'package:fin_smart/core/service/network_service.dart';
import 'package:fin_smart/features/authentication/domain/usecases/signup.dart';

import '/core/common/cubits/locale_cubit/language_cubit.dart';
import 'core/local_data/secure_local_data_helper.dart';
import '/core/common/cubits/app_user/app_user_cubit.dart';
import '/features/authentication/data/datasources/auth_remote_datasource.dart';
import '/features/authentication/data/repositories/auth_repository_impl.dart';
import '/features/authentication/domain/usecases/login.dart';
import 'package:get_it/get_it.dart';
import 'core/common/cubits/theme/theme_cubit.dart';
import 'core/service/network_service_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // core
  serviceLocator.registerLazySingleton<LocalDataHelper>(
    () => LocalDataHelper(),
  );
  serviceLocator.registerLazySingleton(() => AppUserCubit(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LanguageCubit(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ThemeCubit(serviceLocator()));

  // auth
  _intiAuth();
}

void _intiAuth() {
  serviceLocator
    // network api service
    ..registerFactory(() => NetworkServicesImpl())
    // other services
    ..registerFactory(() => BiometricAuthService())
    // datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(networkApiServices: serviceLocator()),
    )
    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    // usecase
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => UserSignup(serviceLocator()))
    // bloc/cubit
    ..registerFactory(
      () => AuthCubit(
        userLogin: serviceLocator(),
        userSignUp: serviceLocator(),
        biometricAuth: serviceLocator(),
        localDataHelper: serviceLocator(),
        userSession: serviceLocator(),
      ),
    );
}
