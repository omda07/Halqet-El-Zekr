import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/cubit/home/home_state.dart';
import 'package:hesn_elmuslim/view/screens/tasbih/selected_tasbih_screen.dart';
import 'package:hesn_elmuslim/view/widgets/list_item.dart';

import '../../resources/color_manager.dart';
import '../../widgets/app_bar/app_bar_custom.dart';
import '../../widgets/text_custom/text_custom.dart';



class TasbehScreen extends StatelessWidget {
  const TasbehScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarCustom(
        context: context,
        leading: 'التسبيح',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getTasbeh(context: context),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.tasbehModel != null,
              builder: (context) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>ListItemCustom(screen: SelectedTasbehScreen(
                    i: index,
                  ), text: '${cubit.tasbehModel!.tasbeh![index].content}', image: 'tasbih',leading:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textCustom(context:context,text:
                      '${cubit.tasbehModel!.tasbeh![index].count}',
                        color: ColorManager.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textCustom(context:context,text:
                      'مرة',
                          color: ColorManager.black,
                          fontSize: 12.sp
                      ),
                    ],
                  ), ),
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
