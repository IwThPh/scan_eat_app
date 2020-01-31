import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Auth extends Equatable {
  final String tokenType;
  final String accessToken;
  final String refreshToken;

  Auth({
    @required this.tokenType,
    @required this.accessToken,
    @required this.refreshToken,
  });

  @override
  List<Object> get props => [tokenType, accessToken, refreshToken];
  
}