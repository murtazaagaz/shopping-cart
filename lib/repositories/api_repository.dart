import 'dart:convert';

import 'package:manektech/data/api_provider.dart';
import 'package:manektech/data/constants/api_url.dart';
import 'package:manektech/data/models/api_result.dart';
import 'package:manektech/data/models/product.dart';

class ApiRepository {
  Future<List<Product>> getProducts(String page) async {
    List<Product> products = [];

    Map<String, String> body = {'page': page, 'perPage': '5'};
    ApiResult result =
        await ApiProvider().postAPI(url: ApiUrl.allProducts, body: body);
    if (result.isSuccess) {
      Map<String, dynamic> response = jsonDecode(result.response);

      List<dynamic> data = response['data'];
      products =
          data.map((e) => Product.fromMap(e as Map<String, dynamic>)).toList();
    }

    return products;
  }
}
