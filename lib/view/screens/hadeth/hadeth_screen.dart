import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/screens/hadeth/hadeth_details_screen.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/list_item.dart';

import '../../../cubit/hadeth/hadeth_cubit.dart';
import '../../../cubit/hadeth/hadeth_state.dart';
import '../../widgets/scaffold_custom/scaffold_custom.dart';
import '../../widgets/text_custom/text_custom.dart';

class HadethCategoriesScreen extends StatelessWidget {
  const HadethCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scaffoldCustom(
      appBarCustom: appBarCustom(
          context: context,
          leading: 'الاحاديث النبوية',
          onPressed: () {
            Navigator.pop(context);
          }),
      body: BlocProvider(
        create: (context) =>
        HadethCubit()
          ..getHadeth(),
        child: BlocConsumer<HadethCubit, HadethStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HadethCubit.get(context);

            return ConditionalBuilder(
              condition: cubit.list.isNotEmpty,
              builder: (context) {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.list.length,
                    shrinkWrap: true,
                    itemExtent: 90,
                    itemBuilder: (BuildContext context, int index) =>
                        ListItemCustom(screen: HadethDetailsScreen(
                          id: cubit.list[index]['id']
                              .toString(),
                          name: cubit.list[index]['title'],
                        ),
                          text: cubit.list[index]['title'],
                          image: 'muslim',
                          leading: textCustom(
                            context: context,
                            text:
                            "(${cubit.list[index]['hadeeths_count']})",
                            fontSize: 16.sp,
                          ),),

                );
              },
              fallback: (context) =>
              const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
