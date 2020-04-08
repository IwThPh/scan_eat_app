import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Product extends Equatable {
  final String barcode;
  final String name;
  final List<int> allergenIds;
  final List<int> dietIds;
  final num weightG;
  final num servingG;
  final num energy_100g;
  final num carbohydrate_100g;
  final num protein_100g;
  final num fat_100g;
  final num fibre_100g;
  final num salt_100g;
  final num sugars_100g;
  final num saturates_100g;
  final num sodium_100g;

  Product(
      {@required this.barcode,
      @required this.name,
      @required this.allergenIds,
      @required this.dietIds,
      @required this.weightG,
      @required this.servingG,
      @required this.energy_100g,
      @required this.carbohydrate_100g,
      @required this.protein_100g,
      @required this.fat_100g,
      @required this.fibre_100g,
      @required this.salt_100g,
      @required this.sugars_100g,
      @required this.saturates_100g,
      @required this.sodium_100g});

  @override
  List<Object> get props => [barcode];
}
