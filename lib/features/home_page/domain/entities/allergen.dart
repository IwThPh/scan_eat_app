import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Allergen extends Equatable {
  final String name;
  final String description;

  Allergen({
    @required this.name,
    @required this.description,
  });

  @override
  List<Object> get props => [name, description];
}
