import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/cubit/home/home_state.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/elevated_button/elevated_button_custom.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';
import 'package:hesn_elmuslim/view/widgets/text_form_field/text_form_field_custom.dart';

import '../../resources/color_manager.dart';

class ZakatScreen extends StatelessWidget {
  ZakatScreen({Key? key}) : super(key: key);

  TextEditingController gold = TextEditingController();
  TextEditingController money = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
          context: context,
          leading: 'حساب الزكاة',
          onPressed: () {
            Navigator.pop(context);
          }),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/money-bag.png',
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormFieldCustom(
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل سعر الذهب عيار 21 اليوم';
                            }
                            return null;
                          },align: TextAlign.end,
                          keyboardType: TextInputType.number,
                          controller: gold,
                          label: 'سعر الذهب عيار 21',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormFieldCustom(
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل المال';
                            }
                            return null;
                          },
                          align: TextAlign.end,
                          keyboardType: TextInputType.number,
                          controller: money,
                          label: 'المال',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ElevatedButtonCustom(
                          text: 'احسب الزكاة',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.calculateZakat(
                                  money: double.parse(money.text),
                              gold:double.parse(gold.text) );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  textCustom(
                    text:cubit.checkZakat ? '${cubit.moneyResult} جنية':'لا يوجد زكاة علي المبلغ المدخر',
                    context: context,
                    fontSize: 28.sp,
                  ),
                  Column(children:List.generate(
                    cubit.title.length,
                        ( index) {
                      return hint(
                          context: context,
                          title: cubit.title[index],
                          text: cubit.subTitle[index]);
                    },
                  ) ,)
                  ,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget hint(
      {required BuildContext context,
      required String title,
      required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        textCustom(
            height: 0.0,
            context: context,
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold),
        textCustom(
            height: 0.0,
            context: context,
            text: text,
            color: ColorManager.grey),
      ],
    );
  }
}
