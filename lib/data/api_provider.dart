import 'package:http/http.dart' as http;
import 'package:manektech/data/constants/app_contants.dart';
import 'package:manektech/data/models/api_result.dart';

class ApiProvider {
  Future<ApiResult> postAPI({required String url, required body}) async {
    ApiResult apiResult = ApiResult(
        response: '',
        isSuccess: false,
        errorMsg: AppConstants.somethingWentWrong);
    try {
      final Uri uri = Uri.parse(url);

      final http.Response response = await http.post(uri,
          body: body, headers: {AppConstants.tokenKey: AppConstants.token});

      if (response.statusCode == 200) {
        apiResult.response = response.body;
        apiResult.isSuccess = true;
      }
    } catch (_) {}
    return apiResult;
  }
}
