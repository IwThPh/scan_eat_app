import 'di_container.dart' as di;

import 'package:flutter/material.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

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

  // Future<Product> getProduct($barcode) async {
  //   final response =
  //       await http.get('http://192.168.42.160:8000/api/product/'+$barcode);
  //   return Product.fromJson(jsonDecode(response.body));
  // }

  @override
  Widget build(BuildContext context) {
    return Text('Yeet');
  }
}