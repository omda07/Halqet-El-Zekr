import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/yasser_surah_entity.dart';
import '../repositories/yasser_surah_repository.dart';

class QuranAudiosUsecase
    implements UseCase<QuranAudiosEntity, YasserQuranParams> {
  final QuranAudiosRepository quranAudiosRepository;

  QuranAudiosUsecase(this.quranAudiosRepository);

  @override
  Future<Either<Failure, QuranAudiosEntity>> call(YasserQuranParams params) =>
      quranAudiosRepository.yasserQuran(params);
}
