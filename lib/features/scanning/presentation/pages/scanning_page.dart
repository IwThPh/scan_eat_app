import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_label_app/di_container.dart';
import 'package:food_label_app/features/scanning/presentation/bloc/bloc.dart';
import '../widgets/widgets.dart';

import 'package:flutter/material.dart';

class ScanningPage extends StatelessWidget {
  ScanningPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocProvider(
        builder: (_) => sl<ScanningBloc>(),
        child: SingleChildScrollView(child: buildBody(context)),
      ),
    );
  }

  BlocProvider<ScanningBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<ScanningBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Placeholder(),
              ),
              SizedBox(
                height: 10.0,
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
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: ManualControls(),
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
