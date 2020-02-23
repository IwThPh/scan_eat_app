import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';

class NameDescDisplay extends StatelessWidget {
  final String name;
  final String desc;

  const NameDescDisplay({Key key, this.name, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colours.offWhite,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name?? "Not Defined",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              desc?? "Not Defined",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }
}