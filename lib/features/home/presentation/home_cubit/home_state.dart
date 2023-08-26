abstract class HomeStates {}

class InitialHomeState extends HomeStates {}

class BottomNavBar extends HomeStates {}

class GetAzkarLoading extends HomeStates {}

class GetAzkarSuccess extends HomeStates {}

class GetAzkarError extends HomeStates {
  final String error;

  GetAzkarError(this.error);
}

class GetAzkarEveningLoading extends HomeStates {}

class GetAzkarEveningSuccess extends HomeStates {}

class GetAzkarEveningError extends HomeStates {
  final String error;

  GetAzkarEveningError(this.error);
}

class GetTasbehLoading extends HomeStates {}

class GetTasbehSuccess extends HomeStates {}

class GetTasbehError extends HomeStates {
  final String error;

  GetTasbehError(this.error);
}

class GetPercent extends HomeStates {}

class Refresh extends HomeStates {}

class ShareSuccess extends HomeStates {}

class Calculation extends HomeStates {}

class GetLocationLoading extends HomeStates {}

class GetLocation extends HomeStates {}

class GetPrayer extends HomeStates {}
