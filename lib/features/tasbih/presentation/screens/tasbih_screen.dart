import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/utils/routes_manager.dart';
import 'package:hesn_elmuslim/core/widgets/component.dart';
import 'package:hesn_elmuslim/core/widgets/scaffold_custom/scaffold_custom.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../hadeth/presentation/widgets/list_item.dart';
import '../tasbih_cubit/tasbih_cubit.dart';
import '../tasbih_cubit/tasbih_state.dart';

class TasbehScreen extends StatelessWidget {
  const TasbehScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'التسبيح',
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<TasbihCubit>(context)
          ..getTasbeh(context: context),
        child: BlocConsumer<TasbihCubit, TasbihStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = TasbihCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.tasbehModel != null,
              builder: (context) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      cubit.index = index;
                      navigator(context, Routes.selectedTasbehScreenRoute);
                    },
                    child: FadeInRight(
                      child: ListItemCustom(
                        index: index,
                        screen: Routes.tasbehRoute,
                        // SelectedTasbehScreen(
                        //   i: index,
                        // ),
                        text: '${cubit.tasbehModel!.tasbeh![index].content}',
                        image: 'tasbih',
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCustom(
                              text:
                                  '${cubit.tasbehModel!.tasbeh![index].count}',
                              color: ColorManager.black,
                              fontWeight: FontWeight.bold,
                            ),
                            TextCustom(
                                text: 'مرة',
                                color: ColorManager.black,
                                fontSize: 12.sp),
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: cubit.tasbehModel!.tasbeh!.length,
                );
              },
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
