import 'package:hesn_elmuslim/features/hadeth/domain/entities/hadeeth_details_entity.dart';

class HadeethDetailsModel extends HadeethDetailsEntity {
  HadeethDetailsModel({
    List<DataEntity>? data,
    MetaEntity? meta,
  }) : super(
          data: data!,
          meta: meta!,
        );

  factory HadeethDetailsModel.fromJson(Map<String, dynamic> json) =>
      HadeethDetailsModel(
        data: List.from(json['data'].map((e) => DataModel.fromJson(e))),
        meta: MetaModel.fromJson(json['meta']),
      );
}

class DataModel extends DataEntity {
  const DataModel({
    String? id,
    String? title,
  }) : super(
          title: title ?? '',
          id: id ?? '',
        );

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json['id'],
        title: json['title'],
      );
}

class MetaModel extends MetaEntity {
  const MetaModel({
    String? currentPage,
    int? lastPage,
    int? totalItems,
    String? perPage,
  }) : super(
          currentPage: currentPage ?? '',
          lastPage: lastPage ?? 0,
          perPage: perPage ?? '',
          totalItems: totalItems ?? 0,
        );

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        totalItems: json['total_items'],
        perPage: json['per_page'],
        lastPage: json['last_page'],
        currentPage: json['current_page'],
      );
}
