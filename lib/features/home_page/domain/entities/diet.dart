import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

///Represents Diet entity.
class Diet extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool selected;

  Diet({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.selected,
  });

  @override
  List<Object> get props => [id, selected];
}
