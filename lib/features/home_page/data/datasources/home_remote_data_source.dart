import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:scaneat/config.dart';
import 'package:scaneat/features/home_page/data/models/allergen_model.dart';
import 'package:scaneat/features/home_page/data/models/diet_model.dart';

import '../../../../core/error/exception.dart';

abstract class HomeRemoteDataSource {
  Future<List<AllergenModel>> getAllergens();
  Future<List<DietModel>> getDiets();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<List<AllergenModel>> getAllergens() async {
    final response = await client.get(
      Config.APP_URL + 'api/allergens',
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<AllergenModel> allergens =
          l.map((model) => AllergenModel.fromJson(model)).toList();
      return allergens;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DietModel>> getDiets() async {
    final response = await client.get(
      Config.APP_URL + 'api/diets',
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<DietModel> allergens =
          l.map((model) => DietModel.fromJson(model)).toList();
      return allergens;
    } else {
      throw ServerException();
    }
  }
}
