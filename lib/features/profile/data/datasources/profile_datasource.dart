import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> profile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ApiConsumer apiConsumer;
  ProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ProfileModel> profile() async {
    final response = await apiConsumer.get(EndPoints.getProfile);

    return ProfileModel.fromJson(response);
  }
}
