import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/network/network_info.dart';

import '../../../../core/utils/strings_manager.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_datasource.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileRepositoryImpl(
      {required this.profileLocalDataSource,
      required this.networkInfo,
      required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, ProfileModel>> profile(checklistsParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await profileRemoteDataSource.profile();
        if (remoteProfile.status == true) {
          await CacheHelper.put(
              key: AppStrings.noId,
              value: remoteProfile.profileDataEntity.noId);
          return Right(remoteProfile);
        } else {
          return Left(Failure(400, remoteProfile.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
