import 'package:meta/meta.dart';
import '../../domain/entities/auth.dart';

///Extends [Auth] to provide additional json funcationality.
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
        
  ///Generates [AuthModel] from Json map.
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      tokenType: json['token_type'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  ///Generates Json map.
  Map<String, dynamic> toJson() {
    return {
      'token_type': tokenType,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
