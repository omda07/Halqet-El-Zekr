abstract class PeopleSates {}

class InitialState extends PeopleSates {}

class AppChangeBottomSheetState extends PeopleSates {}

class GetPeopleLoadingState extends PeopleSates {}

class GetPeopleSuccessState extends PeopleSates {}

class GetPeopleErrorState extends PeopleSates {
  final String error;

  GetPeopleErrorState(this.error);
}

class InsertPeopleLoadingState extends PeopleSates {}

class InsertPeopleSuccessState extends PeopleSates {}

class InsertPeopleErrorState extends PeopleSates {
  final String error;

  InsertPeopleErrorState(this.error);
}

class DeletePeopleLoadingState extends PeopleSates {}

class DeletePeopleSuccessState extends PeopleSates {}

class DeletePeopleErrorState extends PeopleSates {
  final String error;

  DeletePeopleErrorState(this.error);
}
