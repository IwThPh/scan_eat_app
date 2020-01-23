import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        DotEnv().env['APP_URL_DEBUG'] + 'api/product/$barcode',
        headers: {'Content-Type': 'application-json'});

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
