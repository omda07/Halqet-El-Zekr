import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/people/people_cubit.dart';
import 'package:hesn_elmuslim/cubit/people/people_states.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/elevated_button/elevated_button_custom.dart';
import 'package:hesn_elmuslim/view/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';

import '../../resources/color_manager.dart';
import '../../widgets/component.dart';
import '../../widgets/surah_custom.dart';
import '../../widgets/text_form_field/text_form_field_custom.dart';

class PeopleScreen extends StatelessWidget {
  PeopleScreen({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PeopleCubit>(context)
        ..getNames()
        ..getUniqueDeviceId(),
      child: BlocConsumer<PeopleCubit, PeopleSates>(
        listener: (context, state) {
          if (state is InsertPeopleSuccessState) {
            BlocProvider.of<PeopleCubit>(context).getNames();
          }
        },
        builder: (context, state) {
          var cubit = PeopleCubit.get(context);

          return scaffoldCustom(
              key: scaffoldKey,
              appBarCustom: appBarCustom(
                context: context,
                isNull: false,
                leading: 'أسماء المتوفيين',
              ),
              body: ConditionalBuilder(
                condition: cubit.peopleModel != null ,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SurahCustom(
                            text:
                                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ (1)الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2) الرَّحْمَنِ الرَّحِيمِ (3) مَالِكِ يَوْمِ الدِّينِ (4) إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (5) اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ (6) صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ (7)',
                          ),
                          Column(
                            children: List.generate(
                              cubit.peopleModel!.data == null
                                  ? 0
                                  : cubit.peopleModel!.data!.length,
                              (index) => Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(4),
                                padding: EdgeInsets.all(14.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorManager.cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[100]!,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textCustom(
                                        height: 0.0,
                                        textAlign: TextAlign.center,
                                        text: cubit.peopleModel!.data![index]
                                                .name ??
                                            '',
                                        fontSize: 24.sp,
                                        context: context),
                                    ConditionalBuilder(
                                      condition:
                                          cubit.peopleModel!.data![index].uid ==
                                              cubit.uniqueDeviceId,
                                      builder: (context) {
                                        return IconButton(
                                          onPressed: () async {
                                            await cubit.deleteName(
                                                id: cubit.peopleModel!
                                                    .data![index].id);

                                          },
                                          icon:  Icon(Icons
                                              .remove_circle_outline_outlined,color: ColorManager.frameColor,size: 30.sp,),
                                        );
                                      },
                                      fallback: (context) => const SizedBox(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) {
                            return Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(
                                20.0,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormFieldCustom(
                                        controller: name,
                                        label: 'اسم المتوفي',
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'برجاء ادخال اسم المتوفي';
                                          }
                                          return null;
                                        }),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    ElevatedButtonCustom(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.insertName(
                                                name: name.text,
                                                uid: cubit.uniqueDeviceId);
                                         showToast( message: 'جاري مراجعة الاسم.....',);
                                            Navigator.pop(context);
                                            formKey.currentState!.reset();
                                            cubit.changeBottomSheetState(
                                                isShow: false);


                                          }
                                        },
                                        text: 'سجل الان')
                                  ],
                                ),
                              ),
                            );
                          },
                          elevation: 20.0,
                        )
                        .closed
                        .then((value) {
                          cubit.changeBottomSheetState(isShow: false);

                          //cubit.isBottomSheetShown=false;
                          // icon: Icons.edit,
                        });
                    cubit.changeBottomSheetState(isShow: true);
                    //  cubit.isBottomSheetShown=true;
                    //  icon: Icons.add,
                  }
                },
                child: textCustom(
                    text: 'اسم جديد',
                    context: context,
                    color: ColorManager.black),
              ));
        },
      ),
    );
  }
}
