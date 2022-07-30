import 'package:hesn_elmuslim/model/quran/quran_surah_model.dart';

abstract class QuranStates{}

class InitialQuranState extends QuranStates{}


class GetQuranLoading extends QuranStates{}
class GetQuranSuccess extends QuranStates{

}
class GetQuranError extends QuranStates{
  final String error;

  GetQuranError(this.error);
}


class GetQuranSurahLoading extends QuranStates{}
class GetQuranSurahSuccess extends QuranStates{
  final QuranSurahModel quranSurah;

  GetQuranSurahSuccess(this.quranSurah);
}
class GetQuranSurahError extends QuranStates{
  final String error;

  GetQuranSurahError(this.error);
}
