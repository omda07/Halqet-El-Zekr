import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/cubit/database/network/dio_helper.dart';
import 'package:hesn_elmuslim/model/hadeth/hadeth_info_model.dart';

import '../../model/hadeth/hadeth_details_model.dart';
import 'hadeth_state.dart';

class HadethCubit extends Cubit<HadethStates> {
  HadethCubit() : super(InitialHadethState());

  static HadethCubit get(context) => BlocProvider.of(context);

  HadethDetailsModel? hadethDetailsModel;
  List<Map<String, dynamic>> list = [];

  getHadeth() {
    emit(GetHadethLoading());
    DioHelper.getData(url: 'hadeethenc.com/api/v1/categories/list/?language=ar').then((value) {
      // quranSurah = QuranSurah.fromJson(value.data);
      // print(value.data);
      value.data.forEach((v) {
        list.add(v);
      });
      // list?.add(value.data);
      print(list);
      emit(GetHadethSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetHadethError(onError.toString()));
    });
  }

  getHadethDetails({required int id,required int page}) {
    emit(GetHadethDetailsLoading());
    DioHelper.getData(url: 'hadeethenc.com/api/v1/hadeeths/list/?language=ar&category_id=$id&page=$page&per_page=10').then((value) {
      hadethDetailsModel = HadethDetailsModel.fromJson(value.data);
      // print(hadethDetailsModel!.data![0].title);

      emit(GetHadethDetailsSuccess(hadethDetailsModel!));
    }).catchError((onError) {
      print(onError--);
      emit(GetHadethDetailsError(onError.toString()));
    });
  }

  HadethInfoModel? hadethInfoModel;
  getHadethInfo({required String id}) {
    emit(GetHadethInfoLoading());
    DioHelper.getData(url: 'hadeethenc.com/api/v1/hadeeths/one/?language=ar&id=$id').then((value) {
      hadethInfoModel = HadethInfoModel.fromJson(value.data);
      print(hadethInfoModel!.title);

      emit(GetHadethInfoSuccess(hadethInfoModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(GetHadethInfoError(onError.toString()));
    });
  }
}
