abstract class HadethStates {}

class InitialHadethState extends HadethStates {}

class GetHadethLoading extends HadethStates {}

class GetHadethSuccess extends HadethStates {
// final HadeethCategoriesEntity hadeethCategoriesEntity;

  GetHadethSuccess();
}

class GetHadethError extends HadethStates {
  final String error;

  GetHadethError({required this.error});
}
