import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_categ_entity.dart';

class HadeethCategoriesModel extends HadeethCategoriesEntity {
  HadeethCategoriesModel({
    List<HadeethCategoryEntity>? hadeethCategory,
  }) : super(hadeethCategoryEntity: hadeethCategory!);

  factory HadeethCategoriesModel.fromJson(Map<String, dynamic> json) =>
      HadeethCategoriesModel(
        hadeethCategory:
            List.from(json[''].map((e) => HadeethCategoryModel.fromJson(e))),
      );
}

class HadeethCategoryModel extends HadeethCategoryEntity {
  const HadeethCategoryModel({
    String? id,
    String? title,
    String? hadeethsCount,
  }) : super(
          id: id ?? '',
          title: title ?? '',
          hadeethsCount: hadeethsCount ?? '',
        );

  factory HadeethCategoryModel.fromJson(Map<String, dynamic> json) =>
      HadeethCategoryModel(
        id: json['id'],
        title: json['title'],
        hadeethsCount: json['hadeeths_count'],
      );
}
