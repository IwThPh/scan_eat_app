import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/login/presentation/pages/login_page_screen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ShapeBorder for Panel
    ShapeBorder sb = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.elliptical(MediaQuery.of(context).size.width + 30, 80),
      ),
    );

    //ShapeBorder for Card
    ShapeBorder cb = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.elliptical(MediaQuery.of(context).size.width + 30, 80),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0, -2),
                  end: Alignment(0, 1),
                  stops: [0.1, 1],
                  colors: [
                    Colours.green,
                    Colours.primary,
                  ],
                ),
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    centerTitle: true,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    expandedHeight: constraints.maxHeight / 2.8,
                    bottom: PreferredSize(
                      preferredSize: Size(174, 72),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 16,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'lib/assets/icon/logo.png',
                            height: 52,
                            width: 154,
                            semanticLabel: 'ScanEat Logo',
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                    flexibleSpace: ClipPath.shape(
                      shape: sb,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Image.asset(
                          'lib/assets/icon/test.jpg',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Card(
                      elevation: 8.0,
                      shape: cb,
                      child: Center(
                        child: LoginPageScreen(),
                      ),
                      margin: EdgeInsets.all(30),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
