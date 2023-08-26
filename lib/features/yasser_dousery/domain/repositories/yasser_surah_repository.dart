import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/yasser_surah_entity.dart';

abstract class QuranAudiosRepository {
  Future<Either<Failure, QuranAudiosEntity>> yasserQuran(
      YasserQuranParams params);
}
