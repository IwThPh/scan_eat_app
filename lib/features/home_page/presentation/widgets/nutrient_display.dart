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
    final wCol = 30.0;

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Text(
              'Max : ${max}g',
              style:
                  AppTheme.theme.textTheme.caption.apply(color: Colours.offBlack),
            ),
            Flexible(
              flex: (s1 * 100).round(),
              child: Container(
                color: Colours.green,
                width: wCol,
              ),
            ),
            Flexible(
              flex: ((s2 - s1) * 100).round(),
              child: Container(
                color: Colours.orange,
                width: wCol,
              ),
            ),
            Flexible(
              flex: ((1 - s2) * 100).round(),
              child: Container(
                color: Colours.red,
                width: wCol,
              ),
            ),
            Text(
              name,
              style: AppTheme.theme.textTheme.body2
                  .apply(color: Colours.offBlack),
            ),
          ],
        ),
      ),
    );
  }
}
