import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/cubit/tasbih/tasbih_state.dart';
import 'package:hesn_elmuslim/model/tasbeh/tasbeh_model.dart';

class TasbihCubit extends Cubit<TasbihStates> {
  TasbihCubit() : super(InitialTasbihState());

  static TasbihCubit get(context) => BlocProvider.of(context);



  TasbehModel? tasbehModel;

  getTasbeh({required BuildContext context}) async {
    try {
      emit(GetTasbehLoading());
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json/tasbeh.json');
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response);
      // now we have a json...

      tasbehModel = TasbehModel.fromJson(mJson);

      print(tasbehModel!.tasbeh);
      emit(GetTasbehSuccess());
    } catch (e) {
      print(e);
      emit(GetTasbehError(e.toString()));
    }
  }

  int count = 0;
  double percent = 0;

  incrementCounter({required int counter}) {
    late double constNumber = 1 / counter;
    if (count < counter) {
      count++;
      percent = percent + constNumber;
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
