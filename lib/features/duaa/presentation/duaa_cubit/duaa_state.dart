abstract class DuaaStates {}

class InitialHomeState extends DuaaStates {}

class BottomNavBar extends DuaaStates {}

class GetAzkarLoading extends DuaaStates {}

class GetAzkarSuccess extends DuaaStates {}

class GetAzkarError extends DuaaStates {
  final String error;

  GetAzkarError(this.error);
}

class GetAzkarEveningLoading extends DuaaStates {}

class GetAzkarEveningSuccess extends DuaaStates {}

class GetAzkarEveningError extends DuaaStates {
  final String error;

  GetAzkarEveningError(this.error);
}

class GetTasbehLoading extends DuaaStates {}

class GetTasbehSuccess extends DuaaStates {}

class GetTasbehError extends DuaaStates {
  final String error;

  GetTasbehError(this.error);
}

class GetPercent extends DuaaStates {}

class Refresh extends DuaaStates {}

class ShareSuccess extends DuaaStates {}

class Calculation extends DuaaStates {}

class GetLocation extends DuaaStates {}

class GetPrayer extends DuaaStates {}
