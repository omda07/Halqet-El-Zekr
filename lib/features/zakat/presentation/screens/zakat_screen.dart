import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../zakat_cubit/zakat_cubit.dart';
import '../zakat_cubit/zakat_state.dart';

class ZakatScreen extends StatelessWidget {
  ZakatScreen({Key? key}) : super(key: key);

  final TextEditingController gold = TextEditingController();
  final TextEditingController money = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'حساب زكاة المال',
      ),
      body: BlocConsumer<ZakatCubit, ZakatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ZakatCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/money-bag.png',
                    width: 90.w,
                    height: 90.h,
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
                          },
                          align: TextAlign.end,
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
                                  gold: double.parse(gold.text));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  TextCustom(
                    text: cubit.checkZakat
                        ? '${cubit.moneyResult} جنية'
                        : 'لا يوجد زكاة علي المبلغ المدخر',
                    fontSize: 28.sp,
                  ),
                  Column(
                    children: List.generate(
                      cubit.title.length,
                      (index) {
                        return hint(
                            title: cubit.title[index],
                            text: cubit.subTitle[index],
                            context: context);
                      },
                    ),
                  ),
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
        TextCustom(
            // height: 0.0,
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold),
        TextCustom(
          // height: 0.0,
          text: text,
          color: ColorManager.grey,
        ),
      ],
    );
  }
}
