import 'package:dartz/dartz.dart';
import 'package:hesn_elmuslim/core/usecases/usecase.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_categ_entity.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_details_entity.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_info_entity.dart';
import '../../../../core/error/failure.dart';

abstract class HadeethRepository {
  Future<Either<Failure, HadeethCategoriesEntity>> hadeethCategories(
      NoParams params);
  Future<Either<Failure, HadeethDetailsEntity>> hadeethDetails(
      HadeethDetailsParams params);
  Future<Either<Failure, HadeethInfoEntity>> hadeethInfo(
      HadeethInfoParams params);
}
