import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';
import 'azkar_state.dart';
import 'package:hesn_elmuslim/features/azkar/data/models/azkar_evening_model.dart';
import 'package:hesn_elmuslim/features/azkar/data/models/azkar_morning_model.dart';
import 'package:share_plus/share_plus.dart';

class AzkarCubit extends Cubit<AzkarStates> {
  AzkarCubit() : super(InitialHomeState());

  static AzkarCubit get(context) => BlocProvider.of(context);

  int count = 0;
  double percent = 0;

  incrementCounter(
      {required int counter, required int index, required double percent}) {
    count = azkarMoriningModel!.morning![index].counter!;
    percent = azkarMoriningModel!.morning![index].percent!;

    emit(GetPercentLoading());
    if (count < counter && percent < 1.0) {
      count++;
      azkarMoriningModel!.morning![index].percent =
          (azkarMoriningModel!.morning![index].percent!) + (1 / counter);
      Vibration.vibrate(duration: 100);

      azkarMoriningModel!.morning![index].counter = count;
      emit(GetPercent());
      //percent=percent2;
    } else {
      return null;
    }
  }

  incrementEveningCounter(
      {required int counter, required int index, required double percent}) {
    count = azkarEveningModel!.evening![index].counter!;
    percent = azkarEveningModel!.evening![index].percent!;

    emit(GetPercentLoading());
    if (count < counter && percent < 1.0) {
      count++;
      azkarEveningModel!.evening![index].percent =
          (azkarEveningModel!.evening![index].percent!) + (1 / counter);
      Vibration.vibrate(duration: 100);
      azkarEveningModel!.evening![index].counter = count;
      emit(GetPercent());
      //percent=percent2;
    } else {
      return null;
    }
  }

  Future<void> share(String text, String title, String link) async {
    await Share.share(
      text,
      subject: title,
    );

    // await FlutterShare.share(
    //     title: 'title',
    //     text: text,
    //     linkUrl: link,
    //     chooserTitle: 'Example Chooser Title');
    emit(ShareSuccess());
  }

  AzkarMoriningModel? azkarMoriningModel;

  getAzkarMorning({required BuildContext context}) async {
    try {
      emit(GetAzkarLoading());
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json/azkar_elsabah.json');
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response);
      // now we have a json...

      azkarMoriningModel = AzkarMoriningModel.fromJson(mJson);

      // allAzkar
      //     .where(
      //       (element) =>
      //       element.containsValue(category),
      // )
      //     .forEach((element) {
      //
      //   azkarList.add(
      //     AzkarModel.fromJson(element),
      //   );
      //
      // });
      debugPrint(azkarMoriningModel!.morning.toString());
      emit(GetAzkarSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(GetAzkarError(e.toString()));
    }
  }

  AzkarEveningModel? azkarEveningModel;

  getAzkarEvening({required BuildContext context}) async {
    try {
      emit(GetAzkarEveningLoading());
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json/azkar_elmasaa.json');
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response);
      // now we have a json...

      azkarEveningModel = AzkarEveningModel.fromJson(mJson);

      emit(GetAzkarEveningSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(GetAzkarEveningError(e.toString()));
    }
  }
}
