import '../helper/all_imports.dart';

class APIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    FormData? params,
    Map<String, String>? headers,
    String? token = "",
    bool isLoading = true,
  }) async {
    var response = await HttpUtil(token!, isLoading).post(apiName, data: params, headers: headers);
    return response;
  }
}

class GetAPIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    FormData? params,
    String? token = "",
    bool isLoading = true,
  }) async {
    var response = await HttpUtil(token!, isLoading).get(apiName);
    return response;
  }
}
