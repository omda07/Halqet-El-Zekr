import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/settings_model.dart';

abstract class SettingsRemoteDataSource {
  Future<SettingsModel> deleteUser();
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  ApiConsumer apiConsumer;
  SettingsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<SettingsModel> deleteUser() async {
    final response = await apiConsumer.delete(
      EndPoints.deleteUser,
    );

    return SettingsModel.fromJson(response);
  }
}
