import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/core/utils/routes_manager.dart';
import 'package:hesn_elmuslim/core/widgets/component.dart';
import 'package:hesn_elmuslim/features/duaa/data/models/azkar_categories.dart';
import 'package:hesn_elmuslim/features/duaa/presentation/duaa_cubit/duaa_cubit.dart';

import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../hadeth/presentation/widgets/list_item.dart';

class DuaaScreen extends StatelessWidget {
  const DuaaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'أدعية',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            BlocProvider.of<DuaaCubit>(context).azkarName =
                azkarCategories[index].toString().trim();
            navigator(context, Routes.duaaDetailsRoute);
          },
          child: FadeInRight(
            child: ListItemCustom(
                index: index,
                screen: Routes.duaaRoute,
                //     DuaaDetailsScreen(
                //   azkarName: azkarCategories[index].toString().trim(),
                // ),
                text: azkarCategories[index].toString(),
                image: 'pray'),
          ),
        ),
        itemCount: azkarCategories.length,
      ),
    );
  }
}
