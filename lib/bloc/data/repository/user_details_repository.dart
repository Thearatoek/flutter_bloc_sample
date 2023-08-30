import 'package:flutter_bloc_sample/bloc/data/model/user_details.dart';
import 'package:flutter_bloc_sample/bloc/data/provider/user_detais_provider.dart';

class ProductDetailReposity {
  final _userDetailsProvider = UserDetailsProvider();
  // Fetch the api response and pass it to bloc component
  Future<List<ProductModel>> fetchUserDetails() async =>
      _userDetailsProvider.fetchUserDetails();
}
