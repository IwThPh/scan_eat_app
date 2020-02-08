import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:meta/meta.dart';
import 'package:scaneat/config.dart';
import 'package:scaneat/features/login/data/models/auth_model.dart';

import '../../../../core/error/exception.dart';

abstract class LoginRemoteDataSource {
  Future<AuthModel> attemptLogin(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<AuthModel> attemptLogin(String email, String password) async {
    var map = new Map<String, dynamic>();
    map['username'] = email;
    map['password'] = password;

    final response = await client.post(
      Config.APP_URL + 'api/auth/token',
      body: map,
    );

    developer.log(Config.APP_URL + 'api/auth/token');
    debugPrint(response.body);

    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
