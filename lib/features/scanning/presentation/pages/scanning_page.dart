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
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32.0),
      ),
    );

    return SafeArea(
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
            builder: (_) => SingleChildScrollView(child: ProductDialog()),
            onClosing: () {},
          ),
        ).whenComplete(
            () => BlocProvider.of<ScanningBloc>(context).add(ScanProduct()));
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colours.primaryAccent,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(23.0),
            height: MediaQuery.of(context).size.height - 50.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Scanner(),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: OutlineButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 50.0),
                    textTheme: ButtonTextTheme.normal,
                    highlightColor: Colours.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    highlightedBorderColor: Colours.green,
                    borderSide: BorderSide(
                        color: Colours.offWhite,
                        style: BorderStyle.solid,
                        width: 2.0),
                    child: Text(
                      'Manual Input',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(color: Colours.offWhite),
                    ),
                    onPressed: () =>
                        BlocProvider.of<ScanningBloc>(context).add(ManualInput()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
