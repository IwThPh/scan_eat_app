import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ScanningRemoteDataSource {
  Future<ProductModel> getProduct(String barcode);
}

class ScanningRemoteDataSourceImpl implements ScanningRemoteDataSource {
  final http.Client client;

  ScanningRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<ProductModel> getProduct(String barcode) async {
    final response = await client.get(
      //TODO: Change this to a app config variable.
        'http://192.168.42.160:8000/api/product/$barcode',
        headers: {'Content-Type': 'application-json'});
        // 'http://192.168.1.4:8000/api/product/$barcode',
        // headers: {'Content-Type': 'application-json'});

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
