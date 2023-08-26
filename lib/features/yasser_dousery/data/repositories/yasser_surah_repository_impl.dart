import 'package:dartz/dartz.dart';
import 'package:hesn_elmuslim/core/usecases/usecase.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/yasser_surah_repository.dart';
import '../datasources/yasser_surah_remote_datasource.dart';
import '../models/yasser_surah_model.dart';

class QuranAudioRepositoryImpl implements QuranAudiosRepository {
  final NetworkInfo networkInfo;
  final QuranAudioRemoteDataSource quranAudioRemoteDataSource;

  QuranAudioRepositoryImpl(
      {required this.networkInfo, required this.quranAudioRemoteDataSource});

  @override
  Future<Either<Failure, QuranAudioModel>> yasserQuran(
      YasserQuranParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuranAudio = await quranAudioRemoteDataSource.yasserQuran(
            reciterNum: params.reciterNum);
        if (remoteQuranAudio.status == true) {
          return Right(remoteQuranAudio);
        } else {
          return Left(Failure(400, remoteQuranAudio.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
