import '../../domain/entities/settings_entity.dart';

abstract class SettingsStates {}

class InitSettingsState extends SettingsStates {}

class DeleteUserLoadingState extends SettingsStates {}

class DeleteUserSuccessState extends SettingsStates {
  final SettingsEntity settingsEntity;

  DeleteUserSuccessState({required this.settingsEntity});
}

class DeleteUserErrorState extends SettingsStates {
  final String message;

  DeleteUserErrorState({required this.message});
}
