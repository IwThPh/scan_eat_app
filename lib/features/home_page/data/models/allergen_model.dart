import 'package:meta/meta.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';

///Extends [Allergen] to provide additional json funcationality.
class AllergenModel extends Allergen {
  AllergenModel({
    @required int id,
    @required String name,
    @required String description,
    @required bool selected,
  }) : super(
          id: id,
          name: name,
          description:description,
          selected:selected,
        );
        
  ///Generates [AllergenModel] from Json map.
  factory AllergenModel.fromJson(Map<String, dynamic> json) {
    return AllergenModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      selected: json['selected'],
    );
  }
}
