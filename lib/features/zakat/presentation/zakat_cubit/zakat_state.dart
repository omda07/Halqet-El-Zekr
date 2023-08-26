abstract class ZakatStates {}

class InitialHomeState extends ZakatStates {}

class BottomNavBar extends ZakatStates {}

class GetAzkarLoading extends ZakatStates {}

class GetAzkarSuccess extends ZakatStates {}

class GetAzkarError extends ZakatStates {
  final String error;

  GetAzkarError(this.error);
}

class GetAzkarEveningLoading extends ZakatStates {}

class GetAzkarEveningSuccess extends ZakatStates {}

class GetAzkarEveningError extends ZakatStates {
  final String error;

  GetAzkarEveningError(this.error);
}

class GetTasbehLoading extends ZakatStates {}

class GetTasbehSuccess extends ZakatStates {}

class GetTasbehError extends ZakatStates {
  final String error;

  GetTasbehError(this.error);
}

class GetPercent extends ZakatStates {}

class Refresh extends ZakatStates {}

class ShareSuccess extends ZakatStates {}

class Calculation extends ZakatStates {}

class GetLocation extends ZakatStates {}

class GetPrayer extends ZakatStates {}
