import 'package:meta/meta.dart';
import '../../domain/entities/validator.dart';

///Extends [Validator] to provide additional json funcationality.
class ValidatorModel extends Validator {
  ValidatorModel({
    @required String nameError,
    @required String emailError,
    @required String passwordError,
  }) : super(
          nameError: nameError,
          emailError: emailError,
          passwordError: passwordError,
        );
        
  ///Generates [ValidatorModel] from Json map.
  factory ValidatorModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> nameErrors = json.containsKey('name') ? json['name'] : [];
    List<dynamic> emailErrors = json.containsKey('email') ? json['email'] : [];
    List<dynamic> passwordErrors = json.containsKey('password') ? json['password'] : [];

    return ValidatorModel(
      nameError: nameErrors.length > 0 ? nameErrors[0] : "",
      emailError: emailErrors.length > 0 ? emailErrors[0] : "",
      passwordError: passwordErrors.length > 0 ? passwordErrors[0] : "",
    );
  }
}
