import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scaneat/features/home_page/presentation/pages/nutrient_edit.dart';

/// Nutrient entity.
/// 
/// Used for represent sliders for use in [NutrientEdit].
class Nutrient {
  double nutrientMax;
  double nutrient_1;
  double nutrient_2;
  RangeValues range;

  Nutrient({
    @required this.nutrientMax,
    this.nutrient_1 = 0,
    this.nutrient_2 = 1,
  }) : range =
            RangeValues(nutrient_1 * nutrientMax, nutrient_2 * nutrientMax);
}
