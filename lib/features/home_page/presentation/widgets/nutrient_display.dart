import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/assets/theme/colours.dart';

class NutrientDisplay extends StatelessWidget {
  final String name;
  final String max;
  final double s1;
  final double s2;

  const NutrientDisplay({Key key, this.name, this.max, this.s1, this.s2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style:
                    AppTheme.theme.textTheme.body1.apply(color: Colors.white),
              ),
              Text(
                'Daily Max : ' + max + 'g',
                style:
                    AppTheme.theme.textTheme.body2.apply(color: Colors.white),
              ),
            ],
          ),
          Container(
            height: 10,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  flex: (s1 * 100).round(),
                  child: Container(color: Colours.green),
                ),
                Flexible(
                  flex: ((s2 - s1) * 100).round(),
                  child: Container(color: Colours.orange),
                ),
                Flexible(
                    flex: ((1 - s2) * 100).round(),
                    child: Container(
                      color: Colours.red,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
