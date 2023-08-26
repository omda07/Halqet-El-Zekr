import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_info_entity.dart';

abstract class HadethInfoStates {}

class InitialHadethInfoState extends HadethInfoStates {}

class GetHadethInfoLoading extends HadethInfoStates {}

class GetHadethInfoSuccess extends HadethInfoStates {
  final HadeethInfoEntity hadeethInfoEntity;

  GetHadethInfoSuccess({required this.hadeethInfoEntity});
}

class GetHadethInfoError extends HadethInfoStates {
  final String error;

  GetHadethInfoError({required this.error});
}
