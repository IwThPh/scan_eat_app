import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

///Represents User entity.
class User extends Equatable {
  final String name;
  final String email;

  User({
    @required this.name,
    @required this.email,
  });

  @override
  List<Object> get props => [email];
  
}