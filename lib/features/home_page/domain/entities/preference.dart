import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Preference extends Equatable {
  final int user_id;
  final double energy_max;
  final double carbohydrate_max;
  final double protein_max;
  final double fat_max;
  final double fiber_max;
  final double salt_max;
  final double sugar_max;
  final double saturated_max;
  final double sodium_max;
  final double carbohydrate_1;
  final double carbohydrate_2;
  final double protein_1;
  final double protein_2;
  final double fat_1;
  final double fat_2;
  final double fiber_1;
  final double fiber_2;
  final double salt_1;
  final double salt_2;
  final double sugar_1;
  final double sugar_2;
  final double saturated_1;
  final double saturated_2;
  final double sodium_1;
  final double sodium_2;

  Preference({
    @required this.user_id,
    @required this.energy_max,
    @required this.carbohydrate_max,
    @required this.protein_max,
    @required this.fat_max,
    @required this.fiber_max,
    @required this.salt_max,
    @required this.sugar_max,
    @required this.saturated_max,
    @required this.sodium_max,
    @required this.carbohydrate_1,
    @required this.carbohydrate_2,
    @required this.protein_1,
    @required this.protein_2,
    @required this.fat_1,
    @required this.fat_2,
    @required this.fiber_1,
    @required this.fiber_2,
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
  List<Object> get props => [user_id];
}
