
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_cubit.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_state.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:pdfx/pdfx.dart';
import '../../widgets/text_custom/text_custom.dart';
import '../../widgets/text_form_field/text_form_field_custom.dart';

class QuranScreen extends StatelessWidget {
  QuranScreen({Key? key}) : super(key: key);


  TextEditingController num = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pdfPinchController = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/pdf/quran.pdf'),
    );
    return Scaffold(
      appBar: appBarCustom(
          context: context,
          leading: 'المصحف الكريم',
          onPressed: () {

            Navigator.pop(context);
          },
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Animate to specified page
                pdfPinchController.animateToPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.ease,
                  pageNumber: int.parse(num.text),
                );
              },
              child: textCustom(text: 'تم', context: context, fontSize: 22.sp),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 50,
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
          ]),
      body: BlocConsumer<QuranCubit, QuranStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: PdfViewPinch(
                  controller: pdfPinchController,
                ),
              ),
              Row(
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
                    builder: (_, state, loadingState, pagesCount) => Container(
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
            ],
          );
        },
      ),
    );
  }
}
