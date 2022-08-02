import 'package:hesn_elmuslim/model/people/people_model.dart';

abstract class PeopleSates{}

class InitialState extends PeopleSates{}
class AppChangeBottomSheetState extends PeopleSates{}


class GetPeopleLoadingState extends PeopleSates{}
class GetPeopleSuccessState extends PeopleSates{
 final PeopleModel peopleModel;

  GetPeopleSuccessState(this.peopleModel);
}
class GetPeopleErrorState extends PeopleSates{
  final String error;

  GetPeopleErrorState(this.error);
}


class InsertPeopleLoadingState extends PeopleSates{}
class InsertPeopleSuccessState extends PeopleSates{

}
class InsertPeopleErrorState extends PeopleSates{
  final String error;

  InsertPeopleErrorState(this.error);
}
