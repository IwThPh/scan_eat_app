import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../../di_container.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class ScanningPage extends StatelessWidget {
  ScanningPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (_) => sl<ScanningBloc>(),
        child: SingleChildScrollView(child: buildBody(context)),
      ),
    );
  }

  BlocProvider<ScanningBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<ScanningBloc>(),
      child: Container(
        color: Colours.primaryAccent,
        padding: const EdgeInsets.all(23.0),
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                child: CameraMlVision<List<Barcode>>(
                  detector:
                      FirebaseVision.instance.barcodeDetector().detectInImage,
                  onResult: (List<Barcode> barcodes) {
                    BlocListener<ScanningBloc, ScanningState> listener;
                    if (listener.bloc.state is Scanning) {
                      Barcode result = barcodes.first;
                      BlocProvider.of<ScanningBloc>(context)
                          .add(RetrieveProduct(result.toString()));
                    }
                  },
                ),
              ),
              Container(
                child: ManualControls(),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: BlocBuilder<ScanningBloc, ScanningState>(
                  builder: (context, state) {
                    if (state is Scanning) {
                      return ProductDisplay(
                        message: 'Search Product',
                      );
                    } else if (state is Error) {
                      return ProductDisplay(
                        message: state.message,
                      );
                    } else if (state is Loading) {
                      return LoadingWidget();
                    } else if (state is Loaded) {
                      return ProductDisplay(
                        message: 'Product Found',
                        product: state.product,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
