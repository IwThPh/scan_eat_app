import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Diet extends Equatable {
  final String name;
  final String description;

  Diet({
    @required this.name,
    @required this.description,
  });

  @override
  List<Object> get props => [name, description];
}
