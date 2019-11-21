import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/theme/app_theme.dart';
import '../bloc/bloc.dart';
import '../widgets/scanner.dart';
import '../widgets/widgets.dart';

class ScanningPage extends StatelessWidget {
  ScanningPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    //ShapeBorder fo BottomSheet
    ShapeBorder sb = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0),
        topRight: Radius.circular(32.0),
      ),
    );

    return SafeArea(
      child: Container(
        color: Colours.primaryAccent,
        padding: const EdgeInsets.all(23.0),
        height: MediaQuery.of(context).size.height,
        child: BlocListener<ScanningBloc, ScanningState>(
          bloc: BlocProvider.of<ScanningBloc>(context),
          condition: (prev, next) {
            return (prev is Scanning && (next is Loading || next is UserInput));
          },
          listener: (context, state) {
            showModalBottomSheet<void>(
              context: context,
              shape: sb,
              builder: (_) => BottomSheet(
                shape: sb,
                backgroundColor: Colours.primary,
                builder: (_) => ProductDialog(),
                onClosing: () {},
              ),
            ).whenComplete(() =>
                BlocProvider.of<ScanningBloc>(context).add(ScanProduct()));
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Spacer(),
              Scanner(),
              Spacer(),
              ManualControls(),
            ],
          ),
        ),
      ),
    );
  }
}
