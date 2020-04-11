
import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    @required this.content,
  });

  final Widget content;

  dialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 16.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              content,
            ],
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            child: Icon(
              Icons.view_headline,
              color: Colors.white,
            ),
            backgroundColor: Colours.primary,
            radius: 20,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 12,
      backgroundColor: Colors.transparent,
      insetAnimationCurve: Curves.easeInOutSine,
      insetAnimationDuration: Duration(milliseconds: 500),
      child: dialogContent(context),
    );
  }
}
