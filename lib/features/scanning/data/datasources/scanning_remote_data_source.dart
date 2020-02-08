import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:scaneat/config.dart';

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
    final response = await client.get(Config.APP_URL + 'api/product/$barcode',
        headers: {'Content-Type': 'application-json'});

    log(response.body);

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
