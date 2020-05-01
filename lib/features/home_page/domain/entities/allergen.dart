import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

///Represents Allergen entity.
class Allergen extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool selected;

  Allergen({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.selected,
  });

  @override
  List<Object> get props => [id, selected];
}
