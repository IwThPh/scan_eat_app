import 'dart:developer';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String result;

  @override
  Widget build(BuildContext context) {
    BarcodeDetector detector = FirebaseVision.instance.barcodeDetector();
    final _scanKey = GlobalKey<CameraMlVisionState>();

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: CameraMlVision<List<Barcode>>(
        key: _scanKey,
        detector: detector.detectInImage,
        onResult: (List<Barcode> barcodes) {
          if (barcodes.isNotEmpty) {
            result = barcodes.first.rawValue;
            log(result);
            addRetrieveProduct();
          }
        },
      ),
    );
  }

  void addRetrieveProduct() {
    BlocProvider.of<ScanningBloc>(context).add(RetrieveProduct(result));
  }
}
