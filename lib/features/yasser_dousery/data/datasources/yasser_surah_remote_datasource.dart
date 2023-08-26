import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/yasser_surah_model.dart';

abstract class QuranAudioRemoteDataSource {
  Future<QuranAudioModel> yasserQuran({required int reciterNum});
}

class QuranAudioRemoteDataSourceImpl implements QuranAudioRemoteDataSource {
  ApiConsumer apiConsumer;

  QuranAudioRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<QuranAudioModel> yasserQuran({required int reciterNum}) async {
    final response = await apiConsumer.get(EndPoints.quranAudioEndpoint,
        queryParameters: {"reciterNum": reciterNum});

    return QuranAudioModel.fromJson(response);
  }
}
