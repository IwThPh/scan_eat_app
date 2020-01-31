import 'package:meta/meta.dart';
import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  AuthModel({
  @required String tokenType,
  @required String accessToken,
  @required String refreshToken,
  }) : super(
          tokenType: tokenType,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      tokenType: json['token_type'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
