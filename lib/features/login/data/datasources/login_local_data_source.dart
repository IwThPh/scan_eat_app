
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/features/login/data/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  /// Gets the cached [AuthModel] if exists.
  /// Contains Bearer tokens for API authorisation.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<AuthModel> getAuth();

  Future<bool> cacheAuth(AuthModel auth);
}

const CACHED_AUTH = 'CACHED_AUTH';

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<AuthModel> getAuth() {
    final jsonString = sharedPreferences.getString(CACHED_AUTH);
    if (jsonString != null) {
      return Future.value(AuthModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheAuth(AuthModel auth) {
    return sharedPreferences.setString(
      CACHED_AUTH,
      json.encode(auth.toJson()),
    );
  }
}