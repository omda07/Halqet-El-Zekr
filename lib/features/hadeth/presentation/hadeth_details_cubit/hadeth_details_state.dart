import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_details_entity.dart';

abstract class HadethDetailsStates {}

class InitialHadethDetailsState extends HadethDetailsStates {}

class GetHadethDetailsLoading extends HadethDetailsStates {}

class GetHadethDetailsSuccess extends HadethDetailsStates {
  final HadeethDetailsEntity hadeethDetailsEntity;

  GetHadethDetailsSuccess({required this.hadeethDetailsEntity});
}

class GetHadethDetailsError extends HadethDetailsStates {
  final String error;

  GetHadethDetailsError({required this.error});
}
