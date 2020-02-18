import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/core/animations/SlideBottomRoute.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';
import 'package:scaneat/features/home_page/presentation/pages/home_page_screen.dart';
import 'package:scaneat/features/scanning/presentation/pages/scanning_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    var _homePageBloc = HomePageBloc();
    return SafeArea(
      child: GestureDetector(
        onPanUpdate: (details) {
          if(details.delta.dy > 0){
            _scan(context);
          }
        },
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () => _scan(context),
              ),
            ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, 0),
                stops: [0.1, 1],
                radius: 3,
                colors: [
                  Colours.primary,
                  Colours.green,
                ],
              ),
            ),
            child: Container(
              child: HomePageScreen(
                homePageBloc: _homePageBloc,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _scan(BuildContext context) {
    Navigator.push(
      context,
      SlideBottomRoute(page: ScanningPage()),
    );
  }
}
