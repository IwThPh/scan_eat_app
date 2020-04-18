import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/home_page/domain/entities/nutrient.dart';

class ProductNutrient extends StatefulWidget {
  const ProductNutrient({
    Key key,
    @required this.name,
    @required this.value_100g,
    @required this.per,
    this.unit = 'g',
    @required this.pref,
  }) : super(key: key);

  final String name;
  final double per;
  final Nutrient pref;
  final String unit;
  final double value_100g;

  @override
  _ProductNutrientState createState() => _ProductNutrientState();
}

class _ProductNutrientState extends State<ProductNutrient> {
  bool loaded = false;
  double absValue;
  Color bg = Colours.offBlack;
  TextStyle bodyText;
  Color fg = Colours.offWhite;
  double percentageOfMax;

  @override
  void initState() {
    super.initState();
    calculate();
  }

  void calculate() {
    absValue = (widget.value_100g / 100) * widget.per;
    percentageOfMax =
        (((widget.value_100g / 100) * widget.per) / widget.pref.nutrientMax);

    if (widget.unit == 'g') {
      if (percentageOfMax < widget.pref.nutrient_1) {
        fg = Colours.green;
        bg = Colours.greenAccent;
      } else if (percentageOfMax < widget.pref.nutrient_2) {
        fg = Colours.orange;
        bg = Colours.orangeAccent;
      } else {
        fg = Colours.red;
        bg = Colours.redAccent;
      }
    }

    bodyText = (fg == Colours.offWhite)
        ? TextStyle(color: Colours.offBlack)
        : TextStyle(color: Colours.offWhite);

    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned.fill(
            bottom: -3,
            left: -3,
            child: Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 40),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
            decoration: BoxDecoration(
              color: fg,
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            child: (!loaded)
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 2,
                  )
                : Column(
                    children: <Widget>[
                      Text(
                        widget.name,
                        style:
                            Theme.of(context).textTheme.caption.merge(bodyText),
                      ),
                      Text(
                        absValue.round().toString().trim() + widget.unit,
                        style:
                            Theme.of(context).textTheme.body2.merge(bodyText),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        ),
                        child: Text(
                          (percentageOfMax * 100).round().toString().trim() +
                              '%',
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .apply(color: Colours.offBlack),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
