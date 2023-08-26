import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class SettingsUsecase implements UseCase<SettingsEntity, NoParams> {
  final SettingsRepository settingsRepository;

  SettingsUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, SettingsEntity>> call(NoParams params) =>
      settingsRepository.deleteUser(params);
}
