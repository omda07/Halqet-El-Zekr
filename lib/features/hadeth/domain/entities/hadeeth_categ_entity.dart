import 'package:equatable/equatable.dart';

class HadeethCategoriesEntity extends Equatable {
  final List<HadeethCategoryEntity> hadeethCategoryEntity;

  const HadeethCategoriesEntity({
    required this.hadeethCategoryEntity,
  });

  @override
  List<Object> get props => [hadeethCategoryEntity];
}

class HadeethCategoryEntity extends Equatable {
  final String id;
  final String title;
  final String hadeethsCount;

  const HadeethCategoryEntity(
      {required this.id, required this.title, required this.hadeethsCount});

  @override
  List<Object> get props => [id, title, hadeethsCount];
}
