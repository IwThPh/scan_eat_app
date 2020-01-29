import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      height:256,
      child: Center(
        child: FlareActor(

          "lib/assets/animations/Loading.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "go",
        ),
      ),
    );
  }
}
