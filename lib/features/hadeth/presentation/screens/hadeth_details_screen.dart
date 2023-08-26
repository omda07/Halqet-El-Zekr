import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/utils/routes_manager.dart';
import 'package:hesn_elmuslim/core/widgets/component.dart';
import 'package:hesn_elmuslim/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:hesn_elmuslim/core/widgets/surah_custom.dart';
import 'package:hesn_elmuslim/features/hadeth/presentation/hadeth_info_cubit/hadeth_info_cubit.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

import '../hadeth_details_cubit/hadeth_details_cubit.dart';
import '../hadeth_details_cubit/hadeth_details_state.dart';

class HadethDetailsScreen extends StatelessWidget {
  const HadethDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HadethDetailsCubit>(context)..getHadethDetails(),
      child: BlocConsumer<HadethDetailsCubit, HadethDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HadethDetailsCubit.get(context);

          return ScaffoldCustom(
            appBarCustom: AppBarCustom(
              text: cubit.categoryName,
            ),
            body: state is GetHadethDetailsSuccess
                ? Padding(
                    padding: EdgeInsets.all(20.0.sp),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.hadeethDetailsEntity.data.length,
// itemExtent: 100.0,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: FadeIn(
                          child: Column(
                            textDirection: TextDirection.rtl,
                            children: [
                              SurahCustom(
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: ListTile(
                                        title: TextCustom(
                                          textAlign: TextAlign.center,
                                          text: state.hadeethDetailsEntity
                                              .data[index].title,
                                          fontSize: 24.sp,
                                        ),
                                        subtitle: TextButton(
                                          onPressed: () {
                                            BlocProvider.of<HadethInfoCubit>(
                                                        context)
                                                    .id =
                                                state.hadeethDetailsEntity
                                                    .data[index].id;
                                            BlocProvider.of<HadethInfoCubit>(
                                                        context)
                                                    .hadeethName =
                                                state.hadeethDetailsEntity
                                                    .data[index].title;
                                            navigator(context,
                                                Routes.hadethInfoRoute);
                                          },
                                          child: TextCustom(
                                            decoration:
                                                TextDecoration.underline,
                                            textAlign: TextAlign.center,
                                            color: ColorManager.grey2,
                                            text: 'أقرأ المزيد',
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20.h,
                                thickness: 2,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : state is GetHadethDetailsLoading
                    ? ShimmerCustom(
                        child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 4,
// itemExtent: 100.0,
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0.h),
                          child: Column(
                            textDirection: TextDirection.rtl,
                            children: [
                              SurahCustom(
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: ListTile(
                                        title: const TextCustom(
                                          textAlign: TextAlign.center,
                                          text: '',
                                        ),
                                        subtitle: TextCustom(
                                          decoration: TextDecoration.underline,
                                          textAlign: TextAlign.center,
                                          color: ColorManager.grey2,
                                          text: 'أقرأ المزيد',
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20.h,
                                thickness: 2,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                        ),
                      ))
                    : ErrorWidgetCustom(onPress: () {
                        cubit.getHadethDetails();
                      }),
            floatingActionButton: state is GetHadethDetailsSuccess
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        key: const Key('next'),
                        heroTag: 'next',
                        onPressed: int.parse(state
                                    .hadeethDetailsEntity.meta.currentPage) <
                                state.hadeethDetailsEntity.meta.lastPage
                            ? () {
                                cubit.page = (int.parse(state
                                            .hadeethDetailsEntity
                                            .meta
                                            .currentPage) +
                                        1)
                                    .toString();
                                cubit.getHadethDetails();
                              }
                            : null,
                        child: const TextCustom(
                          text: 'التالي',
                          color: ColorManager.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        decoration: BoxDecoration(
                          color: ColorManager.cardColor,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: ColorManager.primary),
                        ),
                        child: TextCustom(
                            text:
                                '${state.hadeethDetailsEntity.meta.currentPage} / ${state.hadeethDetailsEntity.meta.lastPage}',
                            fontSize: 20.sp),
                      ),
                      FloatingActionButton(
                        key: const Key('forward'),
                        heroTag: 'forward',
                        onPressed: int.parse(state
                                    .hadeethDetailsEntity.meta.currentPage) >
                                1
                            ? () {
                                cubit.page = (int.parse(state
                                            .hadeethDetailsEntity
                                            .meta
                                            .currentPage) -
                                        1)
                                    .toString();
                                cubit.getHadethDetails();
                              }
                            : null,
                        child: const TextCustom(
                          text: 'السابق',
                          color: ColorManager.white,
                        ),
                      )
                    ],
                  )
                : null,
          );
        },
      ),
    );
  }
}
