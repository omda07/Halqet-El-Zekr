import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final NetworkInfo networkInfo;
  final SettingsRemoteDataSource settingsRemoteDataSource;

  SettingsRepositoryImpl(
      {required this.networkInfo, required this.settingsRemoteDataSource});

  @override
  Future<Either<Failure, SettingsEntity>> deleteUser(editUserName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEditProfile = await settingsRemoteDataSource.deleteUser();
        if (remoteEditProfile.status == true) {
          return Right(remoteEditProfile);
        } else {
          return Left(Failure(400, remoteEditProfile.message[0]));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
