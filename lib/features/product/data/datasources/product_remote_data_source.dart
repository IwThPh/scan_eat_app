import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../config.dart';
import '../../../../core/error/exception.dart';
import '../../../product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> saveProduct(String barcode, String token);
  Future<ProductModel> unsaveProduct(String barcode, String token);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({
    @required this.client,
  });

  ///Sends a Patch request to remote data source.
  ///
  ///[token] is required to verify user authentication.
  ///[barcode] is the product to save.
  ///
  ///Returns [ProductModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<ProductModel> saveProduct(String barcode, String token) async {
    final response = await client.patch(
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

  ///Sends a Delete request to remote data source.
  ///
  ///[token] is required to verify user authentication.
  ///[barcode] is the product to unsave.
  ///
  ///Returns [ProductModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<ProductModel> unsaveProduct(String barcode, String token) async {
    final response = await client.delete(
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
