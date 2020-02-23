import 'package:meta/meta.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';

class DietModel extends Diet{
  DietModel({
    @required int id,
    @required String name,
    @required String description,
    @required bool selected,
  }) : super(
          id: id,
          name: name,
          description: description,
          selected: selected,
        );
        
  factory DietModel.fromJson(Map<String, dynamic> json) {
    return DietModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      selected: json['selected'],
    );
  }
}
