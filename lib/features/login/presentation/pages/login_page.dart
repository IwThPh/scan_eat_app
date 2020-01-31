import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:scaneat/features/login/presentation/pages/login_page_screen.dart';
import 'package:scaneat/di_container.dart' as di;

class LoginPage extends StatelessWidget {
  static const String routeName = '/loginPage';
  final LoginPageBloc _loginPageBloc = di.sl<LoginPageBloc>();

  @override
  Widget build(BuildContext context) {
    //ShapeBorder for Panel
    ShapeBorder sb = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.elliptical(MediaQuery.of(context).size.width + 30, 135),
      ),
    );

    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        RotatedBox(
          quarterTurns: 3,
          child: Image.asset(
            //TODO: Dynamic BG would be cool to add.
            'lib/assets/icon/test.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverSpacer(),
                SliverPersistentHeader(
                  delegate: HeaderDelegate(),
                  pinned: true,
                ),
                SliverSpacer(),
                SliverFillRemaining(
                  fillOverscroll: false,
                  hasScrollBody: false,
                  child: ClipPath.shape(
                    shape: sb,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(0, 1),
                          stops: [0.1, 1],
                          radius: 3,
                          colors: [
                            Colours.primary,
                            Colours.green,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.all(60),
                          color: Colours.offWhite,
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child:
                                  LoginPageScreen(loginPageBloc: _loginPageBloc)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom persistant header for Login Sliver.
///
/// Used incase the user's phone is too small in height to support
/// the ui as well as an onscreen keyboard.
class HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        elevation: 16,
        child: Container(
          decoration: BoxDecoration(
            color: Colours.offWhite,
          ),
          height: constraints.maxHeight,
          child: SafeArea(
            child: Center(
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
      );
    });
  }

  @override
  double get maxExtent => 88;

  @override
  double get minExtent => 72;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;
}

class SliverSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    );
  }
}