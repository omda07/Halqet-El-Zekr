import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/strings_manager.dart';
import '../models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel> getLastProfile();

  Future<void> cacheProfile(ProfileModel profileModel);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProfileLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProfile(ProfileModel profileModel) async {
    await CacheHelper.put(
        key: AppStrings.cachedProfile, value: jsonEncode(profileModel));
  }

  @override
  Future<ProfileModel> getLastProfile() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedLogin);
    if (jsonString != null) {
      final cacheLogin =
          Future.value(ProfileModel.fromJson(json.decode(jsonString)));
      return cacheLogin;
    } else {
      throw CacheException();
    }
  }
}
