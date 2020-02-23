import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:scaneat/config.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ScanningRemoteDataSource {
  Future<ProductModel> getProduct(String barcode, String token);
}

class ScanningRemoteDataSourceImpl implements ScanningRemoteDataSource {
  final http.Client client;

  ScanningRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<ProductModel> getProduct(String barcode, String token) async {
    final response = await client.get(
      Config.APP_URL + 'api/product/$barcode',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
