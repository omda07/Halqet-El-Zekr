import 'package:equatable/equatable.dart';

class HadeethDetailsEntity extends Equatable {
  final List<DataEntity> data;
  final MetaEntity meta;

  const HadeethDetailsEntity({required this.data, required this.meta});

  @override
  List<Object> get props => [data, meta];
}

class DataEntity extends Equatable {
  final String id;
  final String title;

  const DataEntity({required this.id, required this.title});

  @override
  List<Object> get props => [id, title];
}

class MetaEntity extends Equatable {
  final String currentPage;
  final int lastPage;
  final int totalItems;
  final String perPage;

  const MetaEntity({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.totalItems,
  });

  @override
  List<Object> get props => [currentPage, lastPage, totalItems, perPage];
}
