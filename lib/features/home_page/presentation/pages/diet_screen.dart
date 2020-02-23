import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';
import 'package:scaneat/features/home_page/presentation/widgets/name_desc_display.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({
    Key key,
    @required DietBloc dietBloc,
  })  : _dietBloc = dietBloc,
        super(key: key);

  final DietBloc _dietBloc;

  @override
  DietScreenState createState() {
    return DietScreenState(_dietBloc);
  }
}

class DietScreenState extends State<DietScreen> {
  final DietBloc _dietBloc;
  DietScreenState(this._dietBloc);

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DietBloc, DietState>(
      bloc: widget._dietBloc,
      builder: (
        BuildContext context,
        DietState currentState,
      ) {
        if (currentState is UnDietState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (currentState is ErrorDietState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ),
          );
        }
        if (currentState is InDietState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Diets',
                    style: AppTheme.theme.textTheme.subhead
                        .apply(color: Colors.white),
                  ),
                  Placeholder(
                    fallbackHeight: 20,
                    fallbackWidth: 100,
                  ),
                ],
              ),
              Divider(color: Colours.offWhite, thickness: 2,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 180,
                child: GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                  ),
                  children: currentState.diets
                      .map(
                        (a) => NameDescDisplay(
                          name: a.name,
                          desc: a.description,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  void _load() {
    widget._dietBloc.add(UnDietEvent());
    widget._dietBloc.add(LoadDietEvent());
  }
}
