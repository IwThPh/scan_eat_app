import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Product extends Equatable {
  final String barcode;
  final String name;
  final double weight_g;
  final double energy_100g;
  final double carbohydrate_100g;
  final double protein_100g;
  final double fat_100g;
  final double fiber_100g;
  final double salt_100g;
  final double sugars_100g;
  final double saturates_100g;
  final double sodium_100g;

  Product(
      {@required this.barcode,
      @required this.name,
      @required this.weight_g,
      @required this.energy_100g,
      @required this.carbohydrate_100g,
      @required this.protein_100g,
      @required this.fat_100g,
      @required this.fiber_100g,
      @required this.salt_100g,
      @required this.sugars_100g,
      @required this.saturates_100g,
      @required this.sodium_100g});

  @override
  List<Object> get props => [barcode];
}
