import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/di_container.dart' as di;

class Scanner extends StatefulWidget {
  Scanner({
    Key key,
    @required ScanningBloc scanningBloc,
  })  : scanningBloc = scanningBloc,
        super(key: key);

  final ScanningBloc scanningBloc;

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  BarcodeDetector detector;

  @override
  void initState() {
    super.initState();
    detector = di.sl<BarcodeDetector>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.0),
          child: CameraMlVision<List<Barcode>>(
            detector: detector.detectInImage,
            overlayBuilder: (_) => Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 3,
                color: Colours.redAccent.withAlpha(128),
              ),
            ),
            resolution: ResolutionPreset.medium,
            onResult: (List<Barcode> barcodes) {
              log(barcodes.length.toString());
              if (barcodes.isNotEmpty) {
                String result = barcodes.first.rawValue;
                if (widget.scanningBloc.state is ScanScanningState) {
                  widget.scanningBloc.add(LoadingScanningEvent());
                  widget.scanningBloc.add(RetrieveProduct(result));
                }
              }
            },
          ),
        ),
    );
  }
}
