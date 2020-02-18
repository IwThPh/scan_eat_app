import 'package:meta/meta.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';

class DietModel extends Diet{
  DietModel({
    @required String name,
    @required String description,
  }) : super(
          name: name,
          description:description,
        );
        
  factory DietModel.fromJson(Map<String, dynamic> json) {
    return DietModel(
      name: json['name'],
      description: json['description'],
    );
  }
}
