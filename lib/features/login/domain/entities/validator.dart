import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Validator extends Equatable {
  final String nameError;
  final String emailError;
  final String passwordError;

  Validator({
    @required this.nameError,
    @required this.emailError,
    @required this.passwordError,
  });

  @override
  List<Object> get props => [nameError, emailError, passwordError];
  
}