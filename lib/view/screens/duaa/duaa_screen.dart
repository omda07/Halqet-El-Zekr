import 'package:flutter/material.dart';
import 'package:hesn_elmuslim/model/duaa/azkar_categories.dart';
import 'package:hesn_elmuslim/view/screens/main_page.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/component.dart';
import 'package:hesn_elmuslim/view/widgets/scaffold_custom/scaffold_custom.dart';
import '../../widgets/text_custom/text_custom.dart';
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
        itemBuilder: (context, index) => _buildListItem(context, index),
        itemCount: azkarCategories.length,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            offset: const Offset(0.6, 1.2), //(x,y)
            blurRadius: 6.0,
          ),
        ],
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DuaaDetailsScreen(
                azkarName: azkarCategories[index].toString().trim(),
              ),
            ),
          );
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 18, top: 10, bottom: 10, left: 15),
              child: Image.asset(
                'assets/images/pray.png',
                width: 60,
              ),
            ),
            Flexible(
              child: Center(
                child: textCustom(
                  context: context,
                  text: azkarCategories[index].toString(),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
