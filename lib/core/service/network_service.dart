abstract interface class NetworkServices {
  Future<dynamic> getApi(String url, {Map<String, String>? headers, String? token, int? timeOut,});

  Future<dynamic> postApi(payload, url, {Map<String, String>? headers, String? token, bool bodyEncode = true,int? timeOut,});
}
