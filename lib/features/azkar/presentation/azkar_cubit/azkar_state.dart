abstract class AzkarStates {}

class InitialHomeState extends AzkarStates {}

class BottomNavBar extends AzkarStates {}

class GetAzkarLoading extends AzkarStates {}

class GetAzkarSuccess extends AzkarStates {}

class GetAzkarError extends AzkarStates {
  final String error;

  GetAzkarError(this.error);
}

class GetAzkarEveningLoading extends AzkarStates {}

class GetAzkarEveningSuccess extends AzkarStates {}

class GetAzkarEveningError extends AzkarStates {
  final String error;

  GetAzkarEveningError(this.error);
}

class GetTasbehLoading extends AzkarStates {}

class GetTasbehSuccess extends AzkarStates {}

class GetTasbehError extends AzkarStates {
  final String error;

  GetTasbehError(this.error);
}

class GetPercentLoading extends AzkarStates {}

class GetPercent extends AzkarStates {}

class Refresh extends AzkarStates {}

class ShareSuccess extends AzkarStates {}

class Calculation extends AzkarStates {}

class GetLocation extends AzkarStates {}

class GetPrayer extends AzkarStates {}
