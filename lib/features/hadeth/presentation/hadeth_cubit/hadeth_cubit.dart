import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/core/api/end_points.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/usecases/hadeeth_usecase.dart';
import '../../../network/dio_helper.dart';
import 'hadeth_state.dart';

class HadethCubit extends Cubit<HadethStates> {
  final HadeethCategoriesUsecase hadeethCategoriesUsecase;

  HadethCubit({
    required this.hadeethCategoriesUsecase,
  }) : super(InitialHadethState());

  static HadethCubit get(context) => BlocProvider.of(context);

  // HadethDetailsModel? hadethDetailsModel;
  List<Map<String, dynamic>> list = [];

  getHadeth() async {
    emit(GetHadethLoading());

    // Either<Failure, HadeethCategoriesEntity> response =
    //     await hadeethCategoriesUsecase(NoParams());
    // response.fold((failure) => emit(GetHadethError(error: failure.message)),
    //         (hadeethCategoriesEntity) => emit(GetHadethSuccess(hadeethCategoriesEntity: hadeethCategoriesEntity)));

    DioHelper.getData(url: EndPoints.getHadeethCategories).then((value) {
      // quranSurah = QuranSurah.fromJson(value.data);
      // debugPrint(value.data);
      value.data.forEach((v) {
        list.add(v);
      });
      // list?.add(value.data);
      emit(GetHadethSuccess());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(GetHadethError(error: onError.toString()));
    });
  }
}
