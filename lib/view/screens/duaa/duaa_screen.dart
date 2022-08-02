import 'package:flutter/material.dart';
import 'package:hesn_elmuslim/model/duaa/azkar_categories.dart';
import 'package:hesn_elmuslim/view/screens/main_page.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/component.dart';
import 'package:hesn_elmuslim/view/widgets/list_item.dart';
import 'package:hesn_elmuslim/view/widgets/scaffold_custom/scaffold_custom.dart';
import 'duaa_details_screen.dart';

class DuaaScreen extends StatelessWidget {
  const DuaaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scaffoldCustom(
      appBarCustom: appBarCustom(
        context: context,
        leading: 'أدعية',
        onPressed: () {
          navigatorAndRemove(context, const MainPage());
        },
      ),
      body: ListView.builder(
        itemBuilder: (context, index) =>ListItemCustom(screen: DuaaDetailsScreen(
          azkarName: azkarCategories[index].toString().trim(),
        ), text: azkarCategories[index].toString(), image: 'pray'),
        itemCount: azkarCategories.length,
      ),
    );
  }

}
