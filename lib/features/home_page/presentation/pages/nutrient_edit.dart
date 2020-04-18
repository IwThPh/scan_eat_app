import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/home_page/domain/entities/nutrient.dart';
import 'dart:math';

class NutrientEdit extends StatefulWidget {
  final Nutrient _nutrient;
  final double _min;
  final double _max;
  final String _unit;
  final bool _isRange;

  const NutrientEdit({
    Key key,
    @required Nutrient nutrient,
    @required double min,
    @required double max,
    @required String unit,
    @required bool isRange,
  })  : _nutrient = nutrient,
        _min = min,
        _max = max,
        _unit = unit,
        _isRange = isRange,
        super(key: key);

  @override
  _NutrientEditState createState() =>
      _NutrientEditState(_nutrient, _max, _min, _unit, _isRange);
}

class _NutrientEditState extends State<NutrientEdit> {
  final Nutrient _nutrient;
  final double _max;
  final double _min;
  final String _unit;
  final bool _isRange;

  _NutrientEditState(
      this._nutrient, this._max, this._min, this._unit, this._isRange);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Daily Max: ${_nutrient.nutrientMax}$_unit'),
          Slider(
            value: _nutrient.nutrientMax,
            min: _min,
            max: _max,
            onChanged: (newValue) {
              setState(() {
                newValue = roundDouble(newValue, 2);
                if (_isRange) {
                  if (newValue < _nutrient.range.end) {
                    if (newValue < _nutrient.range.start) {
                      _nutrient.range = RangeValues(newValue, newValue);
                    } else {
                      _nutrient.range =
                          RangeValues(_nutrient.range.start, newValue);
                    }
                  }
                  updateRatio();
                }
                _nutrient.nutrientMax = newValue;
              });
            },
            label: "${_nutrient.nutrientMax}" + _unit,
            inactiveColor: Colours.offWhite,
            activeColor: Colours.primary,
          ),
          rangeSlider(_isRange),
        ],
      ),
    );
  }

  Widget rangeSlider(bool isRange) {
    double _height = 50;
    if (isRange) {
      return Column(
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Low-Med: ${_nutrient.range.start.toStringAsFixed(2)}$_unit'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Med-High: ${_nutrient.range.end.toStringAsFixed(2)}$_unit'),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Flexible(
                      flex: (_nutrient.nutrient_1 * 100).round(),
                      child: Container(
                        color: Colours.green,
                        height: _height,
                      ),
                    ),
                    Flexible(
                      flex:
                          ((_nutrient.nutrient_2 - _nutrient.nutrient_1) * 100)
                              .round(),
                      child: Container(
                        color: Colours.orange,
                        height: _height,
                      ),
                    ),
                    Flexible(
                      flex: ((1 - _nutrient.nutrient_2) * 100).round(),
                      child: Container(
                        color: Colours.red,
                        height: _height,
                      ),
                    ),
                  ],
                ),
              ),
              RangeSlider(
                values: _nutrient.range,
                min: _min,
                max: _nutrient.nutrientMax,
                divisions: 100,
                onChanged: (RangeValues newValue) {
                  setState(() {
                    _nutrient.range = newValue;
                    updateRatio();
                  });
                },
                inactiveColor: Colours.offWhite,
                activeColor: Colours.primary,
              ),
            ],
          ),
        ],
      );
    }
    return Container(
      width: 0,
      height: 0,
    );
  }

  void updateRatio() {
    _nutrient.nutrient_1 = _nutrient.range.start / _nutrient.nutrientMax;
    _nutrient.nutrient_2 = _nutrient.range.end / _nutrient.nutrientMax;
  }
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
