import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

import '../../data/models/tasbeh_model.dart';
import 'tasbih_state.dart';

class TasbihCubit extends Cubit<TasbihStates> {
  TasbihCubit() : super(InitialTasbihState());

  static TasbihCubit get(context) => BlocProvider.of(context);

  TasbehModel? tasbehModel;
  int? index = 0;
  getTasbeh({required BuildContext context}) async {
    try {
      emit(GetTasbehLoading());
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json/tasbeh.json');
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response);
      // now we have a json...

      tasbehModel = TasbehModel.fromJson(mJson);

      emit(GetTasbehSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(GetTasbehError(e.toString()));
    }
  }

  int count = 0;
  double percent = 0;

  incrementCounter(
      {required int counter, required int index, required double percent}) {
    count = tasbehModel!.tasbeh![index].counter!;
    percent = tasbehModel!.tasbeh![index].percent!;

    if (count < counter && percent < 1.0) {
      count++;
      tasbehModel!.tasbeh![index].percent =
          (tasbehModel!.tasbeh![index].percent!) + (1 / counter);
      Vibration.vibrate(
        duration: 50,
      );
      tasbehModel!.tasbeh![index].counter = count;
      emit(GetPercent());
      //percent=percent2;
    } else {
      return null;
    }
  }

  refresh() {
    count = 0;
    percent = 0.0;
    emit(Refresh());
  }
}
