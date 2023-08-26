abstract class PrayTimeStates {}

class InitialHomeState extends PrayTimeStates {}

class BottomNavBar extends PrayTimeStates {}

class GetAzkarLoading extends PrayTimeStates {}

class GetAzkarSuccess extends PrayTimeStates {}

class GetAzkarError extends PrayTimeStates {
  final String error;

  GetAzkarError(this.error);
}

class GetAzkarEveningLoading extends PrayTimeStates {}

class GetAzkarEveningSuccess extends PrayTimeStates {}

class GetAzkarEveningError extends PrayTimeStates {
  final String error;

  GetAzkarEveningError(this.error);
}

class GetTasbehLoading extends PrayTimeStates {}

class GetTasbehSuccess extends PrayTimeStates {}

class GetTasbehError extends PrayTimeStates {
  final String error;

  GetTasbehError(this.error);
}

class GetPercent extends PrayTimeStates {}

class Refresh extends PrayTimeStates {}

class ShareSuccess extends PrayTimeStates {}

class Calculation extends PrayTimeStates {}

class GetLocation extends PrayTimeStates {}

class GetPrayer extends PrayTimeStates {}
