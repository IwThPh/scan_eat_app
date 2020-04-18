import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({
    this.title,
  });

  final Widget title;

  @override
  Size get preferredSize => Size.fromHeight(54);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0, bottom: 0.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colours.offBlack,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Container(
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(),
                  child: title,
                ),
              ],
            ),
            Divider(
              color: Colours.offBlack,
              thickness: 2,
              height: 2,
            )
          ],
        ),
      ),
    );
  }
}
