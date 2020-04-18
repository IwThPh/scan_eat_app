import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget content;

  CustomDialog({
    @required this.title,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 20 + 8.0,
            bottom: 8.0,
            left: 12.0,
            right: 12.0,
          ),
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              content,
            ],
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            backgroundColor: Colours.primary,
            radius: 25,
          ),
        ),
      ],
    );
  }
}
