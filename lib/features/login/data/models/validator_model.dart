import 'package:meta/meta.dart';
import '../../domain/entities/validator.dart';

class ValidatorModel extends Validator {
  ValidatorModel({
    @required nameError,
    @required emailError,
    @required passwordError,
  }) : super(
          nameError: nameError,
          emailError: emailError,
          passwordError: passwordError,
        );
        
  factory ValidatorModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> nameErrors = json['name'];
    List<dynamic> emailErrors = json['email'];
    List<dynamic> passwordErrors = json['password'];

    return ValidatorModel(
      nameError: nameErrors.first,
      emailError: emailErrors.first,
      passwordError: passwordErrors.first,
    );
  }
}
