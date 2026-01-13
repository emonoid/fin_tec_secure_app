import '/core/constants/api_endpoints.dart';
import '/core/service/network_service_impl.dart';

abstract interface class AuthRemoteDataSource {
  Future<dynamic> login(String username, String password);
  Future<dynamic> signUp(
    String username,
    String fullname,
    String email,
    String password,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  NetworkServicesImpl networkApiServices;
  AuthRemoteDataSourceImpl({required this.networkApiServices});

  @override
  Future<dynamic> login(String username, String password) async {
    try {
      var body = {'username': username, 'password': password};

      var response = await networkApiServices.postApi(
        body,
        ApiEndPoints.loginUrl,
      );

      return response;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<dynamic> signUp(
    String username,
    String fullname,
    String email,
    String password,
  ) async {
    try {
      var body = {
        'username': username,
        'fullname': fullname,
        'email': email,
        'password': password,
      };

      var response = await networkApiServices.postApi(
        body,
        ApiEndPoints.signUpUrl,
      );
      return response;
    } catch (exception) {
      rethrow;
    }
  }
}
