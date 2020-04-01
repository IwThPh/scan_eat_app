import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/app_theme.dart';

class NutrientListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;

  NutrientListTile({
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: AppTheme.theme.textTheme.title.apply(color: Colours.offBlack),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.theme.textTheme.subtitle.apply(color: Colours.offBlack),
      ),
      trailing: Icon(Icons.edit),
      onTap: onTap,
    );
  }
}
