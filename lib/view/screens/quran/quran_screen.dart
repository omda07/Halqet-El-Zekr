import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_cubit.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_state.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:pdfx/pdfx.dart';
import '../../resources/color_manager.dart';
import '../../widgets/text_custom/text_custom.dart';
import '../../widgets/text_form_field/text_form_field_custom.dart';

class QuranScreen extends StatelessWidget {
  QuranScreen({Key? key}) : super(key: key);

  final pdfPinchController = PdfControllerPinch(
    document: PdfDocument.openAsset('assets/pdf/quran.pdf'),
  );
  TextEditingController num = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        context: context,
        leading: 'المصحف الكريم',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<QuranCubit, QuranStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
flex: 1,
                child: Container(
                  // margin: const EdgeInsets.only(top: 0, bottom: 10,left: 10,right: 10),
                  padding: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: ColorManager.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100]!,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Animate to specified page
                          pdfPinchController.animateToPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease,
                            pageNumber: int.parse(num.text),
                          );
                        },
                        child: textCustom(
                            text: 'اذهب', context: context, fontSize: 22.sp),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 8.0.w),
                        child: SizedBox(
                          width: 80.w,
                          child: TextFormFieldCustom(
                            padding: 10,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return 'رقم الصفحة';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: num,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: PdfViewPinch(
                  scrollDirection: Axis.horizontal,
                  backgroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: ColorManager.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100]!,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  controller: pdfPinchController,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin:  EdgeInsets.only(
                      top: 0, bottom: 10.h, left: 10.w, right: 10.w),
                  // padding: EdgeInsets.only(bottom:16.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: ColorManager.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100]!,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Animate to next page
                          pdfPinchController.nextPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeIn);
                        },
                        child: textCustom(
                            text: 'التالي', context: context, fontSize: 22.sp),
                      ),
                      PdfPageNumber(
                        controller: pdfPinchController,
                        // When `loadingState != PdfLoadingState.success`  `pagesCount` equals null_
                        builder: (_, state, loadingState, pagesCount) =>
                            Container(
                          alignment: Alignment.center,
                          child: textCustom(
                              context: context,
                              text: state == PdfLoadingState.success
                                  ? '${pdfPinchController.page.toString()}/${pagesCount ?? 0}'
                                  : '',
                              fontSize: 22.sp),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Animate to previous page
                          pdfPinchController.previousPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOut);
                        },
                        child: textCustom(
                            text: 'السابق', context: context, fontSize: 22.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
