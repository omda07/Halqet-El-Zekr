
import '../../model/hadeth/hadeth_details_model.dart';
import '../../model/hadeth/hadeth_info_model.dart';

abstract class HadethStates{}

class InitialHadethState extends HadethStates{}


class GetHadethLoading extends HadethStates{}
class GetHadethSuccess extends HadethStates{

}
class GetHadethError extends HadethStates{
  final String error;

  GetHadethError(this.error);
}


class GetHadethDetailsLoading extends HadethStates{}
class GetHadethDetailsSuccess extends HadethStates{
  final HadethDetailsModel hadethDetails;

  GetHadethDetailsSuccess(this.hadethDetails);
}
class GetHadethDetailsError extends HadethStates{
  final String error;

  GetHadethDetailsError(this.error);
}

class GetHadethInfoLoading extends HadethStates{}
class GetHadethInfoSuccess extends HadethStates{
  final HadethInfoModel hadethInfo;

  GetHadethInfoSuccess(this.hadethInfo);
}
class GetHadethInfoError extends HadethStates{
  final String error;

  GetHadethInfoError(this.error);
}
