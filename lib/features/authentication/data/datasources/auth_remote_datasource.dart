import '/core/constants/api_endpoints.dart';
import '/core/service/network_service_impl.dart';

abstract interface class AuthRemoteDataSource {
  Future<dynamic> login(String email, String password);
  Future<String> signUp(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  NetworkServicesImpl networkApiServices;
  AuthRemoteDataSourceImpl({required this.networkApiServices});

  @override
  Future<dynamic> login(String mobile, String password) async {
    try {
      var body = {'mobile': mobile, 'password': password};

      var response = await networkApiServices.postApi(body, ApiEndPoints.loginUrl);

      return response;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<String> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
