import 'package:meta/meta.dart';
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {@required String barcode,
      @required String name,
      @required num weight_g,
      @required num energy_100g,
      @required num carbohydrate_100g,
      @required num protein_100g,
      @required num fat_100g,
      @required num fibre_100g,
      @required num salt_100g,
      @required num sugars_100g,
      @required num saturates_100g,
      @required num sodium_100g})
      : super(
          barcode: barcode,
          name: name,
          weight_g: weight_g,
          energy_100g: energy_100g,
          carbohydrate_100g: carbohydrate_100g,
          protein_100g: protein_100g,
          fat_100g: fat_100g,
          fibre_100g: fibre_100g,
          salt_100g: salt_100g,
          sugars_100g: sugars_100g,
          saturates_100g: saturates_100g,
          sodium_100g: sodium_100g,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      barcode: json['barcode'],
      name: json['name'],
      weight_g: json['weight_g']?.toDouble(),
      energy_100g: json['energy_100g']?.toDouble(),
      carbohydrate_100g: json['carbohydrate_100g']?.toDouble(),
      protein_100g: json['protein_100g']?.toDouble(),
      fat_100g: json['fat_100g']?.toDouble(),
      fibre_100g: json['fibre_100g']?.toDouble(),
      salt_100g: json['salt_100g']?.toDouble(),
      sugars_100g: json['sugar_100g']?.toDouble(),
      saturates_100g: json['saturated_100g']?.toDouble(),
      sodium_100g: json['sodium_100g']?.toDouble(),
    );
  }
}
