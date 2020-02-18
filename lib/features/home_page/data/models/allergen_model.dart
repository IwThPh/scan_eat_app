import 'package:meta/meta.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';

class AllergenModel extends Allergen {
  AllergenModel({
    @required String name,
    @required String description,
  }) : super(
          name: name,
          description:description,
        );
        
  factory AllergenModel.fromJson(Map<String, dynamic> json) {
    return AllergenModel(
      name: json['name'],
      description: json['description'],
    );
  }
}
