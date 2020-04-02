import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Nutrient {
  double nutrient_max;
  double nutrient_1;
  double nutrient_2;
  RangeValues range;

  Nutrient({
    @required this.nutrient_max,
    this.nutrient_1 = 0,
    this.nutrient_2 = 1,
  }) : range =
            RangeValues(nutrient_1 * nutrient_max, nutrient_2 * nutrient_max);
}
