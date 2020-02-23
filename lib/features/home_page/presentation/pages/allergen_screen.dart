import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/bloc.dart';
import 'package:scaneat/features/home_page/presentation/widgets/name_desc_display.dart';
import '../widgets/widgets.dart';

class AllergenScreen extends StatefulWidget {
  const AllergenScreen({
    Key key,
    @required AllergenBloc allergenBloc,
  })  : _allergenBloc = allergenBloc,
        super(key: key);

  final AllergenBloc _allergenBloc;

  @override
  AllergenScreenState createState() {
    return AllergenScreenState(_allergenBloc);
  }
}

class AllergenScreenState extends State<AllergenScreen> {
  final AllergenBloc _allergenBloc;
  AllergenScreenState(this._allergenBloc);

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
    return BlocBuilder<AllergenBloc, AllergenState>(
      bloc: widget._allergenBloc,
      builder: (
        BuildContext context,
        AllergenState currentState,
      ) {
        if (currentState is UnAllergenState) {
          return Center(
            child: LoadingWidget(),
          );
        }
        if (currentState is ErrorAllergenState) {
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
        if (currentState is InAllergenState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Allergens',
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
                  children: currentState.allergens
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

  void _load([bool isError = false]) {
    widget._allergenBloc.add(UnAllergenEvent());
    widget._allergenBloc.add(LoadAllergenEvent());
  }
}
