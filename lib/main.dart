import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var barcodeRes = 'No result';

  Future<void> scanBarcode() async {
    String barcode;
    try {
      barcode = await FlutterBarcodeScanner.scanBarcode(
          '#555555', 'cancelButtonText', false, ScanMode.BARCODE);
      print(barcode);
    } on PlatformException {
      barcode = "Failed to scan";
    }

    setState(() {
      barcodeRes = barcode;
    });
  }

  Widget scanNewBarcode() {
    String barcode;

    return AlertDialog(
      content: SizedBox(
        width: 300,
        height: 600,
        child: QrCamera(
          qrCodeCallback: (barcode) {
            setState(() {
              barcodeRes = barcode;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Barcode of Scanned Item:',
            ),
            Text(
              '$barcodeRes',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: <Widget>[
          FloatingActionButton(
              onPressed: () => scanBarcode(),
              tooltip: 'Scan',
              child: Icon(Icons.scanner)),
          FloatingActionButton(
              onPressed: () => scanNewBarcode(),
              tooltip: 'Scan',
              child: Icon(
                Icons.scanner,
                color: Colors.cyan,
              )),
        ],
      ),
    );
  }
}
