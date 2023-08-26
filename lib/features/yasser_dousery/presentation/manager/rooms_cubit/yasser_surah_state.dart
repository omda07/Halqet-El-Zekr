import '../../../domain/entities/yasser_surah_entity.dart';

abstract class QuranAudioStates {}

class InitialRoomsState extends QuranAudioStates {}

class GetQuranAudioLoading extends QuranAudioStates {}

class GetQuranAudioSuccess extends QuranAudioStates {
  final QuranAudiosEntity quranAudioEntity;

  GetQuranAudioSuccess({required this.quranAudioEntity});
}

class GetQuranAudioError extends QuranAudioStates {
  final String message;

  GetQuranAudioError({required this.message});
}
