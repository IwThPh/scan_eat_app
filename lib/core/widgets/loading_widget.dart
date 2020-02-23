import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
    this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            maxHeight: 256,
            maxWidth: 256,
          ),
          child: Center(
            child: FlareActor(
              "lib/assets/animations/Loading.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: "go",
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 0,
          right: 0,
          child: Text(
            message ?? 'Loading',
            textAlign: TextAlign.center,
            style: AppTheme.theme.textTheme.subtitle
                .apply(color: Colours.offBlack),
          ),
        ),
      ],
    );
  }
}
