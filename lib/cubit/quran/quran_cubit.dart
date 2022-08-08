import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/cubit/database/network/dio_helper.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_state.dart';
import 'package:hesn_elmuslim/model/quran/quran_surah_model.dart';

class QuranCubit extends Cubit<QuranStates> {
  QuranCubit() : super(InitialQuranState());

  static QuranCubit get(context) => BlocProvider.of(context);

  QuranSurahModel? quranSurah;
  List<Map<String, dynamic>> list = [];

  getQuran() {
    emit(GetQuranLoading());
    DioHelper.getData(url: 'cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/index.json').then((value) {
      // quranSurah = QuranSurah.fromJson(value.data);
      // print(value.data);
      value.data.forEach((v) {
        list.add(v);
      });
      // list?.add(value.data);
      emit(GetQuranSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetQuranError(onError.toString()));
    });
  }

  getQuranSurah({required String id}) {
    emit(GetQuranSurahLoading());
    DioHelper.getData(url: 'cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/$id.json').then((value) {
      quranSurah = QuranSurahModel.fromJson(value.data);

      emit(GetQuranSurahSuccess(quranSurah!));
    }).catchError((onError) {
      print(onError.toString());
      emit(GetQuranSurahError(onError.toString()));
    });
  }

}
