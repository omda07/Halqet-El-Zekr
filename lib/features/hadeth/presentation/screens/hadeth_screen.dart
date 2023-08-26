import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/utils/routes_manager.dart';
import 'package:hesn_elmuslim/core/widgets/component.dart';
import 'package:hesn_elmuslim/features/hadeth/presentation/hadeth_details_cubit/hadeth_details_cubit.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/list_shimmer.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../hadeth_cubit/hadeth_cubit.dart';
import '../hadeth_cubit/hadeth_state.dart';
import '../widgets/list_item.dart';

class HadethCategoriesScreen extends StatelessWidget {
  const HadethCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'الاحاديث النبوية',
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<HadethCubit>(context)..getHadeth(),
        child: BlocConsumer<HadethCubit, HadethStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HadethCubit.get(context);

            return state is GetHadethSuccess
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.list.length,
                    shrinkWrap: true,
                    itemExtent: 90,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        BlocProvider.of<HadethDetailsCubit>(context)
                            .categoryId = cubit.list[index]['id'];
                        BlocProvider.of<HadethDetailsCubit>(context).page = '1';
                        BlocProvider.of<HadethDetailsCubit>(context)
                            .categoryName = cubit.list[index]['title'];
                        navigator(context, Routes.hadethDetailsRoute);
                      },
                      child: FadeInRight(
                        child: ListItemCustom(
                          index: index,
                          screen: '',
                          text: cubit.list[index]['title'],
                          image: 'muslim',
                          leading: TextCustom(
                            text: "(${cubit.list[index]['hadeeths_count']})",
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                : state is GetHadethLoading
                    ? const ListShimmer()
                    : ErrorWidgetCustom(onPress: () {
                        cubit.getHadeth();
                      });
          },
        ),
      ),
    );
  }
}
