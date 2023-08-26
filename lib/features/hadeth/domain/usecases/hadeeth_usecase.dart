import 'package:dartz/dartz.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_categ_entity.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/repositories/hadeeth_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/hadeeth_details_entity.dart';
import '../entities/hadeeth_info_entity.dart';

class HadeethCategoriesUsecase
    implements UseCase<HadeethCategoriesEntity, NoParams> {
  final HadeethRepository hadeethRepository;

  HadeethCategoriesUsecase(this.hadeethRepository);

  @override
  Future<Either<Failure, HadeethCategoriesEntity>> call(NoParams params) =>
      hadeethRepository.hadeethCategories(params);
}

class HadeethDetailsUsecase
    implements UseCase<HadeethDetailsEntity, HadeethDetailsParams> {
  final HadeethRepository hadeethRepository;

  HadeethDetailsUsecase(this.hadeethRepository);

  @override
  Future<Either<Failure, HadeethDetailsEntity>> call(
          HadeethDetailsParams params) =>
      hadeethRepository.hadeethDetails(params);
}

class HadeethInfoUsecase
    implements UseCase<HadeethInfoEntity, HadeethInfoParams> {
  final HadeethRepository hadeethRepository;

  HadeethInfoUsecase(this.hadeethRepository);

  @override
  Future<Either<Failure, HadeethInfoEntity>> call(HadeethInfoParams params) =>
      hadeethRepository.hadeethInfo(params);
}
