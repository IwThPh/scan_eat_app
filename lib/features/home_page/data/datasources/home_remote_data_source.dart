import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:scaneat/config.dart';
import 'package:scaneat/features/home_page/data/models/allergen_model.dart';
import 'package:scaneat/features/home_page/data/models/diet_model.dart';
import 'package:scaneat/features/home_page/data/models/preference_model.dart';
import 'package:scaneat/features/product/data/models/product_model.dart';

import '../../../../core/error/exception.dart';

abstract class HomeRemoteDataSource {
  Future<List<AllergenModel>> getAllergens(String token);

  Future<String> selectAllergens(String token, List<int> allergenIds);

  Future<List<DietModel>> getDiets(String token);

  Future<String> selectDiets(String token, List<int> dietIds);

  Future<PreferenceModel> getPreference(String token);

  Future<PreferenceModel> updatePreference(String token, PreferenceModel pref);

  Future<PreferenceModel> deletePreference(String token);

  Future<List<ProductModel>> getSaved(String token);

  Future<List<ProductModel>> getHistory(String token);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({
    @required this.client,
  });

  static const String urlAllergen = urlApp + 'api/allergens';
  static const String urlApp = Config.APP_URL;
  static const String urlDiet = urlApp + 'api/diets';
  static const String urlHistory = urlApp + 'api/user/history';
  static const String urlPreference = urlApp + 'api/preferences';
  static const String urlSaved = urlApp + 'api/user/saved';

  final http.Client client;

  ///Sends a Delete request to remote data source.
  ///
  ///Sends delete request to [urlPreference].
  ///[token] is required to verify user authentication.
  ///Returns [PreferenceModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<PreferenceModel> deletePreference(String token) async {
    final response = await client.delete(
      urlPreference,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return PreferenceModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  ///Sends a Post request to remote data source.
  ///
  ///Sends post request to [urlAllergen].
  ///[token] is required to verify user authentication.
  ///Returns list of [AllergenModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<List<AllergenModel>> getAllergens(String token) async {
    final response = await client.post(
      urlAllergen,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
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

  ///Sends a Post request to remote data source.
  ///
  ///Sends post request to [urlDiet].
  ///[token] is required to verify user authentication.
  ///Returns list of [DietModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<List<DietModel>> getDiets(String token) async {
    final response = await client.post(
      urlDiet,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<DietModel> diets =
          l.map((model) => DietModel.fromJson(model)).toList();
      return diets;
    } else {
      throw ServerException();
    }
  }

  ///Sends a Post request to remote data source.
  ///
  ///Sends post request to [urlHistory].
  ///[token] is required to verify user authentication.
  ///Returns list of [ProductModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<List<ProductModel>> getHistory(String token) async {
    final response = await client.post(
      urlHistory,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<ProductModel> history =
          l.map((model) => ProductModel.fromJson(model)).toList();
      return history;
    } else {
      throw ServerException();
    }
  }

  ///Sends a Get request to remote data source.
  ///
  ///Sends get request to [urlPreference].
  ///[token] is required to verify user authentication.
  ///Returns [PreferenceModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<PreferenceModel> getPreference(String token) async {
    final response = await client.get(
      urlPreference,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return PreferenceModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  ///Sends a Post request to remote data source.
  ///
  ///Sends post request to [urlSaved].
  ///[token] is required to verify user authentication.
  ///Returns list of [ProductModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<List<ProductModel>> getSaved(String token) async {
    final response = await client.post(
      urlSaved,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<ProductModel> saved =
          l.map((model) => ProductModel.fromJson(model)).toList();
      return saved;
    } else {
      throw ServerException();
    }
  }

  ///Sends a Patch request to remote data source.
  ///
  ///Sends patch request to [urlAllergen].
  ///[token] is required to verify user authentication.
  ///[allergenIds] is required to provide the allergen ids to select.
  ///Returns [String] message on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<String> selectAllergens(String token, List<int> allergenIds) async {
    final response = await client.patch(
      urlAllergen,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: (json.encode(allergenIds)),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      throw ServerException();
    }
  }

  ///Sends a Patch request to remote data source.
  ///
  ///Sends patch request to [urlDiet].
  ///[token] is required to verify user authentication.
  ///[dietIds] is required to provide the diet ids to select.
  ///Returns [String] message on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<String> selectDiets(String token, List<int> dietIds) async {
    final response = await client.patch(
      urlDiet,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: (json.encode(dietIds)),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      throw ServerException();
    }
  }

  ///Sends a Patch request to remote data source.
  ///
  ///Sends patch request to [urlPreference].
  ///[token] is required to verify user authentication.
  ///[pref] is required to update the user's preferences.
  ///Returns [PreferenceModel] on status code, 200.
  ///Else, throws a [ServerException].
  @override
  Future<PreferenceModel> updatePreference(
      String token, PreferenceModel pref) async {
    final response = await client.patch(
      urlPreference,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(pref),
    );

    if (response.statusCode == 200) {
      return PreferenceModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
