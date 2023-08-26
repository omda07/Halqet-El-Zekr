abstract class TasbihStates {}

class InitialTasbihState extends TasbihStates {}

class GetTasbehLoading extends TasbihStates {}

class GetTasbehSuccess extends TasbihStates {}

class GetTasbehError extends TasbihStates {
  final String error;

  GetTasbehError(this.error);
}

class GetPercent extends TasbihStates {}

class Refresh extends TasbihStates {}

class Calculation extends TasbihStates {}

class AppCreateDatabaseState extends TasbihStates {}

class AppGetDatabaseState extends TasbihStates {}

class AppGetDatabaseLoadingState extends TasbihStates {}

class AppGetDatabaseSuccessState extends TasbihStates {}

class AppInsertDatabaseState extends TasbihStates {}

class AppUpdateDatabaseLoadingState extends TasbihStates {}

class AppUpdateDatabaseState extends TasbihStates {}

class AppUpdateDatabaseErrorState extends TasbihStates {
  final Error error;

  AppUpdateDatabaseErrorState(this.error);
}

class AppDeleteDatabaseState extends TasbihStates {}
