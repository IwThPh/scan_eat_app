import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/product/presentation/bloc/product/bloc.dart';

class ProductTitle extends StatefulWidget {
  ProductTitle({
    Key key,
    @required ProductBloc productBloc,
  }) : productBloc = productBloc;

  final ProductBloc productBloc;

  @override
  _ProductTitleState createState() => _ProductTitleState();
}

class _ProductTitleState extends State<ProductTitle> {
  bool localSave;

  @override
  void initState() {
    super.initState();
    localSave = widget.productBloc.state.product.saved;
  }

  void _save(bool isSave) {
    setState(() {
      localSave = isSave;
    });
    widget.productBloc.add(SaveProductEvent(isSave));
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              widget.productBloc.state.product.name,
              textAlign: TextAlign.left,
              style:
                  AppTheme.theme.textTheme.title.apply(color: Colours.offBlack),
            ),
          ),
        ),
        BlocConsumer(
          bloc: widget.productBloc,
          listener: (context, state) =>
              setState(() => localSave = state.product.saved),
          builder: (context, state) => IconButton(
            icon: Icon(localSave ? Icons.favorite : Icons.favorite_border),
            color: Colours.primary,
            onPressed: () => _save(!localSave),
          ),
        )
      ],
    );
  }
}
