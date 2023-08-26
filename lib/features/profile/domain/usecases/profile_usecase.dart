import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class ProfileUsecase implements UseCase<ProfileEntity, NoParams> {
  final ProfileRepository profileRepository;

  ProfileUsecase(this.profileRepository);

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams noParams) =>
      profileRepository.profile(noParams);
}
