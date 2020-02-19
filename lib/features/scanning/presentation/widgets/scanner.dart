import 'dart:developer' as developer;

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/core/widgets/loading_widget.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/di_container.dart' as di;

class Scanner extends StatelessWidget {
  final ScanningBloc scanningBloc;

  const Scanner({
    Key key,
    @required ScanningBloc scanningBloc,
  })  : scanningBloc = scanningBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: CameraMlVision<List<Barcode>>(
          detector: di.sl<BarcodeDetector>().detectInImage,
          loadingBuilder: (_) => Center(child: LoadingWidget()),
          overlayBuilder: (_) => Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 3,
              color: Colours.redAccent.withAlpha(128),
            ),
          ),
          resolution: ResolutionPreset.medium,
          onResult: (List<Barcode> barcodes) {
            if (barcodes.isNotEmpty) {
              String result = barcodes.first.rawValue;
              developer.log(result);
              if (scanningBloc.state is ScanScanningState) {
                scanningBloc.add(LoadingScanningEvent());
                scanningBloc.add(RetrieveProduct(result));
              }
            }
          },
        ),
      ),
    );
  }
}
