import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/user_details.dart';

class UserDetailsProvider {
  final String url = "https://dummyjson.com/products";
  final listdata = <ProductModel>[];

  Future<List<ProductModel>> fetchUserDetails() async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      responseData['products'].map((e) {
        listdata.add(ProductModel.fromJson(e));
      }).toList();

      return listdata;
    }
    throw Exception('Not able to fetch the data: ' + response.body);
  }
}
