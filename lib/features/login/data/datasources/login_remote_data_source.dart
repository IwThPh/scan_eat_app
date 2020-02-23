import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:meta/meta.dart';
import 'package:scaneat/config.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/data/models/auth_model.dart';
import 'package:scaneat/features/login/data/models/user_model.dart';
import 'package:scaneat/features/login/data/models/validator_model.dart';

import '../../../../core/error/exception.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> retrieveUser(String token);
  Future<AuthModel> attemptLogin(String email, String password);
  Future<Either<ValidatorModel, AuthModel>> attemptRegister(
      String name, String email, String password, String c_password);
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

    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<ValidatorModel, AuthModel>> attemptRegister(
      String name, String email, String password, String c_password) async {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['confirm_password'] = password;

    final response = await client.post(
      Config.APP_URL + 'api/auth/register',
      body: map,
    );

    if (response.statusCode == 200) {
      return Right(AuthModel.fromJson(jsonDecode(response.body)));
    } else {
      try {
        return Left(ValidatorModel.fromJson(jsonDecode(response.body)));
      } catch (ServerException) {
        debugPrint(response.body);
        throw ServerFailure();
      }
    }
  }

  @override
  Future<UserModel> retrieveUser(String token) async {
    final response = await client.post(
      Config.APP_URL + 'api/user',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
