import 'package:dartz/dartz.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_categ_entity.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_details_entity.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_info_entity.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/hadeeth_repository.dart';
import '../datasources/hadeeth_remote_datasource.dart';

class HadeethRepositoryImpl implements HadeethRepository {
  final NetworkInfo networkInfo;
  final HadeethRemoteDataSource hadeethRemoteDataSource;

  HadeethRepositoryImpl(
      {required this.networkInfo, required this.hadeethRemoteDataSource});

  @override
  Future<Either<Failure, HadeethCategoriesEntity>> hadeethCategories(
      noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHadeeth = await hadeethRemoteDataSource.hadeethCategories();
        if (remoteHadeeth.hadeethCategoryEntity.isNotEmpty) {
          return Right(remoteHadeeth);
        } else {
          return Left(Failure(400, 'Empty List'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HadeethDetailsEntity>> hadeethDetails(
      categoryId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHadeeth = await hadeethRemoteDataSource.hadeethDetails(
            categoryId: categoryId.categoryId, page: categoryId.page);
        if (remoteHadeeth.data.isNotEmpty) {
          return Right(remoteHadeeth);
        } else {
          return Left(Failure(400, 'Empty List'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HadeethInfoEntity>> hadeethInfo(id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHadeeth = await hadeethRemoteDataSource.hadeethInfo(
          hadeethId: id.hadeethId,
        );
        if (remoteHadeeth.id.isNotEmpty) {
          return Right(remoteHadeeth);
        } else {
          return Left(Failure(400, 'No Hadeeth'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
