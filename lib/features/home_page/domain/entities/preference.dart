import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Preference extends Equatable {
  final int userId;
  final double energyMax;
  final double carbohydrateMax;
  final double proteinMax;
  final double fatMax;
  final double fibreMax;
  final double saltMax;
  final double sugarMax;
  final double saturatedMax;
  final double sodiumMax;
  final double carbohydrate_1;
  final double carbohydrate_2;
  final double protein_1;
  final double protein_2;
  final double fat_1;
  final double fat_2;
  final double fibre_1;
  final double fibre_2;
  final double salt_1;
  final double salt_2;
  final double sugar_1;
  final double sugar_2;
  final double saturated_1;
  final double saturated_2;
  final double sodium_1;
  final double sodium_2;

  Preference({
    @required this.userId,
    @required this.energyMax,
    @required this.carbohydrateMax,
    @required this.proteinMax,
    @required this.fatMax,
    @required this.fibreMax,
    @required this.saltMax,
    @required this.sugarMax,
    @required this.saturatedMax,
    @required this.sodiumMax,
    @required this.carbohydrate_1,
    @required this.carbohydrate_2,
    @required this.protein_1,
    @required this.protein_2,
    @required this.fat_1,
    @required this.fat_2,
    @required this.fibre_1,
    @required this.fibre_2,
    @required this.salt_1,
    @required this.salt_2,
    @required this.sugar_1,
    @required this.sugar_2,
    @required this.saturated_1,
    @required this.saturated_2,
    @required this.sodium_1,
    @required this.sodium_2,
  });

  @override
  List<Object> get props => [userId];
}
