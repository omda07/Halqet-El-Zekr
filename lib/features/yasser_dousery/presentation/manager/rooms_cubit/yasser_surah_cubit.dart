import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/features/yasser_dousery/domain/usecases/yasser_surah_usecase.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../quran/data/models/surah_names.dart';
import '../../../domain/entities/yasser_surah_entity.dart';
import 'yasser_surah_state.dart';

class QuranAudioCubit extends Cubit<QuranAudioStates> {
  final QuranAudiosUsecase quranAudiosUsecase;

  QuranAudioCubit({required this.quranAudiosUsecase})
      : super(InitialRoomsState());

  static QuranAudioCubit get(context) => BlocProvider.of(context);

  Future<void> getQuranAudios() async {
    SurahNames.audio.clear();

    emit(GetQuranAudioLoading());
    Either<Failure, QuranAudiosEntity> response =
        await quranAudiosUsecase(const YasserQuranParams(reciterNum: 1));

    response
        .fold((failure) => emit(GetQuranAudioError(message: failure.message)),
            (quranAudioEntity) {
      for (var element in quranAudioEntity.surahEntity) {
        SurahNames.audio.add(element.quranAudioPath);
        SurahNames.audioName.add(element.title);

      }
      return emit(GetQuranAudioSuccess(quranAudioEntity: quranAudioEntity));
    });
  }
}
