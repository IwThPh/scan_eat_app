import 'package:meta/meta.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';

///Extends [User] to provide additional json funcationality.
class UserModel extends User {
  UserModel({
  @required String name,
  @required String email,
  }) : super(
          name: name,
          email: email,
        );
        
  ///Generates [UserModel] from Json map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
    );
  }
}
